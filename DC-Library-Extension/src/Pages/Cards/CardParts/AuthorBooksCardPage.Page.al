page 50113 "Author Books Card Page"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "DC Library Book List Table";
    CardPageId = "DC Book Details";

    layout
    {
        area(Content)
        {
            repeater(Books)
            {

                Editable = false;
                field(Title; Rec.Title)
                {
                    ToolTip = 'This is the Title of the Book.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Genre; Rec.Genre)
                {
                    ToolTip = 'This is the Genre of the Book.';
                }
                field("Date Added"; Rec."Date Added")
                {
                    ToolTip = 'Specifies the value of the Date Added field.', Comment = '%';
                }
                field("Page Number"; Rec."Page Number")
                {
                    ToolTip = 'This is the Number of Pages of the Book.';
                }
                field("Book Price"; Rec."Book Price")
                {
                    ToolTip = 'This is the Price of the Book.';
                }
            }
        }
    }

}