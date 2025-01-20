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

                    trigger OnValidate()
                    begin
                        if Rec.Rented = false then begin
                            Rec."Customer Renting ID" := '';
                            Rec."Customer Renting Name" := '';
                            Rec.Modify();
                        end;
                    end;
                }
                field("Customer Renting"; Rec."Customer Renting Name")
                {
                    Caption = 'Customer Renting Book';
                    trigger OnAssistEdit();
                    var
                        Customer: Record Customer;
                    begin
                        if Page.RunModal(Page::"Customer List", Customer) = Action::LookupOK then begin
                            Rec."Customer Renting ID" := Customer."No.";
                            Rec."Customer Renting Name" := Customer.Name;
                            Rec.Rented := true;
                        end;

                    end;
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
                field(Prequel; Rec."Prequel Name")
                {
                    Caption = 'Prequel';
                }
                field(Sequel; Rec."Sequel Name")
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
                field(Pages; Rec."Page Number")
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
                    displayBooks: Codeunit "DC Add Book";
                begin
                    displayBooks.AddExistingSeries(Rec);
                end;
            }
        }
    }
}