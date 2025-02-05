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
        //if the text filter is not empty then the filter will use the text filter to search for related records.
        if MiscTextFilter <> '' then begin
            //each case will filter according the case and clear text filters not relating to the case.
            case DCFilterTextOptionsEnum of
                DCFilterTextOptionsEnum::" ":
                    begin
                        DCLibraryBookListTable.SetRange(Author);
                        DCLibraryBookListTable.SetRange(Genre);
                        DCLibraryBookListTable.SetRange("Prequel Name");
                        DCLibraryBookListTable.SetRange(Title);
                    end;

                DCFilterTextOptionsEnum::"Author Name":
                    begin
                        DCLibraryBookListTable.SetFilter(Author, '@*' + MiscTextFilter + '*');
                        DCLibraryBookListTable.SetRange(Genre);
                        DCLibraryBookListTable.SetRange("Prequel Name");
                        DCLibraryBookListTable.SetRange(Title);
                    end;

                DCFilterTextOptionsEnum::Genre:
                    begin
                        DCLibraryBookListTable.SetFilter(Genre, DCFindRelatedGenreCode.GetGenreFilterText(MiscTextFilter));
                        DCLibraryBookListTable.SetRange(Author);
                        DCLibraryBookListTable.SetRange("Prequel Name");
                        DCLibraryBookListTable.SetRange(Title);
                    end;
                DCFilterTextOptionsEnum::"Publisher Name":
                    begin
                        DCLibraryBookListTable.SetFilter("Prequel Name", '@*' + MiscTextFilter + '*');
                        DCLibraryBookListTable.SetRange(Author);
                        DCLibraryBookListTable.SetRange(Genre);
                        DCLibraryBookListTable.SetRange(Title);
                    end;
                DCFilterTextOptionsEnum::Title:
                    begin
                        DCLibraryBookListTable.SetFilter(Title, '@*' + MiscTextFilter + '*');
                        DCLibraryBookListTable.SetRange(Author);
                        DCLibraryBookListTable.SetRange(Genre);
                        DCLibraryBookListTable.SetRange("Prequel Name");
                    end;


            end;
        end
        else begin
            DCLibraryBookListTable.SetRange(Author);
            DCLibraryBookListTable.SetRange(Genre);
            DCLibraryBookListTable.SetRange("Prequel Name");
            DCLibraryBookListTable.SetRange(Title);
        end;

    end;
}