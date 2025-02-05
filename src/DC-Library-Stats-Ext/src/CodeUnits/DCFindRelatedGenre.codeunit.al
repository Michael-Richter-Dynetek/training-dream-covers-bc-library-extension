/// <summary>
/// Codeunit DC Find Related Genre Code (ID 50151).
/// This function will filter information according to the imputed text
/// </summary>
codeunit 50151 "DC Find Related Genre Code"
{
    /// <summary>
    /// GetGenreFilterText.
    /// This will send back a text value containing all the genres related to the text input
    /// </summary>
    /// <param name="MiscTextFilter">Text[100].</param>
    /// <returns>Return value of type Text.</returns>
    procedure GetGenreFilterText(MiscTextFilter: Text[100]): Text
    var
        FirstRecordFound: Boolean;
        BookGenreEnum: Enum "DC Book Genre Enum";
        ListOfGenres: List of [Text];
        Genre: Text;
        GenreFilterText: Text;
        GenreNotFoundLabel: Label 'No Genre relating to "%1" could be found.';
    begin
        FirstRecordFound := true;
        GenreFilterText := '';
        ListOfGenres := BookGenreEnum.Names;

        // Use the text filter to find genres that contain the text filter, then send the related genres back as text 
        //that can be used in a filter.
        foreach Genre in ListOfGenres do begin
            if Genre.ToLower().Contains(MiscTextFilter.ToLower()) then begin
                if FirstRecordFound = true then begin
                    GenreFilterText := GenreFilterText + Genre;
                    FirstRecordFound := false;
                end
                else
                    GenreFilterText := GenreFilterText + '|' + Genre;
            end;

        end;
        // If no relevant genre was found, a message will display to the user
        if FirstRecordFound = true then
            GenreFilterText := '';
        exit(GenreFilterText);

    end;
}