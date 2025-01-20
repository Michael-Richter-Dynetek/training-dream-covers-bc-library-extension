page 50103 "DC Rent Book Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "DC Library Book List Table";


    layout
    {
        area(Content)
        {
            group("RentBook")
            {
                Caption = 'Rent a Book';
                field("Book Number"; Rec."Book Number")
                {
                    Caption = 'Book Number';
                    //TableRelation = "Library Book List Table"."Book Number";
                    Editable = false;
                }
                field(Title; Rec.Title)
                {
                    Caption = 'Book Title';
                    Editable = false;
                }
                field("Customer Renting"; Rec."Customer Renting Name")
                {
                    Caption = 'Customer Renting';
                    trigger OnAssistEdit();
                    var
                        Customer: Record Customer;
                    begin
                        if Page.RunModal(Page::"Customer List", Customer) = Action::LookupOK then begin
                            Rec."Customer Renting ID" := Customer."No.";
                            Rec."Customer Renting Name" := Customer.Name;
                            ClearRentingName := false;
                        end;

                    end;
                }

            }
            group(Button)
            {
                field(clearRentingName; ClearRentingName)
                {
                    Caption = 'Clear Renting Customer';

                    trigger OnValidate()
                    begin
                        if ClearRentingName = true then begin
                            Rec."Customer Renting ID" := '';
                            Rec."Customer Renting Name" := '';
                            ClearRentingName := false;
                        end;
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ClearRentingCustomer)
            {
                Caption = 'Clear Renting Customer';
                trigger OnAction()
                begin
                    if ClearRentingName = true then begin
                        Rec."Customer Renting ID" := '';
                        Rec."Customer Renting Name" := '';
                        ClearRentingName := false;
                        Rec.Modify();
                    end;
                end;
            }
        }
    }

    var
        ClearRentingName: Boolean;


}