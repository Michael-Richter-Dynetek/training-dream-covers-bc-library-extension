page 50250 "DC Library Online Books"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "DC Library Online Books";
    //SourceTableTemporary = true;
    Caption = 'Add Online Books';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(OnlineBookList)
            {
                Caption = 'Online Book List';
                field(Title; Rec.Title)
                {
                    Caption = 'Book Title';
                }
                field(Author; Rec.Author)
                {
                    Caption = 'Author/s';
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Add Book")
            {
                Caption = 'Add Book';
                ToolTip = 'This Allows you to Add Book to Library.';
                Image = Add;

                trigger OnAction()
                var
                    DCLibraryBookListTable: Record "DC Library Book List Table";

                    BookAddedLabel: Label 'The Book "%1" has been added to the library.';
                    AuthorList: List of [Text];
                    UnabbleAddBook: Label 'Unable to add book with title "%1", due to data retrieval error.';
                begin //TODO SETSELECTION FILTER, loop through
                    CurrentBookCount := 0;
                    CurrentTotalBookCount := 0;
                    CurrentTotalAuthorCount := 0;

                    CurrPage.SetSelectionFilter(Rec);
                    if Rec.FindFirst() then begin
                        Window.Open(WindowMessage, CurrentBookCount, CurrentTotalBookCount, CurrentAuthorCount, CurrentTotalAuthorCount);
                        CurrentTotalBookCount := Rec.Count;
                        repeat
                            CurrentBookCount += 1;
                            AuthorList := Rec.Author.Split(', ');
                            CurrentAuthorCount := 0;
                            CurrentTotalAuthorCount := AuthorList.Count;
                            Window.Update();

                            // run procedure to get publication date and page amount
                            if RetrieveBookInformation(DCLibraryBookListTable) then begin
                                DCLibraryBookListTable.Insert(true);
                                StoreAuthor(DCLibraryBookListTable, AuthorList);
                                Message(BookAddedLabel, Rec.Title);
                            end
                            else
                                Message(UnabbleAddBook, Rec.Title);


                        until Rec.Next() = 0;
                        Window.Close();
                    end;
                    System.Clear(Rec);

                end;
            }
        }
    }

    [TryFunction]
    local procedure RetrieveBookInformation(var DCLibraryBookListTable: Record "DC Library Book List Table")
    var
        DCLibraryOnlineBooks: Codeunit "DC Library Online Books C";
    begin
        DCLibraryBookListTable.Init();
        // run procedure to check author
        StoreTitle(DCLibraryBookListTable);
        DCLibraryOnlineBooks.GetBookPagesAndPublish(DCLibraryBookListTable, Rec."Book Key");
        DCLibraryOnlineBooks.GetBookDescription(DCLibraryBookListTable, Rec."Book Key");
        DCLibraryOnlineBooks.GetBookCover(DCLibraryBookListTable, Rec."Cover Key");
    end;

    local procedure StoreTitle(var DCLibraryBookListTable: Record "DC Library Book List Table")
    begin
        DCLibraryBookListTable.Validate(Title, Rec.Title);
        //DCLibraryBookListTable.Validate("Author Name", Rec.Author);
        // DCLibraryBookListTable.Validate("Author ID", DCLibraryOnlineBooks.TestAuthorAlreadyExist(Rec.Author));
    end;

    local procedure StoreAuthor(var DCLibraryBookListTable: Record "DC Library Book List Table"; AuthorList: List of [Text])
    var
        DCLibraryOnlineBooks: Codeunit "DC Library Online Books C";
        DCBooksAuthors: Record "DC Book Authors";
        BookNumber: Code[20];
        AuthorName, AuthorID : Text;

    begin
        // DCLibraryBookListTable.Validate("Author ID", DCLibraryOnlineBooks.TestAuthorAlreadyExist(Rec.Author));
        BookNumber := DCLibraryBookListTable."Book Number";

        foreach AuthorName in AuthorList do begin
            CurrentAuthorCount += 1;
            Window.Update();
            AuthorID := DCLibraryOnlineBooks.TestAuthorAlreadyExist(AuthorName);
            DCBooksAuthors.Reset();
            DCBooksAuthors.SetFilter("Book Number", BookNumber);
            DCBooksAuthors.SetFilter("Author ID", AuthorID);


            if not DCBooksAuthors.FindSet() then begin
                DCBooksAuthors.Init();
                DCBooksAuthors.Validate("Book Number", BookNumber);
                DCBooksAuthors.Validate("Author ID", AuthorID);
                DCBooksAuthors.Insert();
            end;
        end;
    end;

    var
        Window: Dialog;
        WindowMessage: Label 'Processing #1####### of #2####### Books and #3####### of #4####### Authors.';
        CurrentBookCount, CurrentAuthorCount, CurrentTotalBookCount, CurrentTotalAuthorCount : Integer;
}