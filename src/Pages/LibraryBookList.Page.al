/// <summary>
/// This page will display aal the Books in the library
/// </summary>
page 50100 "Library Book list Page"
{
    Caption = 'Library Book List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Library Book List Table";
    CardPageId = 50101;


    layout
    {
        area(Content)
        {
            repeater(Thing)
            {
                field("Book Number"; Rec."Book Number")
                {
                    Caption = 'Book Number';
                    Visible = false;
                }
                field(Title; Rec.Title)
                {
                    Caption = 'Title';
                }
                field(Author; Rec.Author)
                {
                    Caption = 'Author';
                }
                field(Rented; Rec.Rented)
                {
                    Caption = 'Rented';
                }
                field("Customer Renting"; Rec."Customer Renting")
                {
                    Caption = 'Customer Renting Book';
                    Visible = false;
                }
                field(Series; Rec.Series)
                {
                    Caption = 'Series';
                }
                field(Genre; Rec.Genre)
                {
                    Caption = 'Genre';
                }
                field("Book Price"; Rec."Book Price")
                {
                    Caption = 'Price';
                }
                field(Publisher; Rec.Publisher)
                {
                    Caption = 'Publisher';
                    Visible = false;
                }
                field("Publication Date"; Rec."Publication Date")
                {
                    Caption = 'Publication Date';
                    Visible = false;
                }
                field(Pages; Rec.Pages)
                {
                    Caption = 'Number';
                    Visible = false;
                }
                field(Prequel; Rec.PrequelName)
                {
                    Caption = 'Prequel';
                    Visible = true;
                }
                field(Sequel; Rec.Sequel)
                {
                    Caption = 'Sequel';
                    Visible = true;
                }
                field("Rented Amount"; Rec."Rented Amount")
                {
                    Caption = 'Rented Amount';
                    Visible = false;
                }



            }

        }
    }



    actions
    {

        area(Processing)
        {

            /// <summary>
            /// This will display the top rated books in a message
            /// </summary>
            action(TopRented)
            {
                Caption = 'Top Rented Books';

                trigger OnAction()
                var
                    DisplayTopRented: Codeunit "Display Top Three Rented Books";
                begin
                    //run codeunit to sort list according to rented then take 3 and display as message
                    DisplayTopRented.DisplayBooks(xRec);
                end;
            }
            /// <summary>
            /// This action will launch a codeunit that will be used to add an addition book the libraries book list.
            /// </summary>
            action(AddBook)
            {
                Caption = 'Add Book';
                Image = FiledPosted;

                trigger OnAction()
                var
                    AddBookCode: Codeunit "Add Book Code";
                begin
                    AddBookCode.Run();

                end;
            }
            action(RentBook)
            {
                Caption = 'Rent a Book';

                trigger OnAction()
                var
                    RentBook: Codeunit "Rent Book";
                begin
                    RentBook.RunRentBookCode(Rec);
                end;
            }
            action(SetPublishFilter)
            {
                Caption = 'Display Books Published In Past 2 Years';

                trigger OnAction()
                var
                    SetDateFilter: Codeunit Set2YPublishFilter;
                begin
                    SetDateFilter.Set2YFilter(Rec);
                end;
            }
        }
    }


}