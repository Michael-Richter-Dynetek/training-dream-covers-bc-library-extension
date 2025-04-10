pageextension 50203 "DC General Setup Ext Page" extends "DC General Setup Page"
{
    layout
    {
        addafter(General)
        {
            group("Late Book Fines")
            {
                field("Late Book Warning Fine"; Rec."Late Book Warning Fine") {ApplicationArea = All; }
                field("Late Book Fine"; Rec."Late Book Fine") {ApplicationArea = All; }
            }
            /*group("Status Change Messages")
            {
                field("Mild Status Message"; Rec."Mild Status Message") { }
                field("Medium Status Message"; Rec."Medium Status Message") { }
                field("High Status Message"; Rec."High Status Message") { }
                field("Extreme Status Message"; Rec."Extreme Status Message") { }
            }*/
        }
    }

}