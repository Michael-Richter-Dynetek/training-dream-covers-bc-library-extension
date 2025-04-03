page 50105 "DC Genre List Page"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DC Genre Table";


    layout
    {
        area(Content)
        {

            repeater("Genre List")
            {
                //Editable = false;
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