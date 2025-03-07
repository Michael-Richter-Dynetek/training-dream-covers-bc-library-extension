table 50105 "DC Author"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Author ID"; Code[20])
        {
            Caption = 'Author ID';
        }
        field(10; "Author Name"; Text[200])
        {
            Caption = 'Author Name';
        }
        field(20; "Birth Date"; Date)
        {
            Caption = 'Birth date';
        }
        field(30; "Death Date"; Date)
        {
            Caption = 'Death Date';
        }
        field(40; "Bio"; Text[2000])
        {
            Caption = 'Bio';
        }
        field(50; "Work Count"; Integer)
        {
            Caption = 'Work Count';
        }
    }

    keys
    {
        key(PK; "Author ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
        SeriesCode: Code[20];
    begin
        SeriesCode := NoSeries.GetNextNo('DC-AUTH', WorkDate());
        Rec.Validate("Author ID", SeriesCode);
    end;

}