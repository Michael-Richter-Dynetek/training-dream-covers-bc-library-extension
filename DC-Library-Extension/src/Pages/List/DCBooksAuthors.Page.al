page 50114 "DC Books Authors"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "DC Book Authors";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(BooksAuthorsLinkage)
            {
                field("Book Number"; Rec."Book Number")
                {
                    Caption = 'Book Number';
                    ToolTip = 'Specifies the value of the Book Number field.', Comment = '%';
                    ApplicationArea = All;
                }
                field("Author ID"; Rec."Author ID")
                {
                    Caption = 'Author ID';
                    ToolTip = 'Specifies the value of the Author ID field.', Comment = '%';
                    ApplicationArea = All;
                }
            }
        }
    }
}