/// <summary>
/// This table will countain all the books in the library
/// </summary>
table 50100 "Library Book List Table"
{

    DataClassification = CustomerContent;

    fields
    {
        field(1; "Book Number"; Integer)
        {
            Caption = 'Book Number';
            DataClassification = CustomerContent;
            AutoIncrement = true;

        }
        field(2; Title; Text[100])
        {
            Caption = 'Title';
            InitValue = 'None';
            //DataClassification = CustomerContent;
        }
        field(3; Author; Text[100])
        {
            Caption = 'Author';
            InitValue = 'None';
        }
        field(4; Rented; Boolean)
        {
            Caption = 'Rented';
            InitValue = false;
        }
        field(5; "Customer Renting"; Text[100])
        {
            Caption = 'Customer Renting Book';
            InitValue = 'None';
        }
        field(6; Series; Text[100])
        {
            Caption = 'Number';
            InitValue = 'None';
        }
        field(7; Genre; Text[100])
        {
            Caption = 'Genre';
            InitValue = 'None';
        }
        field(9; "Book Price"; Decimal)
        {
            Caption = 'Price';
            InitValue = 0;
        }
        field(8; Publisher; Text[100])
        {
            Caption = 'Publisher';
            InitValue = 'None';
        }
        field(10; "Publication Date"; Date)
        {
            Caption = 'Publication Date';
            //InitValue = Null;
        }
        field(11; Pages; Integer)
        {
            Caption = 'Number';
            InitValue = 0;
        }
        field(15; PrequelID; Integer)
        {
            //Caption = 'Prequel';
            TableRelation = "Library Book List Table"."Book Number";
            ValidateTableRelation = true;
        }
        field(12; PrequelName; Text[100])
        {
            Caption = 'Prequel';
            InitValue = 'None';
            //TableRelation = "Library Book List Table"."Book Number";
            //ValidateTableRelation =true;
        }
        field(16; SequelID; Integer)
        {
            Caption = 'SequelID';
            TableRelation = "Library Book List Table"."Book Number";
        }
        field(13; Sequel; Text[100])
        {
            Caption = 'Sequel';
            InitValue = 'None';
        }
        field(14; "Rented Amount"; Integer)
        {
            Caption = 'Rented Amount';
            InitValue = 0;
        }
    }

    keys
    {
        key(PK; "Book Number")
        {
            Clustered = true;
        }
        key(SecondaryKey; Title)
        {
            Clustered = false;
        }
    }


    var
        myInt: Integer;

    trigger OnInsert()
    begin
        OnModifyRented();
        OnModifyTextFields();
    end;

    trigger OnModify()
    begin
        OnModifyRented();
        OnModifyTextFields();
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;


    local procedure OnModifyTextFields();
    begin
        if Title = '' then
            Title := 'None';
        if Author = '' then
            Author := 'None';
        if "Customer Renting" = '' then
            "Customer Renting" := 'None';
        if Series = '' then
            Series := 'None';
        if Genre = '' then
            Genre := 'None';
        if Publisher = '' then
            Publisher := 'None';
        if PrequelName = '' then
            PrequelName := 'None';
        if Sequel = '' then
            Sequel := 'None';
    end;

    local procedure OnModifyRented();
    begin
        if "Customer Renting" = '' then begin
            "Customer Renting" := 'None';
        end;

        if ("Customer Renting" = '') or ("Customer Renting" = 'None') then
            Rented := false
        else
            Rented := true;
    end;

}