/// <summary>
/// This table will countain all the books in the library
/// </summary>
table 50100 "DC Library Book List Table"
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
        field(10; Title; Text[100])
        {
            Caption = 'Title';
            InitValue = 'None';
            //DataClassification = CustomerContent;
        }
        field(20; Author; Text[100])
        {
            Caption = 'Author';
            InitValue = 'None';
        }
        field(30; Rented; Boolean)
        {
            Caption = 'Rented';
            InitValue = false;
        }
        field(39; "Customer Renting ID"; Code[20])
        {
            Caption = 'Customer Renting ID';
            TableRelation = Customer."No.";
        }
        field(40; "Customer Renting Name"; Text[100])
        {
            Caption = 'Customer Renting Name';
            //InitValue = 'None';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Customer Renting ID")));

            //ValidateTableRelation = true;
        }
        field(50; Series; Text[100])
        {
            Caption = 'Number';
            InitValue = 'None';
        }
        field(60; Genre; Text[100])
        {
            Caption = 'Genre';
            InitValue = 'None';
        }
        field(70; "Book Price"; Decimal)
        {
            Caption = 'Price';
            InitValue = 0;
        }
        field(80; Publisher; Text[100])
        {
            Caption = 'Publisher';
            InitValue = 'None';
        }
        field(90; "Publication Date"; Date)
        {
            Caption = 'Publication Date';
            //InitValue = Null;
        }
        field(100; "Page Number"; Integer)
        {
            Caption = 'Pages';
            InitValue = 0;
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
        field(150; "Rented Amount"; Integer)
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
        if "Customer Renting Name" = '' then
            "Customer Renting Name" := 'None';
        if Series = '' then
            Series := 'None';
        if Genre = '' then
            Genre := 'None';
        if Publisher = '' then
            Publisher := 'None';
        if "Prequel Name" = '' then
            "Prequel Name" := 'None';
        if "Sequel Name" = '' then
            "Sequel Name" := 'None';
    end;

    local procedure OnModifyRented();
    begin
        if "Customer Renting Name" = '' then begin
            "Customer Renting Name" := 'None';
        end;

        if ("Customer Renting Name" = '') or ("Customer Renting Name" = 'None') then
            Rented := false
        else
            Rented := true;
    end;

}