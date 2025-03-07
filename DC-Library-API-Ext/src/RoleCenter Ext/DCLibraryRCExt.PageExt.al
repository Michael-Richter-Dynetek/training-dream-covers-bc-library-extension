pageextension 50250 "DC Library RC Ext." extends "DC Library Role Center"
{
    actions
    {
        addlast(Creation)
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