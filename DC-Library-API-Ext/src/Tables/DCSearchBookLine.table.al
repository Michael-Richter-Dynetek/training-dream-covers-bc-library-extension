table 50250 "DC Search Book Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; PrimaryKey; Integer)
        {

        }
        field(10; "Search Book"; Text[100])
        {
            Caption = 'Search Book';
        }
    }

    keys
    {
        key(PK; PrimaryKey)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }



    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}