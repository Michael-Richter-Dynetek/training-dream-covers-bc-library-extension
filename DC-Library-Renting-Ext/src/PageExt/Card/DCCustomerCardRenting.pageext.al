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

    // reset books amount
    /*trigger OnOpenPage()
    begin
        Rec."Books Rented" := 0;
        Rec.Modify();
    end;*/



}