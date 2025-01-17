/// <summary>
/// This page will be used to add a book to the table
/// </summary>
page 50102 "Add Book Page"
{
    Caption = 'Add a Book';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Library Book List Table";


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
                }
                field(Author; Rec.Author)
                {
                    Caption = 'Author';
                    Editable = true;
                }
                field(Genre; Rec.Genre)
                {
                    Caption = 'Genre';
                }
            }
            group("Book Series")
            {
                Caption = 'Book Series';
                field(Series; Rec.Series)
                {
                    Caption = 'Series';
                }
                field(Prequel; Rec.PrequelName)
                {
                    Caption = 'Prequel';
                }
                field(Sequel; Rec.Sequel)
                {
                    Caption = 'Sequel';
                }
            }
            group("More Information")
            {
                Caption = 'More Information';

                field(Publisher; Rec.Publisher)
                {
                    Caption = 'Publisher';
                }
                field("Publication Date"; Rec."Publication Date")
                {
                    Caption = 'Publication Date';
                }
                field("Book Price"; Rec."Book Price")
                {
                    Caption = 'Price';
                }
                field(Pages; Rec.Pages)
                {
                    Caption = 'Number';
                }

            }
        }
    }
}