/// <summary>
/// Codeunit DC Manage Books Code (ID 50108).
/// This codeunit will be used to handle any and all action relating to books.
/// </summary>
codeunit 50100 "DC Manage Books Code"
{
    // these are all the message texts when a task is completed and the user has to be notified.
    var
        SerriesCreationLabel: Label 'The Series "%1" has been created';
        SequelCreationLabel: Label 'The Sequel "%1" has been created';
        BookCreationLabel: Label 'The Book "%1" has been created';
        ConfirmDeleteMessage: Label 'Are you sure you would like to remove "%1" from the library.';
        BookDeleteMessage: Label 'The book "%1" has been removed.';


    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////
    // ADD BOOK
    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////


    /// <summary>
    /// NavigateToAddBookPage.
    /// this procedure is responsible for navigating to the add book page and saving the book added.
    /// </summary>
    procedure NavigateToAddBookPage();
    var
        TempBookRecord: Record "DC Library Book List Table" temporary;
        SaveBook: Codeunit "DC Save Temporary Book Record";
        AddBookPage: Page "Add Book Page";
        BookNotSavedMess: Label 'The book could not be saved since the title was empty.';
        BookNumber: Code[20];
    begin
        TempBookRecord.Init();
        TempBookRecord.Insert(false);

        if Page.RunModal(Page::"Add Book Page", TempBookRecord) = Action::LookupOK then begin
            if not (TempBookRecord.Title = '') then begin
                BookNumber := SaveBook.SaveTempBook(TempBookRecord);
                SaveBook.SaveAuthorsToBook(BookNumber);
                Message(BookCreationLabel, TempBookRecord.Title);
            end
            else
                Message(BookNotSavedMess);
        end;
    end;




    /// <summary>
    /// this procedure adds a sequel and series, related to the current record past through
    /// </summary>
    /// <param name="DCLibraryBookListTable">Record "DC Library Book List Table".</param>
    procedure AddSequelAndSeries(DCLibraryBookListTable: Record "DC Library Book List Table");
    var
        TempRecord: Record "DC Library Book List Table" temporary;
        DCBookAuthors: Record "DC Book Authors";
        BookDetailsPage: Page "DC Book Details";
        DCSaveTemporaryBookRecord: Codeunit "DC Save Temporary Book Record";
        CopyFromBookNumber: Code[20];
        ReadyToAddBook: Boolean;
        BookSequel: Text[100];
    begin
        BookSequel := '';
        ReadyToAddBook := false;
        //CopyFromBookNumber := DCLibraryBookListTable."Book Number";



        //get the current book series
        //if there is no book current book series, the user will be prompted to add a series and that series if entered will be added to new book.
        If (DCLibraryBookListTable.Series = '') then
            if (Page.RunModal(Page::"DC Enter Series", DCLibraryBookListTable) = Action::LookupOK) and not ((DCLibraryBookListTable.Series = '') or (DCLibraryBookListTable.Series = 'None')) then begin
                ReadyToAddBook := true;
                //BookSeries := DCLibraryBookListTable.Series;
                Message(SerriesCreationLabel, DCLibraryBookListTable.Series);
            end
            else
                ReadyToAddBook := true;


        // if the series exists then the current author, title and series will be transferred and fill the add new book page
        // after the sequel book has been made, the sequel book will send back its title to save as the Prequels Sequel field
        if (ReadyToAddBook = true) then begin
            TempRecord := AddSequel(DCLibraryBookListTable);
            BookSequel := TempRecord.Title;
            DCLibraryBookListTable.SetFilter("Book Number", '%1', DCLibraryBookListTable."Book Number");
            CopyFromBookNumber := DCLibraryBookListTable."Book Number";
            DCLibraryBookListTable.FindFirst();

            if BookSequel <> '' then begin
                DCLibraryBookListTable.Validate("Sequel Name", BookSequel);
                DCLibraryBookListTable.Modify();

                System.Clear(DCLibraryBookListTable);
                DCLibraryBookListTable.Init();
                TempRecord.Validate("Date Added", WorkDate());
                TempRecord.Modify();
                DCLibraryBookListTable := TempRecord;
                DCLibraryBookListTable.Insert(true);

                //TODO add here
                DCBookAuthors := DCSaveTemporaryBookRecord.CopyAuthorsToBook(CopyFromBookNumber, DCLibraryBookListTable."Book Number");
                DCBookAuthors.Modify();
                DCBookAuthors.SetRange("Book Number", '');
                DCBookAuthors.DeleteAll();
            end;
            exit;

        end;


    end;

    // this procedure will create a new book, and send back the title back to the procedure calling it.
    // if no book is created this function will delete any unnecessary records made in the process of executing.
    local procedure AddSequel(/*BookSeries: Text[100]; BookAuthor: Text[100]; BookTitle: Text[100]; */DCLibraryBookListTable: Record "DC Library Book List Table"): Record "DC Library Book List Table" temporary
    var
        SequelTitle: Text[100];
        CurrentRecord: Record "DC Library Book List Table" temporary;
    begin
        SequelTitle := '';

        CurrentRecord.Init();
        CurrentRecord.Validate(Series, DCLibraryBookListTable.Series);
        //CurrentRecord.Validate("Author Name", DCLibraryBookListTable."Author Name");// TODO AUTHOR

        CurrentRecord.Validate("Prequel Name", DCLibraryBookListTable."Prequel Name");
        CurrentRecord.Validate(Publisher, DCLibraryBookListTable.Publisher);
        CurrentRecord.Validate(Genre, DCLibraryBookListTable.Genre);
        CurrentRecord.Validate("Book Price", DCLibraryBookListTable."Book Price");
        CurrentRecord.Insert(true);


        if (Page.RunModal(Page::"Add Book Page", CurrentRecord) = Action::LookupOK) and not (CurrentRecord.Title = '') then begin
            SequelTitle := CurrentRecord.Title;
            Message(SequelCreationLabel, CurrentRecord.Title);

            exit(CurrentRecord);
        end;

        CurrentRecord.Delete(true);
        exit(CurrentRecord);
    end;

    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////
    // REMOVE BOOK
    //////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////


    /// <summary>
    /// This procedure will remove the given book in the record.
    /// </summary>
    /// <param name="DCLibraryBookListTable">Record "DC Library Book List Table".</param>
    procedure RemoveBook(DCLibraryBookListTable: Record "DC Library Book List Table")
    var
        BookTitleDeleted: Text[100];
        DCBooksAuthors: Record "DC Book Authors";
    begin
        if Confirm(ConfirmDeleteMessage, false, DCLibraryBookListTable.Title) then begin
            DCBooksAuthors.SetRange("Book Number", DCLibraryBookListTable."Book Number");
            DCBooksAuthors.DeleteAll();
            BookTitleDeleted := DCLibraryBookListTable.Title;
            DCLibraryBookListTable.Delete();
            Message(BookDeleteMessage, BookTitleDeleted);
        end;

    end;






}