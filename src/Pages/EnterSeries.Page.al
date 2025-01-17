page 50104 EnterSeries
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Library Book List Table";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Caption = 'Please Enter A Series Name';
                field(Series; Rec.Series)
                {
                    Caption = 'Series';
                }
            }
        }
    }

    var
        myInt: Integer;
}