page 50251 "DC Search Book Bar"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "DC Search Book Line";

    layout
    {
        area(Content)
        {
            group("Book Search")
            {
                field("Search Book"; Rec."Search Book")
                {
                    Caption = 'Enter a book to search for.';
                    ApplicationArea = All;
                }
            }
        }
    }

    /*actions
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
/*
    var
        BookToSearch: Text;*/
}