/// <summary>
/// This page will display aal the Books in the library
/// </summary>
page 50108 "DC Author List"
{
    Caption = 'Author List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "DC Author";
    Editable = false;
    CardPageId = "DC Author Details";
    ModifyAllowed = false;



    layout
    {
        area(Content)
        {
            repeater("Author List")
            {

                field("Author Name"; Rec."Author Name")
                {
                    ToolTip = 'Specifies the value of the Author Name field.', Comment = '%';
                    //DrillDownPageId = "DC Author Details";
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
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        FilterString: Text;
        FirstRecord: Boolean;
    begin
        //Message(CloseAction);

        if CloseAction = Action::LookupOK then begin
            FirstRecord := true;
            SetSelectionFilter(Rec);
            if Rec.FindSet() then
                repeat
                    if FirstRecord then begin
                        FirstRecord := false;
                        FilterString += Rec."Author ID";
                    end
                    else
                        FilterString += '|' + Rec."Author ID";
                until Rec.Next() = 0;
        end;
    end;
}