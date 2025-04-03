page 50112 "Book Authors Card Part"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "DC Author";
    CardPageId = "DC Author Details";

    layout
    {
        area(Content)
        {
            repeater(Authors)
            {
                Editable = false;
                field("Author Name"; Rec."Author Name")
                {
                    ToolTip = 'Specifies the value of the Author Name field.', Comment = '%';
                    DrillDownPageId = "DC Author Details";
                }
                field("Best Work"; Rec."Best Work")
                {
                    ToolTip = 'Specifies the value of the Best Work field.', Comment = '%';
                }
                field(Bio; Rec.Bio)
                {
                    ToolTip = 'Specifies the value of the Bio field.', Comment = '%';
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ToolTip = 'Specifies the value of the Birth date field.', Comment = '%';
                }
                field("Death Date"; Rec."Death Date")
                {
                    ToolTip = 'Specifies the value of the Death Date field.', Comment = '%';
                }
            }
        }
    }
}