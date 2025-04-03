table 50200 "DC Rented Books Log Table"
{
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Log ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Log ID';
            ToolTip = 'This is the Log ID.';
            AutoIncrement = true;
        }
        field(9; "Book Number"; Code[20])
        {
            Caption = 'Book ID';
            TableRelation = "DC Library Book List Table"."Book Number";
        }
        field(10; Title; Text[2048])
        {
            Caption = 'Title';
            //DataClassification = CustomerContent;
        }
        field(20; "Rented/Returned"; Enum "DC Rented Returned Enum")
        {
            Caption = 'Rented Or Returned';
        }
        field(30; "Customer Renting Name"; Text[2048])
        {
            Caption = 'Customer Renting Name';
        }
        field(40; "Date Time log"; DateTime)
        {
            Caption = 'Time';
        }
        /*field(40; "Date Rented"; Date)
        {
            Caption = 'Date Rented';
        }
        field(50; "Date Returned"; Date)
        {
            Caption = 'Date Returned';
        }*/
        field(60; "Days Rented"; Integer)
        {
            Caption = 'Days Rented';
        }
        field(70; "Rented Amount"; Integer)
        {
            Caption = 'Rented Amount';
        }
        field(80; "Book Ranking"; Integer)
        {
            Caption = 'Book Ranking';
        }
    }



    keys
    {
        key(PK; "Log ID")
        {
            Clustered = true;
        }
    }


}