/// <summary>
/// Table DC Genre Table (ID 50101).
/// This table will store all the genres
/// </summary>
table 50101 "DC Genre Table"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Genre ID"; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Caption = 'GenreID';
        }
        field(10; Genre; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Genre';

            trigger OnValidate()
            var
                DCLibraryBookListTable: Record "DC Library Book List Table";
            begin
                if DCLibraryBookListTable.Get(Rec.Genre) then
                    Error(GenreAlreadyExistMessage, Rec.Genre)
                else
                    Message(GenreAddedMessage, Rec.Genre);
            end;
        }
    }



    keys
    {
        key(PK; "Genre ID")
        {
            Clustered = true;
        }
    }

    var
        GenreAlreadyExistMessage: Label 'The entered genre "%1" already exists';
        GenreAddedMessage: Label 'The genre "%1" has already been inserted';

    trigger OnInsert()
    begin

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