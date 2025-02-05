codeunit 50104 "DC Manage Genre Code"
{
    procedure AddGenre(Genre: Text[100])
    var
        DCGenreTable: Record "DC Genre Table";
    begin

        DCGenreTable.Init();
        DCGenreTable.Validate(Genre, Genre);
        DCGenreTable.Insert(true);

    end;
}