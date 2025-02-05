/// <summary>
/// Enum DC Filter Text Options Enum (ID 50150).
/// This Enum will house all the option that will be displayed within the filter text combo box
/// </summary>
enum 50150 "DC Filter Text Options Enum"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }

    value(10; Title)
    {
        Caption = 'Title';
    }

    value(20; "Author Name")
    {
        Caption = 'Author Name';
    }

    value(30; "Publisher Name")
    {
        Caption = 'Publisher Name';
    }

    value(40; "Genre")
    {
        Caption = 'Genre';
    }
}