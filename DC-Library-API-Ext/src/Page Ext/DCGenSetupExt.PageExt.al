pageextension 50252 "DC Gen Setup Ext" extends "DC General Setup Page"
{
    layout
    {
        addlast(General)
        {
            group("Library API Extension")
            {
                field("Online Book API ID"; Rec."Online Book API ID")
                {
                }
                field("Online Book Cover API ID"; Rec."Online Book Cover API ID")
                {
                }
            }
        }
    }
}