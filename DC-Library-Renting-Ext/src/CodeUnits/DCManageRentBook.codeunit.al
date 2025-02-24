codeunit 50200 "DC Manage Rent Book Code"
{

    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////
    // Events
    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////


    [IntegrationEvent(false, false)]
    local procedure OnReturnBookEvent(DCLibraryBookListTable: Record "DC Library Book List Table"; IsHandled: Boolean)
    begin
    end;


    [IntegrationEvent(false, false)]
    local procedure OnRentBookEvent(DCLibraryBookListTable: Record "DC Library Book List Table"; IsHandled: Boolean)
    begin
    end;





    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////
    // Variables
    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////



    var
        ReturnBookConfirm: label 'Are you sure you would like to return "%1"';
        BookReturnMessage: Label 'The Book "%1" has been returned';


    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////
    // RENT BOOK
    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////



    /// <summary>
    /// This will take a "DC Library Book List Table" record and all local procedures related to renting a book.
    /// </summary>
    /// <param name="DCLibraryBookListTable">Record "Library Book List Table".</param>
    procedure RunRentBookCode(DCLibraryBookListTable: Record "DC Library Book List Table");
    begin
        RentBook(DCLibraryBookListTable);
    end;


    // This function functions
    local procedure RentBook(DCLibraryBookListTable: Record "DC Library Book List Table");
    var

        Customer: Record Customer;
        OldCustomerID: Text[100];
        AllowedToRent: Boolean;
        //BookNumber: Code[20];
        CustomerRentedBook: Label 'The customer "%1" is now renting the book "%2"';
        BookAlreadyRentedError: Label 'This book is already being rented.';
    begin
        AllowedToRent := true;
        OldCustomerID := DCLibraryBookListTable."Customer Renting ID";

        if DCLibraryBookListTable."Customer Renting ID" <> '' then begin
            Error(BookAlreadyRentedError);
            exit;
        end;

        //BookNumber := DCLibraryBookListTable."Book Number";

        if Page.RunModal(Page::"DC Rent Book Page", DCLibraryBookListTable) = Action::LookupOK then begin
            if (OldCustomerID <> DCLibraryBookListTable."Customer Renting ID") and (DCLibraryBookListTable."Customer Renting ID" <> '') then begin
                DCLibraryBookListTable."Rented Amount" += 1;
                DCLibraryBookListTable.Validate("Date Rented", Today);
                DCLibraryBookListTable.Validate("Date Returned", 0D);
                DCLibraryBookListTable.Validate("Renting Status", Enum::"DC Book Renting Status"::" ");

                Customer.Get(DCLibraryBookListTable."Customer Renting ID");
                Customer."Books Rented" += 1;
                Customer.Modify(true);
                Message(CustomerRentedBook, Customer.Name, DCLibraryBookListTable.Title);
                DCLibraryBookListTable.Modify();
                //DCLibraryBookListTable.Get(DCLibraryBookListTable."Book Number");
                OnRentBookEvent(DCLibraryBookListTable, false);
            end;


        end;

    end;




    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////
    // RETURN BOOK
    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////


    //[EventSubscriber(ObjectType::Codeunit, Codeunit::"DC Manage Rent Book Code", OnReturnBookEvent, '', false, false)]

    /// <summary>
    /// ReturnBook.
    /// This Procedure returns a book.
    /// This checks if the user wants to return a book.
    /// If the book is returned a message will display telling wat book was returned.
    /// </summary>
    /// <param name="DCLibraryBookListTable">Record "DC Library Book List Table".</param>
    procedure ReturnBook(DCLibraryBookListTable: Record "DC Library Book List Table"; IsHandled: Boolean)
    var
        Customer: Record Customer;
        CustomerID: Code[20];
        BookNotRentedError: Label 'You cant return a book that is not being rented';
    begin
        if IsHandled then
            exit;
        if DCLibraryBookListTable."Customer Renting ID" = '' then begin
            Error(BookNotRentedError);
            exit;
        end;

        if Confirm(ReturnBookConfirm, false, DCLibraryBookListTable.Title) then begin
            //library section
            OnReturnBookEvent(DCLibraryBookListTable, false);

            CustomerID := DCLibraryBookListTable."Customer Renting ID"; // this is necessary
            DCLibraryBookListTable.Validate("Customer Renting ID", '');
            //DCLibraryBookListTable.Validate("Customer Renting Name", '');
            DCLibraryBookListTable."Customer Renting Name" := '';
            DCLibraryBookListTable.Validate(Rented, false);
            DCLibraryBookListTable.Validate("Date Rented", 0D);
            DCLibraryBookListTable.Validate("Date Returned", Today);
            DCLibraryBookListTable.Validate("Renting Status", Enum::"DC Book Renting Status"::" ");
            DCLibraryBookListTable.Modify(true);


            //customer section
            Customer.Get(CustomerID);
            Customer."Books Rented" -= 1;
            Customer.Modify(true);
            Message(BookReturnMessage, DCLibraryBookListTable.Title);

        end;



    end;



}