/// <summary>
/// This codeunit will be used to navigate to a page and to 
/// </summary>
codeunit 50100 "Add Book Code"
{

    trigger OnRun()
    begin
        NavigateToAddBookPage();
    end;

    local procedure NavigateToAddBookPage();
    var
        TempBookRecord: Record "Library Book List Table" temporary;
        SaveBook: Codeunit "Save Temporary Book Record";
        AddBookPage: Page "Add Book Page";
    begin
        //TempBookRecord.Reset();
        TempBookRecord.Init();
        TempBookRecord.Insert(true);

        if Page.RunModal(Page::"Add Book Page", TempBookRecord) = Action::LookupOK then
            SaveBook.SaveTempBook(TempBookRecord);
        //Page.RunModal(Page::"Add Book Page", TempBookRecord);
    end;

    procedure AddExistingSeries(CurrentRecord: Record "Library Book List Table");
    var
        ReadyToAddBook: Boolean;
        BookSeries: Text[100];
        BookAuhtor: Text[100];
        BookTitle: Text[100];
        BookSequel: Text[100];
        BookID: Integer;
        TempRecord: Record "Library Book List Table" temporary;
        BookDetailsPage: Page "Book Details";
    begin
        BookSequel := '';
        ReadyToAddBook := false;

        BookTitle := CurrentRecord.Title;
        BookID := CurrentRecord."Book Number";
        BookSeries := CurrentRecord.Series;
        BookAuhtor := CurrentRecord.Author;

        If (BookSeries = '') or (BookSeries = 'None') then begin
            if (Page.RunModal(Page::EnterSeries, CurrentRecord) = Action::LookupOK) and not ((CurrentRecord.Series = '') or (CurrentRecord.Series = 'None')) then begin
                ReadyToAddBook := true;
                BookSeries := CurrentRecord.Series;
            end;
        end
        else
            ReadyToAddBook := true;

        if (ReadyToAddBook = true) then begin
            TempRecord := AddSequel(BookSeries, BookAuhtor, BookTitle);
            BookSequel := TempRecord.Title;
            //Message(BookSequel);

            CurrentRecord.SetFilter("Book Number", '%1', BookID);
            CurrentRecord.FindFirst();

            if BookSequel <> '' then begin
                //Message(CurrentRecord.Title);
                //Message(BookSequel);
                CurrentRecord.Sequel := BookSequel;
                CurrentRecord.Modify();

                //Message(CurrentRecord.Sequel);
                // Clear filter to make work
                System.Clear(CurrentRecord);
                CurrentRecord.Init();
                CurrentRecord := TempRecord;
                CurrentRecord.Insert();

            end;

        end;


    end;

    local procedure AddSequel(BookSeries: Text[100]; BookAuhtor: Text[100]; BookTitle: Text[100]): Record "Library Book List Table" temporary
    var
        SequalInfo: array[2] of Text[100];
        SequelTitle: Text[100];
        CurrentRecord: Record "Library Book List Table" temporary;
    begin
        SequelTitle := '';

        CurrentRecord.Init();
        CurrentRecord.Series := BookSeries;
        CurrentRecord.Author := BookAuhtor;
        CurrentRecord.PrequelName := BookTitle;
        CurrentRecord.Insert(true);


        if (Page.RunModal(Page::"Add Book Page", CurrentRecord) = Action::LookupOK) and not ((CurrentRecord.Title = '') or (CurrentRecord.Title = 'None')) then begin
            SequelTitle := CurrentRecord.Title;
            //Message('Book: %1, was successfully added', CurrentRecord.Title);
            exit(CurrentRecord);

        end;

        CurrentRecord.Delete(true);
        exit(CurrentRecord);




    end;

}