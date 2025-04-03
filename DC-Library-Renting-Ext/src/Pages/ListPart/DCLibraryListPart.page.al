page 50206 "DC Library Card Part"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "DC Library Book List Table";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(BookList)
            {
                Caption = 'Book List';
                field(Title; Rec.Title)
                {
                    Caption = 'Title';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(Publisher; Rec.Publisher)
                {
                    Caption = 'Publisher';
                }
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