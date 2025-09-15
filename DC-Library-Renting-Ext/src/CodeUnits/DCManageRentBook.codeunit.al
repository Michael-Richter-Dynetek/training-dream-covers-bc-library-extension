codeunit 50200 "DC Manage Rent Book Code"
{

    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////
    // Events
    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////


    [IntegrationEvent(false, false)]
    local procedure OnReturnBookEvent(var DCLibraryBookListTable: Record "DC Library Book List Table"; IsHandled: Boolean)
    begin
    end;


    [IntegrationEvent(false, false)]
    local procedure OnRentBookEvent(var DCLibraryBookListTable: Record "DC Library Book List Table"; IsHandled: Boolean)
    begin
    end;





    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////
    // Variables
    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////



    //var



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
        OldCustomerID: Text;
        AllowedToRent: Boolean;
        CustomerRentedBook: Label 'The customer "%1" is now renting the book "%2"';
        BookAlreadyRentedError: Label 'This book is already being rented.';
    begin
        AllowedToRent := true;

        if DCLibraryBookListTable."Customer Renting ID" <> '' then begin
            Error(BookAlreadyRentedError);
            exit;
        end;

        if Page.RunModal(Page::"DC Rent Book Page", DCLibraryBookListTable) = Action::LookupOK then begin
            if (DCLibraryBookListTable."Customer Renting ID" <> '') then begin
                DCLibraryBookListTable."Rented Amount" += 1;
                DCLibraryBookListTable.Validate("Date Rented", Today);
                DCLibraryBookListTable.Validate("Date Returned", 0D);
                DCLibraryBookListTable.Validate("Renting Status", Enum::"DC Book Renting Status"::" ");
                DCLibraryBookListTable."Customer Renting Name" := Customer.Name;
                Customer.Get(DCLibraryBookListTable."Customer Renting ID");
                Customer."Books Rented" += 1;
                Customer.Modify(true);
                Message(CustomerRentedBook, Customer.Name, DCLibraryBookListTable.Title);
                DCLibraryBookListTable.Modify();

                OnRentBookEvent(DCLibraryBookListTable, false);
            end;


        end;

    end;

    
    /// <summary>
    /// RentMulitpleBooks.
    /// </summary>
    /// <param name="DCLibraryBookListTable">VAR Record "DC Library Book List Table".</param>
    procedure RentMulitpleBooks(var DCLibraryBookListTable: Record "DC Library Book List Table");
    var
        Customer: Record Customer;
        InvalidBookList: List of [Text];
        CustomerRentedBook: Label 'The customer "%1" is now renting multiple book';
        BooksAlreadyRentedError: Label 'The book/s "%1" have already been rented.';
        RentableBooks: Boolean;
        FirstInstance: Boolean;
        DisplayInvalidBooks, InvalidBook : Text;
    begin
        RentableBooks := true;
        FirstInstance := true;

        if DCLibraryBookListTable.FindSet() then
            repeat
                if DCLibraryBookListTable."Customer Renting ID" <> '' then begin
                    RentableBooks := false;
                    InvalidBookList.Add(DCLibraryBookListTable.Title);
                end;
            until DCLibraryBookListTable.Next() = 0;


        if not RentableBooks then begin
            foreach InvalidBook in InvalidBookList do begin
                if FirstInstance then begin
                    FirstInstance := false;
                    DisplayInvalidBooks += InvalidBook;
                end
                else
                    DisplayInvalidBooks += ', ' + InvalidBook;
            end;

            //Error(BooksAlreadyRentedError, DisplayInvalidBooks);
        end;

        DCLibraryBookListTable.FindFirst();

        //BookNumber := DCLibraryBookListTable."Book Number";
        if Page.RunModal(Page::"DC Rent Multiple Books Page", DCLibraryBookListTable) = Action::LookupOK then begin
            if DCLibraryBookListTable."Customer Renting ID" <> '' then begin
                DCLibraryBookListTable.FindFirst();
                Customer.Get(DCLibraryBookListTable."Customer Renting ID");
                repeat
                    DCLibraryBookListTable.Validate("Customer Renting ID", Customer."No.");
                    DCLibraryBookListTable."Rented Amount" += 1;
                    DCLibraryBookListTable.Validate("Date Rented", Today);
                    DCLibraryBookListTable.Validate("Date Returned", 0D);
                    DCLibraryBookListTable.Validate("Renting Status", Enum::"DC Book Renting Status"::" ");
                    DCLibraryBookListTable."Customer Renting Name" := Customer.Name;
                    DCLibraryBookListTable.Modify(true);
                    Customer."Books Rented" += 1;
                    //DCLibraryBookListTable."Customer Renting Name" := Customer.Name;

                    OnRentBookEvent(DCLibraryBookListTable, false);

                until DCLibraryBookListTable.Next() = 0;

                Customer.Modify(true);
                Message(CustomerRentedBook, Customer.Name);
            end
            else
                Error('No Customer has been Inserted to rent multiple books.');
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
        ReturnBookConfirm: label 'Are you sure you would like to return "%1"?';
        BookReturnMessage: Label 'The Book "%1" has been returned';
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

    procedure ReturnMultipleBooks(var DCLibraryBookListTable: Record "DC Library Book List Table")
    var
        Customer: Record Customer;
        CustomerID: Code[20];
        BookNotRentedError: Label 'The books "%1" can not be returned, since they have not been rented.';
        ReturnableBooks, FirstInstance : Boolean;
        InvalidBookList: List of [Text];
        InvalidBook, DisplayInvalidBooks, DisplayReturnedBooks : Text;

        ReturnBookConfirm: label 'Are you sure you would like to return multiple books?';
        BookReturnMessage: Label 'The Books "%1" have been returned';
    begin
        FirstInstance := true;
        ReturnableBooks := true;

        /*if DCLibraryBookListTable."Customer Renting ID" = '' then begin
            Error(BookNotRentedError);
            exit;
        end;*/

        repeat
            if DCLibraryBookListTable."Customer Renting ID" = '' then begin
                ReturnableBooks := false;
                InvalidBookList.Add(DCLibraryBookListTable.Title);
            end;
        until DCLibraryBookListTable.Next() = 0;


        if not ReturnableBooks then begin
            foreach InvalidBook in InvalidBookList do begin
                if FirstInstance then begin
                    FirstInstance := false;
                    DisplayInvalidBooks += InvalidBook
                end
                else
                    DisplayInvalidBooks += ', ' + InvalidBook;
            end;

            Error(BookNotRentedError, DisplayInvalidBooks);
        end;

        DCLibraryBookListTable.FindFirst();

        if Confirm(ReturnBookConfirm, false, DCLibraryBookListTable.Title) then begin
            //library section
            //TODO put this in a sothat all the books can be returned simultaniously

            repeat
                //Message(DCLibraryBookListTable."Customer Renting ID");
                OnReturnBookEvent(DCLibraryBookListTable, false);
                CustomerID := DCLibraryBookListTable."Customer Renting ID";
                // this is necessary
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
                if ReturnableBooks then begin
                    ReturnableBooks := false;
                    DisplayReturnedBooks += DCLibraryBookListTable.Title;
                end
                else
                    DisplayReturnedBooks += ', ' + DCLibraryBookListTable.Title;


            until DCLibraryBookListTable.Next() = 0;

            Message(BookReturnMessage, DisplayReturnedBooks);
        end;



    end;



}