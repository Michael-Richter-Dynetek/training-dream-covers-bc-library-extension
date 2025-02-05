tableextension 50202 "DC General Setup Ext Table" extends "DC Genral Setup Table"
{
    fields
    {
        field(20; "Late Book Warning Fine"; Decimal)
        {
            DecimalPlaces = 2;
            Caption = 'Late Book Warning Fine';
            ToolTip = 'This is for customers reaching the Medium Status';
        }
        field(30; "Late Book Fine"; Decimal)
        {
            DecimalPlaces = 2;
            Caption = 'Late Book Fine';
            ToolTip = 'This is for customers reaching higher than Medium Status';
        }
        field(40; "Mild Status Message"; Text[300])
        {
            Caption = 'Blank status message';
            ToolTip = 'This message will appear when a customer reaches Mild status';
        }
        field(50; "Medium Status Message"; Text[300])
        {
            Caption = 'Blank status message';
            ToolTip = 'This message will appear when a customer reaches Medium status';
        }
        field(60; "High Status Message"; Text[300])
        {
            Caption = 'Blank status message';
            ToolTip = 'This message will appear when a customer reaches High status';
        }
        field(70; "Extreme Status Message"; Text[300])
        {
            Caption = 'Blank status message';
            ToolTip = 'This message will appear when a customer reaches Extreme status';
        }
    }
}