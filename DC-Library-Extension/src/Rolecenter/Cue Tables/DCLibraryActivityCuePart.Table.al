table 50104 "DC Library Activity CuePart"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Integer)
        {
            AutoIncrement = true;
        }
        field(50100; "Books Added Monthly"; Integer)
        {
            Caption = 'Books Added this Month';
            FieldClass = FlowField;
            CalcFormula = count("DC Library Book List Table" where("Date Added" = filter('CM-1M..t')));
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