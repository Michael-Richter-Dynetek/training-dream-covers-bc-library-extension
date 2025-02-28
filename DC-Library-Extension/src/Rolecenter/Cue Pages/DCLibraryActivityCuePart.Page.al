page 50107 "DC Library Activity CuePart"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "DC Library Activity CuePart";

    layout
    {
        area(Content)
        {
            cuegroup("LibraryCues")
            {
                Caption = 'Library Books';
                field("Books Added Monthly"; Rec."Books Added Monthly")
                {
                    DrillDownPageId = "DC Library Book list Page";
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
        Rec.CalcFields("Books Added Monthly");
    end;
}