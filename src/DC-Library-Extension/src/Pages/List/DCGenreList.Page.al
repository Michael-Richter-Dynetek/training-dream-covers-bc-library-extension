page 50105 "DC Genre List Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DC Genre Table";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater("Genre List")
            {
                field("Genre ID"; Rec."Genre ID")
                {
                    ApplicationArea = all;
                }
                field(Genre; Rec.Genre)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

}