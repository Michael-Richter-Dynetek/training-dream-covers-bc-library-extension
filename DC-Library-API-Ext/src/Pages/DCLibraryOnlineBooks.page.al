page 50250 "DC Library Online Books"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "DC Library Book List Table";
    Caption ='Add Online Books';
    
    layout
    {
        area(Content)
        {
            repeater(OnlineBookList){
                Caption = 'Online Book List';
                
            }
        }
    }
    
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
    }
    
    var
        myInt: Integer;
}