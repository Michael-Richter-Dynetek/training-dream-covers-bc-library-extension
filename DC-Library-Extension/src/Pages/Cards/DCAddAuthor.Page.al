page 50109 "DC Add Author"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "DC Author";
    Caption = 'Add Author';

    layout
    {
        area(Content)
        {
            group("Add Author")
            {
                field("Author Name"; Rec."Author Name")
                {
                    ToolTip = 'Specifies the value of the Author Name field.', Comment = '%';
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
                field("Work Count"; Rec."Work Count")
                {
                    ToolTip = 'Specifies the value of the Work Count field.', Comment = '%';
                }
            }
        }
    }
    /*
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }*/

    var
        myInt: Integer;
}