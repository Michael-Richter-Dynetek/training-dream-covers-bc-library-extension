pageextension 50251 "DC Library Book List Ext." extends "DC Library Book list Page"
{

    actions
    {
        addfirst(Processing)
        {
            action(AddOnlineBook)
            {
                Caption = 'Add Online Book';
                ToolTip = 'This display a list of books where you can search for a book to add to this library';
                ApplicationArea = All;

                RunObject = codeunit "DC Library Online Books C";

            }
        }
    }

}