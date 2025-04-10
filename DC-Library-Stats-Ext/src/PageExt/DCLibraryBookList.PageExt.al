/// <summary>
/// PageExtension DC Library Book List Page Ext. (ID 50150) extends Record DC Library Book list Page.
/// This DCLibraryBookList extension page will add an action to navigate to the "DC Filter" page
/// </summary>
pageextension 50150 "DC Library Book List Page Ext." extends "DC Library Book list Page"
{
    actions
    {
        addfirst(Processing)
        {
            action(FilterPage)
            {
                Caption = 'Navigate to Filter Page';
                Image = FilterLines;
                ToolTip = 'This will navigate you to the filter page.';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Page.Run(Page::"DC Filter Page", Rec)
                end;
            }
        }
    }


}