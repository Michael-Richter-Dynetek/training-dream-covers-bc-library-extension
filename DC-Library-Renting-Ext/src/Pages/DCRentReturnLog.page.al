page 50203 "DC Rent Return Log Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "DC Rented Books Log Table";
    SourceTableView = sorting("Log ID") order(descending);
    Editable = false;


    layout
    {
        area(Content)
        {
            repeater("Rented and Returned Log")
            {   
                field("Log ID";Rec."Log ID"){
                    Caption = 'Log ID';
                    ApplicationArea = All;
                }
                field("Rented/Returned"; Rec."Rented/Returned")
                {
                    Caption = 'Rented or Returned';
                    ApplicationArea = All;
                }
                field("Book Number";Rec."Book Number"){
                    Caption = 'Book Number';
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    Caption = 'Title';
                    ApplicationArea = All;
                }
                field("Customer Renting Name"; Rec."Customer Renting Name")
                {
                    Caption = 'Renting Customer';
                    ApplicationArea = All;
                }
                field("Date Time log"; Rec."Date Time log")
                {
                    Caption = 'Time';
                    ApplicationArea = All;
                }
                /*field("Date Rented"; Rec."Date Rented")
                {
                    Caption = 'Date Rented';
                    ApplicationArea = All;
                }
                field("Date Returned"; Rec."Date Returned")
                {
                    Caption = 'Date Returned';
                    ApplicationArea = All;
                }*/
                field("Days Rented"; Rec."Days Rented")
                {
                    Caption = 'Days Rented';
                    ApplicationArea = All;
                }
                /*field("Book Ranking"; Rec."Book Ranking")
                {
                    Caption = 'Book Ranking';
                    ApplicationArea = All;
                }*/
            }
        }

    }


}