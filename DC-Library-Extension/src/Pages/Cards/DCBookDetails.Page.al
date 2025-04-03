/// <summary>
/// This Page will be used to display a single book's details
/// </summary>
page 50101 "DC Book Details"
{
    Caption = 'Book Details';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "DC Library Book List Table";


    layout
    {
        area(Content)
        {
            group("Main Information")
            {
                /// <remarks>
                /// These are all the fields related to the Book
                /// </remarks>
                Caption = 'Main Information';
                field("Book Number"; Rec."Book Number")
                {
                    Caption = 'Book Number';
                    Editable = true;
                    ApplicationArea = All;
                    ToolTip = 'This is the auto assigned book Number.';
                    Visible = false;
                }
                field(Title; Rec.Title)
                {
                    Caption = 'Title';
                    ApplicationArea = All;
                    ToolTip = 'This is the book Title.';
                    Editable = true;
                }
                /*field(Author; Rec."Author Name")// TODO AUTHOR
                {
                    Caption = 'Author';
                    ApplicationArea = All;
                    ToolTip = 'This is the book Author.';
                    Editable = true;

                    trigger OnAssistEdit()
                    var
                        DCAuthor: Record "DC Author";
                    begin
                        if Page.RunModal(Page::"DC Author List", DCAuthor) = Action::LookupOK then begin
                            Rec.Validate("Author ID", DCAuthor."Author ID");
                            Rec.Validate("Author Name", DCAuthor."Author Name");
                            Rec.Modify();
                        end;
                    end;

                }*/
                field("Book Cover"; Rec."Book Cover")
                {
                }
            }
            group("Book Series")
            {
                Caption = 'Book Series';
                field(Series; Rec.Series)
                {
                    Caption = 'Series';
                    ApplicationArea = All;
                    ToolTip = 'This is the Series the book is apart of.';
                    Editable = true;
                }
                field(Prequel; Rec."Prequel Name")
                {
                    Caption = 'Prequel';
                    ApplicationArea = All;
                    ToolTip = 'This is the Prequel Title to this book.';
                    Editable = true;
                }
                field(Sequel; Rec."Sequel Name")
                {
                    Caption = 'Sequel';
                    ApplicationArea = All;
                    ToolTip = 'This is the Sequel Title to this book.';
                    Editable = true;
                }
            }
            group("More Information")
            {
                field("Genre ID"; Rec."Genre ID")
                {
                    Caption = 'Genre ID';
                    ApplicationArea = All;
                    ToolTip = 'This is the genre of this book.';
                    //TableRelation = "DC Genre Table";
                }
                field(Genre; Rec.Genre)
                {
                    Caption = 'Genre';
                    ApplicationArea = All;
                    ToolTip = 'This is the genre of this book.';
                    //TableRelation = "DC Genre Table";
                    //Editable = true;

                    /*trigger OnAssistEdit()
                    var
                        DCGenreTable: Record "DC Genre Table";
                    begin
                        if Page.RunModal(Page::"DC Genre List Page", DCGenreTable) = Action::LookupOK then begin
                            Rec.Validate("Genre ID", DCGenreTable."Genre ID");
                            Rec.Validate(Genre, DCGenreTable.Genre);
                            Rec.Modify();
                        end;
                    end;*/
                }

                field(Publisher; Rec.Publisher)
                {
                    Caption = 'Publisher';
                    ApplicationArea = All;
                    ToolTip = 'This is the book publisher.';
                    Editable = true;
                }
                field("Publication Date"; Rec."Publication Date")
                {
                    Caption = 'Publication Date';
                    ApplicationArea = All;
                    ToolTip = 'This is the Publication Date.';
                    Editable = true;
                }
                field(Pages; Rec."Page Number")
                {
                    Caption = 'Page Number';
                    ApplicationArea = All;
                    ToolTip = 'This is the total Amount of pages in the Book.';
                    Editable = true;
                }
            }
            group("Book Authors")
            {

                part(BookAuthorsCardPart; "Book Authors Card Part")
                {
                    Caption = 'Book Authors';
                    // SubPageLink = "Author ID" = field("Book Authors Filter");
                    SubPageLink = "Author ID" = field("Book Authors Filter");
                }
            }
        }
        area(FactBoxes)
        {
            part(BookCover; "DC Book Cover Card Part")
            {
                Caption = 'Book Cover Image';
                //SubPageLink = "Book Cover" = const
                SubPageLink = "Book Number" = field("Book Number");
            }

        }
    }


    actions
    {
        area(Processing)
        {
            /// <summary>
            /// This action will delete the current selected record.
            /// The currently selected record is the record open.
            /// </summary>
            action(Delete)
            {
                Image = RemoveLine;
                Caption = 'Remove Book';
                ToolTip = 'This will remove the current book';
                ApplicationArea = All;

                trigger OnAction()
                var
                    DCManageBooks: Codeunit "DC Manage Books Code";
                begin
                    DCManageBooks.RemoveBook(Rec);
                end;
            }
            action(AddSequel)
            {
                Image = Add;
                Caption = 'Add A Sequel';
                ToolTip = 'This will add a sequel to the current book';
                ApplicationArea = All;

                trigger OnAction()
                var
                    DCManageBooks: Codeunit "DC Manage Books Code";
                begin
                    DCManageBooks.AddSequelAndSeries(Rec);
                end;
            }
            action(UploadImage)
            {
                Image = Picture;
                Caption = 'Upload Book Cover';
                ToolTip = 'This will insert a manual image for the book.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    GetImage: InStream;
                    Filename: Text;
                begin
                    if not UploadIntoStream('Upload Image', '', '', Filename, GetImage) then
                        exit;

                    Rec."Book Cover".ImportStream(GetImage, '');
                    Rec.Validate("Book Cover Filename", Filename);
                    Rec.Modify(true);
                    CurrPage.Update(true);
                end;

            }

            action(RetrieveImage)
            {
                Image = Picture;
                Caption = 'Retrieve Book Cover';
                ToolTip = 'This will insert a manual image for the book.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    TempBlob: Codeunit "Temp Blob";
                    GetImage: OutStream;
                    DownloadImage: InStream;
                    Filename: Text;
                begin
                    if Rec."Book Cover Filename" = '' then
                        Filename := Rec.Title + '.png'
                    else
                        Filename := Rec."Book Cover Filename";
                    //Rec.CalcFields("Book Cover");
                    if not Rec."Book Cover".HasValue then
                        exit;
                    TempBlob.CreateOutStream(GetImage, TextEncoding::Windows);
                    Rec."Book Cover".ExportStream(GetImage);
                    TempBlob.CreateInStream(DownloadImage, TextEncoding::Windows);
                    DownloadFromStream(DownloadImage, 'Download Cover Book', '', '', Filename);
                end;

            }

        }
    }




    trigger OnAfterGetRecord()
    var
        DCAuthor: Record "DC Author";
    begin
        GenerateAuthorFilter();
    end;

    local procedure GenerateAuthorFilter()
    var
        DCBookAuthors: Record "DC Book Authors";
        BookAuthors: Text[2048];
        FirstBook: Boolean;
    begin
        BookAuthors := '';
        FirstBook := true;
        DCBookAuthors.SetRange("Book Number", Rec."Book Number");
        if DCBookAuthors.FindSet() then
            repeat
                if FirstBook then begin
                    BookAuthors += DCBookAuthors."Author ID";
                    FirstBook := false;
                end else
                    BookAuthors += '|' + DCBookAuthors."Author ID";
            until DCBookAuthors.Next() = 0;

        if BookAuthors <> Rec."Book Authors Filter" then begin
            // Rec.Validate("Book Authors Filter", BookAuthors);
            Rec.SetFilter("Book Authors Filter", BookAuthors);
            Rec.Modify(true);
        end;
    end;



    var
        DCBookGenreEnum: Enum "DC Book Genre Enum";
}