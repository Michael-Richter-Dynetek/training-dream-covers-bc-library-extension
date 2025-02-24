codeunit 50206 "DC Rent Return Log Code"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"DC Manage Rent Book Code", OnRentBookEvent, '', false, false)]
    local procedure LogRentedBook(DCLibraryBookListTable: Record "DC Library Book List Table"; IsHandled: Boolean)
    var
        DCRentedBooksLogTable: Record "DC Rented Books Log Table";
    begin
        DCRentedBooksLogTable.Init();
        DCRentedBooksLogTable.Validate("Book Number", DCLibraryBookListTable."Book Number");
        DCRentedBooksLogTable.Validate(Title, DCLibraryBookListTable.Title);
        DCRentedBooksLogTable.Validate("Rented/Returned", Enum::"DC Rented Returned Enum"::Rented);
        DCRentedBooksLogTable.Validate("Customer Renting Name", DCLibraryBookListTable."Customer Renting Name");
        DCRentedBooksLogTable.Validate("Date Time log", CurrentDateTime);
        
        DCRentedBooksLogTable.Insert();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"DC Manage Rent Book Code", OnReturnBookEvent, '', false, false)]
    local procedure LogReturnedBook(DCLibraryBookListTable: Record "DC Library Book List Table"; IsHandled: Boolean)
    var
        DCRentedBooksLogTable: Record "DC Rented Books Log Table";
        WeirdError: Label 'There is no book to link ';
        DateTimeReturned: Code[20];
    begin
        if IsHandled then
            exit;



        DCRentedBooksLogTable.Init();
        DCRentedBooksLogTable.Validate("Book Number", DCLibraryBookListTable."Book Number");
        DCRentedBooksLogTable.Validate(Title, DCLibraryBookListTable.Title);
        DCRentedBooksLogTable.Validate("Rented/Returned", Enum::"DC Rented Returned Enum"::Returned);
        DCRentedBooksLogTable.Validate("Customer Renting Name", DCLibraryBookListTable."Customer Renting Name");
        DCRentedBooksLogTable.Validate("Date Time log", System.CurrentDateTime);

        if Today - DCLibraryBookListTable."Date Rented" = 0 then
            DCRentedBooksLogTable.Validate("Days Rented", 1)
        else
            DCRentedBooksLogTable.Validate("Days Rented", Today - DCLibraryBookListTable."Date Rented");

        DCRentedBooksLogTable.Insert(true);



        DCRentedBooksLogTable.SetFilter("Book Number", DCLibraryBookListTable."Book Number");
        DCRentedBooksLogTable.SetFilter("Rented/Returned", 'Rented');
        DCRentedBooksLogTable.SetCurrentKey("Log ID");
        DCRentedBooksLogTable.Ascending(false);


        if DCRentedBooksLogTable.FindSet() then begin
            DCRentedBooksLogTable.FindFirst();
            if Today - DCLibraryBookListTable."Date Rented" = 0 then
                DCRentedBooksLogTable.Validate("Days Rented", 1)
            else
                DCRentedBooksLogTable.Validate("Days Rented", Today - DCLibraryBookListTable."Date Rented");
            DCRentedBooksLogTable.Modify();
        end
        else
            Error(WeirdError);
        //DCRentedBooksLogTable.SetFilter("Date Rented", ConvertStr(DCLibraryBookListTable."Date Rented"));
    end;

}