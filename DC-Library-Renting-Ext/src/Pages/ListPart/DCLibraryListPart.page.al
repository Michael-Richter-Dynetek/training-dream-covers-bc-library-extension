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
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                }
                field(Publisher; Rec.Publisher)
                {
                    Caption = 'Publisher';
                    ApplicationArea = All;
                }
            }
        }
    }
}