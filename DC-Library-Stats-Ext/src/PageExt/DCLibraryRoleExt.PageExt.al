pageextension 50151 "DC Library Role Ext." extends "DC Library Role Center"
{

    actions
    {
        addlast(Creation)
        {
            action(FilterPage)
            {
                Caption = 'Navigate to Filter Page';
                Image = FilterLines;
                ToolTip = 'This will navigate you to the filter page.';
                ApplicationArea = All;

                RunObject = Page "DC Filter Page";
                /*
                trigger OnAction();
                begin
                    Page.Run(Page::"DC Filter Page")
                end;*/
            }
        }
    }
}