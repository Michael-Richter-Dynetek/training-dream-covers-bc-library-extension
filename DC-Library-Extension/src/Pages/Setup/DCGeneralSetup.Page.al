page 50103 "DC General Setup Page"
{

    PageType = Card;
    SourceTable = "DC Genral Setup Table";
    Caption = 'DC Library General Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;
    ApplicationArea = all;


    layout
    {
        area(content)
        {
            group(General) { }
            /*group("Book Identification")
            {
                field("Book ID"; Rec."Book ID") { }
            }*/

        }
    }

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;

}
