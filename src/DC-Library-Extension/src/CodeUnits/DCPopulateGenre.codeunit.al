codeunit 50106 "DC Populate Genre Code"
{
    trigger OnRun()
    var
        GenreList: List of [Text];
        Genre: Text[100];
        DCManageGenreCode: Codeunit "DC Manage Genre Code";
    begin
        GenreList.Add(' ');
        GenreList.Add('Fantasy');
        GenreList.Add('Science Fiction');
        GenreList.Add('Mystery');
        GenreList.Add('Thriller');
        GenreList.Add('Romance');
        GenreList.Add('Historical Fiction');
        GenreList.Add('Horror');
        GenreList.Add('Self-Help');
        GenreList.Add('Biography');
        GenreList.Add('Autobiography');
        GenreList.Add('Adventure');
        GenreList.Add('Young Adult');
        GenreList.Add('Dystopian');
        GenreList.Add('Memoir');
        GenreList.Add('Western');
        GenreList.Add('Crime');
        GenreList.Add('Graphic Novel');
        GenreList.Add('Classic');
        GenreList.Add('Paranormal');
        GenreList.Add('Steampunk');
        GenreList.Add('Urban Fantasy');
        GenreList.Add('Literary Fiction');
        GenreList.Add('Humor');
        GenreList.Add('Psychological Fiction');
        GenreList.Add('Military Fiction');
        GenreList.Add('Political Fiction');
        GenreList.Add('Magical Realism');
        GenreList.Add('Contemporary Fiction');
        GenreList.Add('Cyberpunk');
        GenreList.Add('Gothic Fiction');
        GenreList.Add('Post-Apocalyptic');
        GenreList.Add('Space Opera');
        GenreList.Add('Epic Fantasy');
        GenreList.Add('High Fantasy');
        GenreList.Add('Low Fantasy');
        GenreList.Add('Science Fantasy');
        GenreList.Add('Dark Fantasy');
        GenreList.Add('New Adult');
        GenreList.Add('Chick Lit');
        GenreList.Add('Religious Fiction');
        GenreList.Add('Satire');
        GenreList.Add('Short Stories');
        GenreList.Add('Fairy Tale Retelling');
        GenreList.Add('Cozy Mystery');
        GenreList.Add('Legal Thriller');
        GenreList.Add('Spy Fiction');
        GenreList.Add('Hard Science Fiction');
        GenreList.Add('Soft Science Fiction');

        foreach Genre in GenreList do begin
            DCManageGenreCode.AddGenre(Genre);
        end;


    end;

}