/// <summary>
/// This table will contain all the books in the library
/// </summary>
table 50100 "DC Library Book List Table"//TODO change name, to better
{

    DataClassification = CustomerContent;

    fields
    {
        field(1; "Book Number"; Code[20])
        {
            Caption = 'Book Number';
            DataClassification = CustomerContent;
            //AutoIncrement = true;

        }
        field(10; Title; Text[100])
        {
            Caption = 'Title';
            //DataClassification = CustomerContent;
        }
        field(19; "Author ID"; Code[20])
        {
            Caption = 'Author ID';
            TableRelation = "DC Author";
        }
        field(20; "Author Name"; Text[100])
        {
            Caption = 'Author';
            FieldClass = FlowField;
            CalcFormula = lookup("DC Library Book List Table"."Author Name" where("Author ID" = field("Author ID")));
        }
        field(50; Series; Text[100])
        {
            Caption = 'Series';
        }
        /*field(59; "Genre ID"; Integer)
        {
            Caption = 'Genre ID';
            //TableRelation = "DC Genre Table"."Genre ID";
        }*/
        field(60; Genre; Enum "DC Book Genre Enum")
        {
            Caption = 'Genre';
            //FieldClass = FlowField;
            //CalcFormula = lookup("DC Genre Table".Genre where("Genre ID" = field("Genre ID")));
        }
        field(70; "Book Price"; Decimal)
        {
            Caption = 'Price';
        }
        field(80; Publisher; Text[100])
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
        field(50100; Description; Text[1024])
        {
            Caption = 'Description';
        }

    }

    keys
    {
        key(PK; "Book Number")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        NoSeries: Codeunit "No. Series";
        SeriesCode: Code[20];
    begin
        SeriesCode := NoSeries.GetNextNo('B-ID', WorkDate());
        Rec.Validate("Book Number", SeriesCode);
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