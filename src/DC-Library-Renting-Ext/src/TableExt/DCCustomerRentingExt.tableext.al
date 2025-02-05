tableextension 50201 "DC Customer Renting Ext" extends Customer
{
    fields
    {
        field(50200; "Books Rented"; Integer)
        {
            Caption = 'Books Rented';
            Editable = false;

            /*FieldClass = FlowField;
            CalcFormula = count("DC Library Book List Table" where("Customer Renting ID" = field("No.")));*/
        }
        field(50210; "Allowed To Rent"; Boolean)
        {
            Caption = 'Allowed To Rent Books';
            Editable = false;
        }
        field(50220; "Current Highest Renting Status"; Enum "DC Book Renting Status")
        {
            Caption = 'Current Highest Renting Status';
            Editable = false;

            trigger OnValidate()
            var
                DCOnHighestRentingStatusCode: Codeunit "DC HighestRentingStatusChange";
            begin
                DCOnHighestRentingStatusCode.HighestStatusChanged(Rec);
            end;
        }
        field(50230; "Highest Renting Status"; Enum "DC Book Renting Status")
        {
            Caption = 'Highest Renting Status Reached';
            Editable = false;
        }
        field(50240; "Book Probation"; Boolean)
        {
            Caption = 'On Book Probation';
            Editable = false;

            trigger OnValidate()
            begin
                case Rec."Book Probation" of
                    true:
                        begin
                            Rec."Allowed To Rent" := false;
                            Rec.Validate("Book Probation Started", Today);
                        end;
                    false:
                        begin
                            Rec.Validate("Book Probation Started", 0D);
                        end;
                end;
                Modify();
            end;
        }
        field(50250; "Book Probation Started"; Date)
        {
            Caption = 'Book Probation Start Date';
            Editable = false;
        }

        field(50260; "Fined Amount"; Decimal)
        {
            Caption = 'The Total Fined amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("DC Library Book List Table"."Book Fine" where("Customer Renting ID" = field("No.")));
            /*
            trigger OnValidate()
            var
                FineChangedMessage: Label 'The fine for customer "%1" has changed to "%2"';
            begin
                Message(FineChangedMessage, Rec.Name, Rec."Fined amount");
            end;*/
        }

    }




}