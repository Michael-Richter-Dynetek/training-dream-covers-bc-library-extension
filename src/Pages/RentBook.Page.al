page 50103 RentBook
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Library Book List Table";


    layout
    {
        area(Content)
        {
            group("RentBook")
            {
                Caption = 'Rent a Book';
                field("Book Number"; Rec."Book Number")
                {
                    Caption = 'Book Number';
                    //TableRelation = "Library Book List Table"."Book Number";
                    Editable = false;
                }
                field(Title; Rec.Title)
                {
                    Caption = 'Book Title';
                    Editable = false;
                }
                field("Customer Renting"; Rec."Customer Renting")
                {
                    Caption = 'Customer Renting';
                }
            }
        }
    }



}