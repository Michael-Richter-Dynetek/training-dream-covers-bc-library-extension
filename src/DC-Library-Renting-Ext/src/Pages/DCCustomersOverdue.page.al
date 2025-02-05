page 50201 "DC Customers Overdue Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Customer;
    SourceTableView = sorting(Name) order(descending) where("Current Highest Renting Status" = filter(> ' '));
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(CustomersOverdue)
            {
                field(Name; Rec.Name)
                {
                    DrillDownPageId = "Customer Card";
                }
                field("Current Highest Renting Status"; Rec."Current Highest Renting Status") { }
                field("Books Rented"; Rec."Books Rented") { }
                field("Fined Amount"; Rec."Fined Amount") { }
                field("E-Mail"; Rec."E-Mail") { }
                field("Phone No."; Rec."Phone No.") { }

            }
        }
    }


    actions
    {
        area(Processing)
        {
            action(ViewBooks)
            {
                Caption = 'View Overdue Book';
                Image = CopyDepreciationBook;
                ToolTip = 'These are all the books related to the current customer.';
                ApplicationArea = ALL;

                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
}