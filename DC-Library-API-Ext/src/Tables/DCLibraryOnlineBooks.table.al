table 50251 "DC Library Online Books"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(10; Title; Text[300])
        {
            Caption = 'Title';
            //DataClassification = CustomerContent;
        }
        field(20; Author; Text[100])
        {
            Caption = 'Author';
        }
        field(30; "Book Key"; Text[100])
        {
            Caption = 'Description Key';
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