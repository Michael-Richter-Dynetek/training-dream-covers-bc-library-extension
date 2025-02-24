tableextension 50200 "DC Library List Ext." extends "DC Library Book List Table"
{
    fields
    {
        field(30; Rented; Boolean)
        {
            Caption = 'Rented';
        }
        field(39; "Customer Renting ID"; Code[20])
        {
            Caption = 'Customer Renting ID';
            TableRelation = Customer."No.";
        }
        field(40; "Customer Renting Name"; Text[100])
        {
            Caption = 'Customer Renting Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Customer Renting ID")));

            //ValidateTableRelation = true;
        }
        field(150; "Rented Amount"; Integer)
        {
            Caption = 'Rented Amount';
        }
        field(160; "Date Rented"; Date)
        {
            Caption = 'Date Rented';
        }
        field(170; "Date Returned"; Date)
        {
            Caption = 'Date Returned';
        }
        field(180; "Renting Status"; Enum "DC Book Renting Status")
        {
            Caption = 'Date Rented';

            trigger OnValidate()
            var
                DCGeneralSetupTable: Record "DC Genral Setup Table";
            begin
                if Rec."Renting Status".AsInteger() < Enum::"DC Book Renting Status"::Medium.AsInteger() then
                    exit;

                DCGeneralSetupTable.FindFirst();
                case "Renting Status" of
                    Enum::"DC Book Renting Status"::Medium:
                        Rec."Book Fine" := Rec."Book Fine" + DCGeneralSetupTable."Late Book Warning Fine";
                    Enum::"DC Book Renting Status"::High:
                        Rec."Book Fine" := Rec."Book Fine" + DCGeneralSetupTable."Late Book Fine";
                    Enum::"DC Book Renting Status"::Extreme:
                        Rec."Book Fine" := Rec."Book Fine" + DCGeneralSetupTable."Late Book Fine";
                end;
                //Message('%1', Rec."Book Fine");

                Rec.Modify(false);
            end;
        }
        field(190; "Book Fine"; Decimal)
        {
            Caption = 'Book Fine';


        }
        field(200; "Amount Rented Month"; Integer)
        {
            Caption = 'Books Rented in this month';
        }
        field(210; "Book Ranking"; Integer)
        {
            Caption = 'Book Ranking';
        }

    }

    trigger OnBeforeModify()
    begin
        if ("Customer Renting ID" = '') then
            Rented := false
        else
            Rented := true;
    end;
}