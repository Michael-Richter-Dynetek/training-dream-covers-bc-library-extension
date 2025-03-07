page 50108 "DC Author List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "DC Author";
    Caption = 'Author List';
    Editable = false;



    layout
    {
        area(Content)
        {
            repeater("Author List")
            {

                field("Author Name"; Rec."Author Name")
                {
                    ToolTip = 'Specifies the value of the Author Name field.', Comment = '%';
                }
                field(Bio; Rec.Bio)
                {
                    ToolTip = 'Specifies the value of the Bio field.', Comment = '%';
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ToolTip = 'Specifies the value of the Birth date field.', Comment = '%';
                }
                field("Death Date"; Rec."Death Date")
                {
                    ToolTip = 'Specifies the value of the Death Date field.', Comment = '%';
                }
                field("Work Count"; Rec."Work Count")
                {
                    ToolTip = 'Specifies the value of the Work Count field.', Comment = '%';
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(AddAuthor)
            {
                Caption = 'Add Author';
                ApplicationArea = All;
                Image = AddContacts;
                ToolTip = 'Add a Author to the list of authors';

                trigger OnAction()
                var
                    DCAuthorTemp: Record "DC Author" temporary;
                    DCAuthor: Record "DC Author";
                    AuthorAddedMessage: Label 'The Author "%1" has been added to the library';
                begin
                    DCAuthorTemp.Insert();
                    if Page.RunModal(Page::"DC Add Author", DCAuthorTemp) = Action::LookupOK then begin
                        DCAuthor.Init();
                        DCAuthor := DCAuthorTemp;
                        DCAuthor.Insert(true);
                        Message(AuthorAddedMessage, DCAuthor."Author Name");
                    end;
                end;
            }
        }
    }
}