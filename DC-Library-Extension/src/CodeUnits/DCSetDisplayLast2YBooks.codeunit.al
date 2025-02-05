/// <summary>
/// This CodeUnit is responsible for setting a filter on the record given
/// The filter will only display books with a publication data of less than 2 years ago.
/// </summary>
codeunit 50103 "DC Set 2Y Publish Filter"
{

    /// <summary>
    /// This procedure will take in a Record Containing "Publication Date".
    /// A filter will be set to only display "Publication Date" within the past 2 years.
    /// </summary>
    /// <param name="DCLibraryBookListTable">VAR Record "DC Library Book List Table".</param>
    procedure Set2YFilter(var DCLibraryBookListTable: Record "DC Library Book List Table");
    var
        TwoYDate: Date;
    begin
        TwoYDate := CalcDate('-2Y', Today);
        DCLibraryBookListTable.SetFilter("Publication Date", '>%1', TwoYDate);
    end;


}