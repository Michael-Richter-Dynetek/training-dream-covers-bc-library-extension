table 50105 "DC Author"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Author ID"; Code[20])
        {
            Caption = 'Author ID';
            DataClassification = CustomerContent;
        }
        field(10; "Author Name"; Text[2000])
        {
            Caption = 'Author Name';
        }
        field(12; "Alternative Names"; Text[2048])
        {
            Caption = 'Alternative Names';
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
        field(60; "Best Work"; Text[2000])
        {
            Caption = 'Best Work';
        }
        field(70; "Author Books Filter"; Text[2048])
        {
            FieldClass = FlowFilter;
        }
        field(80; "Author Cover Image"; Media)
        {
            Caption = 'Author Image';
        }
    }



    keys
    {
        key(PK; "Author ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; "Author Name", "Alternative Names", "Best Work", "Author Cover Image") { }
    }

    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
        SeriesCode: Code[20];
    begin
        SeriesCode := NoSeries.GetNextNo('A-ID', WorkDate());
        Rec.Validate("Author ID", SeriesCode);
    end;

}