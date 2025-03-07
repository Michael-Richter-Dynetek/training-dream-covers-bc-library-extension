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
                field(Title; Rec.Title) { }
                field(Author; Rec.Author) { }
                field("Book Key"; Rec."Book Key") { }

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
                    DCLibraryOnlineBooks: Codeunit "DC Library Online Books C";
                begin
                    DCLibraryBookListTable.Init();
                    // run procedure to check author
                    StoreAuthorTitle(DCLibraryBookListTable);
                    DCLibraryOnlineBooks.GetBookPagesAndPublish(DCLibraryBookListTable, Rec."Book Key");
                    DCLibraryOnlineBooks.GetBookDescription(DCLibraryBookListTable, Rec."Book Key");
                    // run procedure to get publication date and page amount
                    DCLibraryBookListTable.Insert(true);
                end;
            }
        }
    }

    local procedure StoreAuthorTitle(var DCLibraryBookListTable: Record "DC Library Book List Table")
    begin
        DCLibraryBookListTable.Validate(Title, Rec.Title);
        DCLibraryBookListTable.Validate("Author Name", Rec.Author);
    end;
}