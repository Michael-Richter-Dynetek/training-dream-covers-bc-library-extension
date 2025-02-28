table 50201 "DC Libr DashBoard"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
        }
        field(10; "Author Filter"; Text[100])
        {
            Caption = 'Author';
            FieldClass = FlowFilter;
        }
        field(20; "Genre Filter"; Enum "DC Book Genre Enum")
        {
            Caption = 'Genre';
            FieldClass = FlowFilter;
        }
        field(30; "Publishing Date Filter"; Date)
        {
            Caption = 'Publishing Date';
            FieldClass = FlowFilter;
        }
        field(40; "Book Added Date Filter"; Date)
        {
            Caption = 'Book Added Date';
            FieldClass = FlowFilter;
        }
        field(45; "Total Available Books"; Integer)
        {
            Caption = 'Total Available Books';
            FieldClass = FlowField;
            CalcFormula = Count("DC Library Book List Table" where(
                Rented = const(false),
                Author = field("Author Filter"),
                Genre = field("Genre Filter"),
                "Publication Date" = field("Publishing Date Filter"),
                "Date Added" = field("Book Added Date Filter")));
            // BlankZero = true;
        }
        field(50; "Total Rented Books"; Integer)
        {
            Caption = 'Total Rented Books';
            FieldClass = FlowField;
            CalcFormula = Count("DC Library Book List Table" where(
                Rented = const(true),
                Author = field("Author Filter"),
                Genre = field("Genre Filter"),
                "Publication Date" = field("Publishing Date Filter"),
                "Date Added" = field("Book Added Date Filter")));
            // BlankZero = true;
        }
        field(60; "Total Mild Books"; Integer)
        {
            Caption = 'Total Mild Status Books';
            FieldClass = FlowField;
            CalcFormula = Count("DC Library Book List Table" where(
                "Renting Status" = const("DC Book Renting Status"::Mild),
                Author = field("Author Filter"),
                Genre = field("Genre Filter"),
                "Publication Date" = field("Publishing Date Filter"),
                "Date Added" = field("Book Added Date Filter")));
            // BlankZero = true;
        }
        field(70; "Total Medium Books"; Integer)
        {
            Caption = 'Total Medium Status Books';
            FieldClass = FlowField;
            CalcFormula = Count("DC Library Book List Table" where(
                "Renting Status" = const("DC Book Renting Status"::Medium),
                Author = field("Author Filter"),
                Genre = field("Genre Filter"),
                "Publication Date" = field("Publishing Date Filter"),
                "Date Added" = field("Book Added Date Filter")));
            // BlankZero = true;
        }
        field(80; "Total High Books"; Integer)
        {
            Caption = 'Total High Status Books';
            FieldClass = FlowField;
            CalcFormula = Count("DC Library Book List Table" where(
                "Renting Status" = const("DC Book Renting Status"::High),
                Author = field("Author Filter"),
                Genre = field("Genre Filter"),
                "Publication Date" = field("Publishing Date Filter"),
                "Date Added" = field("Book Added Date Filter")));
            // BlankZero = true;
        }
        field(90; "Total Extreme Books"; Integer)
        {
            Caption = 'Total Extreme Status Books';
            FieldClass = FlowField;
            CalcFormula = Count("DC Library Book List Table" where(
                "Renting Status" = const("DC Book Renting Status"::Extreme),
                Author = field("Author Filter"),
                Genre = field("Genre Filter"),
                "Publication Date" = field("Publishing Date Filter"),
                "Date Added" = field("Book Added Date Filter")));
            // BlankZero = true;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

}