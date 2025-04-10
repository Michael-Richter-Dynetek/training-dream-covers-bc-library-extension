table 50103 "DC Book Authors"
{


    fields
    {
        field(1; "Book Number"; Code[20])
        {
            Caption = 'Book Number';
            //TableRelation = "DC Library Book List Table"."Book Number";
            

        }
        field(10; "Author ID"; Code[20])
        {
            Caption = 'Author ID';
            // TableRelation = "DC Author"."Author ID";
        }
    }

    keys
    {
        key(PK; "Book Number", "Author ID")
        {
            Clustered = true;
        }
    }

}