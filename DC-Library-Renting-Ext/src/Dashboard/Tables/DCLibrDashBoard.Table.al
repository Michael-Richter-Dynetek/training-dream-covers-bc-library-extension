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
        field(20; "Genre Filter"; Text[250] /*Enum "DC Book Genre Enum"*/)
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
                "Book Number" = field("Author Filter"),
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
                "Book Number" = field("Author Filter"),
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
                "Book Number" = field("Author Filter"),
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
                "Book Number" = field("Author Filter"),
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
                "Book Number" = field("Author Filter"),
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
                "Book Number" = field("Author Filter"),
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

    procedure SetAuthorFilter(AuthorFilter: Text)
    var
        DCAuthor: Record "DC Author";
        DCBookAuthor: Record "DC Book Authors";
        AuthorIDFilter: Text;
    begin
        if AuthorFilter = '' then begin
            Rec.SetFilter("Author Filter", '');
            exit;
        end;

        DCAuthor.LoadFields("Author ID", "Author Name");
        DCAuthor.SetFilter("Author Name", '@*' + AuthorFilter + '*');
        if DCAuthor.FindFirst() then begin
            AuthorFilter := DCAuthor."Author ID";
            if DCAuthor.Next() <> 0 then
                repeat
                    AuthorFilter += '|' + DCAuthor."Author ID";
                until DCAuthor.Next() = 0;
        end
        else begin
            Rec.SetFilter("Author Filter", 'No Author Found');
            exit;
        end;

        DCBookAuthor.SetFilter("Author ID", AuthorFilter);
        if DCBookAuthor.FindFirst() then begin
            AuthorFilter := DCBookAuthor."Book Number";
            if DCBookAuthor.Next() <> 0 then
                repeat
                    AuthorFilter += '|' + DCBookAuthor."Book Number";
                until DCBookAuthor.Next() = 0;
        end
        else begin
            Rec.SetFilter("Author Filter", 'No Author Found');
            exit;
        end;

        Rec.SetFilter("Author Filter", AuthorFilter);

    end;


}