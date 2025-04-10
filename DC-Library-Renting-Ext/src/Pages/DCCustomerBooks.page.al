page 50202 "DC Customer Books Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "DC Library Book List Table";
    Editable = false;


    layout
    {
        area(Content)
        {
            group(CurrentCustomer)
            {
                field("Customer Renting Name"; Rec."Customer Renting Name")
                {
                    Editable = false;
                    Caption = 'Filtering on Customer Name: ';
                    ApplicationArea = All;
                }
            }
            repeater(Books)
            {
                field(Title; Rec.Title)
                {
                    Caption = 'Title';
                    ApplicationArea = All;
                }
                /*field(Author; Rec."Author Name")
                {
                    Caption = 'Author';
                    ApplicationArea = All;
                }*/

                field(Rented; Rec.Rented)
                {
                    Caption = 'Rented';
                    ApplicationArea = All;
                    ToolTip = 'This indicates if the Book is Rented.';
                }
                field("Customer Renting"; Rec."Customer Renting Name")
                {
                    Caption = 'Customer Renting Book';
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'This is the Customer currently renting the Book.';
                }
                field("Renting Status"; Rec."Renting Status")
                {
                    Caption = 'Renting Status';
                    Visible = true;
                    ApplicationArea = All;
                    ToolTip = 'This is the status for the current rented Book.';
                }
            }
        }
    }

}