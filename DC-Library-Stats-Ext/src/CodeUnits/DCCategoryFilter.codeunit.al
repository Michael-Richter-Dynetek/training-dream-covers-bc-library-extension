/// <summary>
/// Codeunit DC Category Filter Code (ID 50150).
/// This code unit will be used to filter the "DC Library Book List Table "DC Filter Text Options Enum" and "MiscTextFilter"
/// </summary>
codeunit 50150 "DC Category Filter Code"
{
    /// <summary>
    /// FilterTextOptions.
    /// This function will use the MiscTextFilter to filter the Category selected by DCFilterTextOptionsEnum.
    /// These filters will be applied to the provided DCLibraryBookListTable.
    /// </summary>
    /// <param name="DCLibraryBookListTable">VAR Record "DC Library Book List Table".</param>
    /// <param name="DCFilterTextOptionsEnum">Enum "DC Filter Text Options Enum".</param>
    /// <param name="MiscTextFilter">Text[100].</param>
    procedure FilterTextOptions(var DCLibraryBookListTable: Record "DC Library Book List Table"; DCFilterTextOptionsEnum: Enum "DC Filter Text Options Enum"; MiscTextFilter: Text[100])
    var
        DCFindRelatedGenreCode: Codeunit "DC Find Related Genre Code";
    begin

        if MiscTextFilter = '' then begin
            DCLibraryBookListTable.SetRange("Book Number");
            DCLibraryBookListTable.SetRange(Genre);
            DCLibraryBookListTable.SetRange("Prequel Name");
            DCLibraryBookListTable.SetRange(Title);
            exit;
        end;

        //if the text filter is not empty then the filter will use the text filter to search for related records.

        //each case will filter according the case and clear text filters not relating to the case.
        case DCFilterTextOptionsEnum of
            DCFilterTextOptionsEnum::" ":
                begin
                    DCLibraryBookListTable.SetRange("Book Number");
                    DCLibraryBookListTable.SetRange(Genre);
                    DCLibraryBookListTable.SetRange("Prequel Name");
                    DCLibraryBookListTable.SetRange(Title);
                end;

            DCFilterTextOptionsEnum::"Author Name":
                begin
                    DCLibraryBookListTable.SetFilter("Book Number", GetBooksRelatedToAuthors(MiscTextFilter));
                    DCLibraryBookListTable.SetRange(Genre);
                    DCLibraryBookListTable.SetRange("Prequel Name");
                    DCLibraryBookListTable.SetRange(Title);
                end;

            DCFilterTextOptionsEnum::Genre:
                begin
                    //DCLibraryBookListTable.SetFilter(Genre, DCFindRelatedGenreCode.GetGenreFilterText(MiscTextFilter));
                    DCLibraryBookListTable.SetFilter(Genre, '@*' + MiscTextFilter + '*');
                    DCLibraryBookListTable.SetRange("Book Number");
                    DCLibraryBookListTable.SetRange("Prequel Name");
                    DCLibraryBookListTable.SetRange(Title);
                end;
            DCFilterTextOptionsEnum::"Publisher Name":
                begin
                    DCLibraryBookListTable.SetFilter("Prequel Name", '@*' + MiscTextFilter + '*');
                    DCLibraryBookListTable.SetRange("Book Number");
                    DCLibraryBookListTable.SetRange(Genre);
                    DCLibraryBookListTable.SetRange(Title);
                end;
            DCFilterTextOptionsEnum::Title:
                begin
                    DCLibraryBookListTable.SetFilter(Title, '@*' + MiscTextFilter + '*');
                    DCLibraryBookListTable.SetRange("Book Number");
                    DCLibraryBookListTable.SetRange(Genre);
                    DCLibraryBookListTable.SetRange("Prequel Name");
                end;


        end;

    end;

    local procedure GetBooksRelatedToAuthors(AuthorName: Text): Text
    var
        DCAuthor: Record "DC Author";
        DCBookAuthors: Record "DC Book Authors";
        FilterBooks, FilterAuthors, AuthorListItem : Text;
        AuthorNotFound, FirstRecord : Boolean;
        AuthorList: List of [Text];
        counter: Integer;
    begin
        AuthorNotFound := false;
        FirstRecord := true;
        FilterBooks := '';
        DCAuthor.SetFilter("Author Name", '@*' + AuthorName + '*');

        if not DCAuthor.FindSet() then
            AuthorNotFound := true
        else
            repeat
                AuthorList.Add(DCAuthor."Author ID");
            until DCAuthor.Next() = 0;


        System.Clear(DCAuthor);
        DCAuthor.SetFilter("Alternative Names", '@*' + AuthorName + '*');
        if not DCAuthor.FindSet() then
            exit('None');
        repeat
            AuthorList.Add(DCAuthor."Author ID");
        until DCAuthor.Next() = 0;



        FirstRecord := true;
        foreach AuthorListItem in AuthorList do begin
            if FirstRecord then begin
                FirstRecord := false;
                FilterAuthors += AuthorListItem;
            end
            else
                FilterAuthors += '|' + AuthorListItem;
        end;

        // if AuthorNotFound and not DCAuthor.FindSet() then
        //     DCBookAuthors.SetFilter("Author ID", DCAuthor."Author ID");

        DCBookAuthors.SetFilter("Author ID", FilterAuthors);

        if not DCBookAuthors.FindSet() then
            exit('None');

        FirstRecord := true;
        repeat
            if FirstRecord then begin
                FirstRecord := false;
                FilterBooks += DCBookAuthors."Book Number";
            end
            else begin
                FilterBooks += '|' + DCBookAuthors."Book Number";
            end;
        until DCBookAuthors.Next() = 0;

        exit(FilterBooks);
    end;
}