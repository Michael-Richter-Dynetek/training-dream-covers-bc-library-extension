pageextension 50202 "DC Customer Card Renting Ext" extends "Customer Card"
{
    layout
    {
        addafter(General)
        {
            group("Renting Information")
            {
                Caption = 'Renting Information';

                field("Books Rented"; Rec."Books Rented") { }
                field("Allowed To Rent"; Rec."Allowed To Rent") { }
                field("Current Highest Renting Status"; Rec."Current Highest Renting Status") { }
                field("Highest Renting Status"; Rec."Highest Renting Status") { }
                field("Book Probation"; Rec."Book Probation") { }
                field("Book Probation Started"; Rec."Book Probation Started") { }
                field("Fined Amount"; Rec."Fined Amount") { }


            }
        }
    }

    actions
    {
        addbefore(WordTemplate)
        {
            action(ViewBooks)
            {
                Caption = 'View Rented Book';
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

    // reset books amount
    /*trigger OnOpenPage()
    begin
        Rec."Books Rented" := 0;
        Rec.Modify();
    end;*/



}