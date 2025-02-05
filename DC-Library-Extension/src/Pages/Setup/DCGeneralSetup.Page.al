page 50103 "DC General Setup Page"
{

    PageType = Card;
    SourceTable = "DC Genral Setup Table";
    Caption = 'PageName Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;


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
