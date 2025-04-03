/// <summary>
/// This table will contain all the books in the library
/// </summary>
table 50100 "DC Library Book List Table"
{

    DataClassification = CustomerContent;

    fields
    {
        field(1; "Book Number"; Code[20])
        {
            Caption = 'Book Number';
            DataClassification = CustomerContent;
        }
        field(10; Title; Text[2000])
        {
            Caption = 'Title';
            //DataClassification = CustomerContent;
        }
        /*field(19; "Author ID"; Code[20])
        {
            Caption = 'Author ID';
            TableRelation = "DC Author"."Author ID";
        }
        field(20; "Author Name"; Text[200])
        {
            Caption = 'Author';
            FieldClass = FlowField;
            CalcFormula = lookup("DC Author"."Author Name" where("Author ID" = field("Author ID")));
        }*/
        field(50; Series; Text[100])
        {
            Caption = 'Series';
        }
        field(59; "Genre ID"; Integer)
        {
            Caption = 'Genre ID';
            TableRelation = "DC Genre Table"."Genre ID";
        }
        field(60; Genre; Text[200])
        {
            Caption = 'Genre';
            TableRelation = "DC Genre Table";
            FieldClass = FlowField;
            CalcFormula = lookup("DC Genre Table".Genre where("Genre ID" = field("Genre ID")));
        }
        field(70; "Book Price"; Decimal)
        {
            Caption = 'Price';
        }
        field(80; Publisher; Text[2000])
        {
            Caption = 'Publisher';
        }
        field(90; "Publication Date"; Date)
        {
            Caption = 'Publication Date';
        }
        field(100; "Page Number"; Integer)
        {
            Caption = 'Pages Amount';
        }
        field(110; "Prequel ID"; Integer)
        {
            Caption = 'Prequel ID';
            TableRelation = "DC Library Book List Table"."Book Number";
            ValidateTableRelation = true;
        }
        field(120; "Prequel Name"; Text[100])
        {
            Caption = 'Prequel';
            //FieldClass = FlowField;
            //CalcFormula = lookup("DC Library Book List Table".Title where("Book Number" = field("Prequel ID")));
        }
        field(130; "Sequel ID"; Integer)
        {
            Caption = 'Sequel ID';
            TableRelation = "DC Library Book List Table"."Book Number";
        }
        field(140; "Sequel Name"; Text[100])
        {
            Caption = 'Sequel Name';
            //FieldClass = FlowField;
            //CalcFormula = lookup("DC Library Book List Table".Title where("Book Number" = field("Sequel ID")));
        }
        field(250; "Date Added"; Date)
        {
            Caption = 'Date Added';
        }
        field(50100; Description; Text[2048])
        {
            Caption = 'Description';
        }
        field(50109; "Book Cover Filename"; Text[2048])
        {
            Caption = 'Book Cover Filename';
        }
        field(50110; "Book Cover"; Media)
        {
            Caption = 'Book Cover';
        }
        field(50115; "Book Authors Filter"; Text[2048])
        {
            FieldClass = FlowFilter;
        }

    }



    keys
    {
        key(PK; "Book Number")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Brick; Title, "Date Added", "Book Cover") { }
    }

    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
        SeriesCode: Code[20];
    begin
        SeriesCode := NoSeries.GetNextNo('B-ID', WorkDate());
        Rec.Validate("Book Number", SeriesCode);
    end;


}