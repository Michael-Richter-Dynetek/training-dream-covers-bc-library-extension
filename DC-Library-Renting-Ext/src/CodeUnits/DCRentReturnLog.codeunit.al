codeunit 50206 "DC Rent Return Log Code"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"DC Manage Rent Book Code", OnRentBookEvent, '', false, false)]
    local procedure LogRentedBook(var DCLibraryBookListTable: Record "DC Library Book List Table"; IsHandled: Boolean)
    var
        DCRentedBooksLogTable: Record "DC Rented Books Log Table";
        ImproperLogRent: Label 'Improper book fields have been entered into the log for book "%1"';
    begin

        if CreateBaseRentReturnLogLine(DCLibraryBookListTable, DCRentedBooksLogTable, Enum::"DC Rented Returned Enum"::Rented) then
            DCRentedBooksLogTable.Insert()
        else
            Message(ImproperLogRent, DCLibraryBookListTable.Title);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"DC Manage Rent Book Code", OnReturnBookEvent, '', false, false)]
    local procedure LogReturnedBook(var DCLibraryBookListTable: Record "DC Library Book List Table"; IsHandled: Boolean)
    var
        DCRentedBooksLogTable: Record "DC Rented Books Log Table";
        WeirdError: Label 'No rented log could be found for the rented book "%1"';
        DateTimeReturned: Code[20];
    begin
        if IsHandled then
            exit;

        if CreateBaseRentReturnLogLine(DCLibraryBookListTable, DCRentedBooksLogTable, Enum::"DC Rented Returned Enum"::Returned) then begin
            if Today - DCLibraryBookListTable."Date Rented" = 0 then
                DCRentedBooksLogTable.Validate("Days Rented", 1)
            else
                DCRentedBooksLogTable.Validate("Days Rented", Today - DCLibraryBookListTable."Date Rented");
            DCRentedBooksLogTable.Insert(true);
        end;

        //Find book rented log to change

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
        else begin
            Message(WeirdError, DCLibraryBookListTable.Title);
        end;
        //DCRentedBooksLogTable.SetFilter("Date Rented", ConvertStr(DCLibraryBookListTable."Date Rented"));
    end;


    [TryFunction]
    local procedure CreateBaseRentReturnLogLine(var DCLibraryBookListTable: Record "DC Library Book List Table"; var DCRentedBooksLogTable: Record "DC Rented Books Log Table"; DCRentedReturned: Enum "DC Rented Returned Enum")
    begin
        DCRentedBooksLogTable.Init();
        DCRentedBooksLogTable.Validate("Book Number", DCLibraryBookListTable."Book Number");
        DCRentedBooksLogTable.Validate(Title, DCLibraryBookListTable.Title);
        DCRentedBooksLogTable.Validate("Rented/Returned", DCRentedReturned);
        DCLibraryBookListTable.CalcFields("Customer Renting Name");
        DCRentedBooksLogTable.Validate("Customer Renting Name", DCLibraryBookListTable."Customer Renting Name");
        DCRentedBooksLogTable.Validate("Date Time log", System.CurrentDateTime);
    end;

}