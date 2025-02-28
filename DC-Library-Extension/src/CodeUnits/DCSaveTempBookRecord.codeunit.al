/// <summary>
/// This codeUnit will be used to to save the temporary book to the normal table
/// </summary>
codeunit 50101 "DC Save Temporary Book Record"
{


    /// <summary>
    /// This procedure will save a temporary record to the "DC Library Book List Table" table
    /// </summary>
    /// <param name="TempDCLibraryBookListTable">Temporary Record "DC Library Book List Table".</param>
    procedure SaveTempBook(TempDCLibraryBookListTable: Record "DC Library Book List Table" temporary);
    var
        MainBookList: Record "DC Library Book List Table";
    begin
        MainBookList.Init();
        TempDCLibraryBookListTable.Validate("Date Added", WorkDate());
        //TempDCLibraryBookListTable.Modify();
        MainBookList := TempDCLibraryBookListTable;
        MainBookList.Insert(true);
    end;
}