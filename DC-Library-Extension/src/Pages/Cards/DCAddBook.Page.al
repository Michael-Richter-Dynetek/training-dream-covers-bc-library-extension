/// <summary>
/// This page will be used to add a book to the table
/// </summary>
page 50102 "Add Book Page"
{
    Caption = 'Add a Book';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "DC Library Book List Table";


    layout
    {

        area(Content)
        {
            /// <summary>
            /// These are all the fields that the user should insert to add a book
            /// </summary>

            group("Main Information")
            {
                Caption = 'Main Information';
                field(Title; Rec.Title)
                {
                    Caption = 'Title';
                    Enabled = true;
                    ApplicationArea = All;
                    ToolTip = 'Enter the Title of the book.';
                }
                field(Author; Rec."Author Name")
                {
                    Caption = 'Author';
                    //Editable = true;
                    ApplicationArea = All;
                    ToolTip = 'Enter the Author of the book.';

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
                }
                field(Genre; Rec.Genre)
                {
                    Caption = 'Genre';
                    ApplicationArea = All;
                    ToolTip = 'Enter the Genre of the book.';

                    /*trigger OnAssistEdit()
                    var
                    //DCGenreTable: Record "DC Genre Table";
                    begin
                        if Page.RunModal(Page::"DC Genre List Page", DCGenreTable) = Action::LookupOK then begin
                            //Rec.Validate("Genre ID", DCGenreTable."Genre ID");
                            //Rec.Validate(Genre, DCGenreTable.Genre);
                            Rec.Modify();
                        end;
                    end;*/
                }
                field("Book Price"; Rec."Book Price")
                {
                    Caption = 'Price';
                    ApplicationArea = All;
                    ToolTip = 'Enter this book"s price';
                }
            }
            group("Book Series")
            {
                Caption = 'Book Series';
                field(Series; Rec.Series)
                {
                    Caption = 'Series';
                    ApplicationArea = All;
                    ToolTip = 'Enter the Series the book is apart of.';
                }
                field(Prequel; Rec."Prequel Name")
                {
                    Caption = 'Prequel';
                    ApplicationArea = All;
                    ToolTip = 'Enter the Prequel name of this book.';
                }
                field(Sequel; Rec."Sequel Name")
                {
                    Caption = 'Sequel';
                    ApplicationArea = All;
                    ToolTip = 'Enter the Sequel name of this book.';
                }
            }
            group("More Information")
            {
                Caption = 'More Information';

                field(Publisher; Rec.Publisher)
                {
                    Caption = 'Publisher';
                    ApplicationArea = All;
                    ToolTip = 'Enter the Publisher name for this book.';
                }
                field("Publication Date"; Rec."Publication Date")
                {
                    Caption = 'Publication Date';
                    ApplicationArea = All;
                    ToolTip = 'Enter the Publication Date for this book';
                }
                field(Pages; Rec."Page Number")
                {
                    Caption = 'Page Number';
                    ApplicationArea = All;
                    ToolTip = 'Enter the total amount of Page Number this Book has.';
                }

            }
        }
    }

    trigger OnOpenPage()
    begin
        //Rec.Insert(false);
    end;

    var
        DCBookGenreEnum: Enum "DC Book Genre Enum";
}