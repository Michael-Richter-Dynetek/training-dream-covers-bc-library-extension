page 50104 "DC Enter Series"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "DC Library Book List Table";

    layout
    {
        area(Content)
        {
            group(SeriesInsert)
            {
                Caption = 'Please Enter A Series Name';
                field(Series; Rec.Series)
                {
                    Caption = 'Series';
                }
            }
        }
    }
}