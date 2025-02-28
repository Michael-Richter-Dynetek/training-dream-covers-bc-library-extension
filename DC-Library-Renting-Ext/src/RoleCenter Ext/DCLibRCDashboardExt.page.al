pageextension 50204 "DC Lib RC Dashboard Ext." extends "DC Library Role Center"
{

    actions
    {
        addafter(LibraryBookList)
        {
            action(LibraryInfoDashBoard)
            {
                Caption = 'Library Information Dashboard';
                ToolTip = 'This will take you to a Dashboard where you can view compiled information on the Library';
                RunObject = page "DC Library DashBoard";
            }
        }
    }

}