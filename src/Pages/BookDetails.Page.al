/// <summary>
/// This Page will be used to display a single book's details
/// </summary>
page 50101 "Book Details"
{
    Caption = 'Book Details';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Library Book List Table";




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
                    Editable = false;

                }
                field(Title; Rec.Title)
                {
                    Caption = 'Title';
                }
                field(Author; Rec.Author)
                {
                    Caption = 'Author';
                }
            }
            group("Renting Information")
            {
                Caption = 'Renting Information';
                field("Book Price"; Rec."Book Price")
                {
                    Caption = 'Price';
                }
                field(Rented; Rec.Rented)
                {
                    Caption = 'Rented';
                }
                field("Customer Renting"; Rec."Customer Renting")
                {
                    Caption = 'Customer Renting Book';
                }
                field("Rented Amount"; Rec."Rented Amount")
                {
                    Caption = 'Rented Amount';
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
                field(Genre; Rec.Genre)
                {
                    Caption = 'Genre';
                }

                field(Publisher; Rec.Publisher)
                {
                    Caption = 'Publisher';
                }
                field("Publication Date"; Rec."Publication Date")
                {
                    Caption = 'Publication Date';
                }
                field(Pages; Rec.Pages)
                {
                    Caption = 'Number';
                }
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

                trigger OnAction()
                begin
                    Rec.Delete();
                end;
            }
            action(AddSequel)
            {
                Caption = 'Add A Sequel';

                trigger OnAction()
                var
                    displayBooks: Codeunit "Add Book Code";
                begin
                    displayBooks.AddExistingSeries(Rec);
                end;
            }
        }
    }

    var
        IsEditing: Boolean;
}