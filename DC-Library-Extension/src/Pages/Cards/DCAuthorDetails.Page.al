page 50110 "DC Author Details"
{
    Caption = 'Author';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "DC Author";
    Editable = false;

    layout
    {
        area(Content)
        {
            group("Author")
            {
                field("Author Name"; Rec."Author Name")
                {
                    ToolTip = 'Specifies the value of the Author Name field.', Comment = '%';
                }
                field(Bio; Rec.Bio)
                {
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Bio field.', Comment = '%';
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ToolTip = 'Specifies the value of the Birth date field.', Comment = '%';
                }
                field("Death Date"; Rec."Death Date")
                {
                    ToolTip = 'Specifies the value of the Death Date field.', Comment = '%';
                }
                field("Work Count"; Rec."Work Count")
                {
                    ToolTip = 'Specifies the value of the Work Count field.', Comment = '%';
                }
                field("Best Work"; Rec."Best Work")
                {

                }
            }
            group("Author Books")
            {
                part(AuthorBooksCardPage; "Author Books Card Page")
                {
                    Caption = 'Author Books';
                    SubPageLink = "Book Number" = field("Author Books Filter");
                }
            }//TODO implement the previous code here to display all of the books related to the author.
        }
        area(FactBoxes)
        {
            part(AuthorCoverCardPart; "DC Author Cover Card Part")
            {
                SubPageLink = "Author ID" = field("Author ID");
            }
        }



    }

    actions
    {
        area(Processing)
        {
            action(RemoveBook)
            {
                Image = RemoveLine;
                Caption = 'Remove Book';
                ApplicationArea = all;

                trigger OnAction()
                var
                    DCBooksAuthors: Record "DC Book Authors";
                    BookTitleDeleted: Text;
                    ConfirmDeleteMessage: Label 'Are you sure you would like to remove the author "%1"';
                    AuthorDeleteMessage: Label 'The Author "%1" has been deleted.';
                begin

                    if Confirm(ConfirmDeleteMessage, false, Rec."Author Name") then begin
                        DCBooksAuthors.SetRange("Author ID", Rec."Author ID");
                        DCBooksAuthors.DeleteAll();
                        BookTitleDeleted := Rec."Author Name";
                        Rec.Delete();
                        Message(AuthorDeleteMessage, BookTitleDeleted);
                    end;
                end;
            }

            action(UploadImage)
            {
                Image = Picture;
                Caption = 'Upload Author Cover';
                ToolTip = 'This will insert a manual image for the book.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    GetImage: InStream;
                    Filename: Text;
                begin
                    if not UploadIntoStream('Upload Image', '', '', Filename, GetImage) then
                        exit;

                    Rec."Author Cover Image".ImportStream(GetImage, '');
                    //Rec.Validate("Book Cover Filename", Filename);
                    Rec.Modify(true);
                    CurrPage.Update(true);
                end;

            }

            action(RetrieveImage)
            {
                Image = Picture;
                Caption = 'Retrieve Author Cover';
                ToolTip = 'This will insert a manual image for the book.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TempBlob: Codeunit "Temp Blob";
                    GetImage: OutStream;
                    DownloadImage: InStream;
                    Filename: Text;
                begin
                    Filename := Rec."Author Name" + '.png';

                    if not Rec."Author Cover Image".HasValue then
                        exit;

                    TempBlob.CreateOutStream(GetImage, TextEncoding::Windows);
                    Rec."Author Cover Image".ExportStream(GetImage);
                    TempBlob.CreateInStream(DownloadImage, TextEncoding::Windows);
                    DownloadFromStream(DownloadImage, 'Download Author Image', '', '', Filename);
                end;

            }
        }

    }

    trigger OnAfterGetRecord()
    var
    begin
        GenerateBookFilter();
    end;

    local procedure GenerateBookFilter()
    var
        DCBookAuthors: Record "DC Book Authors";
        AuthorBooks: Text[2048];
        FirstBook: Boolean;
    begin
        AuthorBooks := '';
        FirstBook := true;
        DCBookAuthors.SetRange("Author ID", Rec."Author ID");
        if DCBookAuthors.FindSet() then
            repeat
                if FirstBook then begin
                    AuthorBooks += DCBookAuthors."Book Number";
                    FirstBook := false;
                end else
                    AuthorBooks += '|' + DCBookAuthors."Book Number";
            until DCBookAuthors.Next() = 0;

        if AuthorBooks <> Rec."Author Books Filter" then begin
            Rec.SetFilter("Author Books Filter", AuthorBooks);
            Rec.Modify();
        end;
    end;
}