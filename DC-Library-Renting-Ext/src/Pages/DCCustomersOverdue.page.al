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
                    ApplicationArea = All;
                }
                field("Current Highest Renting Status"; Rec."Current Highest Renting Status") { ApplicationArea = All; }
                field("Books Rented"; Rec."Books Rented") { ApplicationArea = All; }
                field("Fined Amount"; Rec."Fined Amount") { ApplicationArea = All; }
                field("E-Mail"; Rec."E-Mail") { ApplicationArea = All; }
                field("Phone No."; Rec."Phone No.") { ApplicationArea = All; }

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
                var
                    DCLibraryBookListTable: Record "DC Library Book List Table";
                begin
                    DCLibraryBookListTable.SetFilter("Customer Renting Name", Rec.Name);
                    Page.RunModal(Page::"DC Customer Books Page", DCLibraryBookListTable);
                end;
            }
        }
    }
}