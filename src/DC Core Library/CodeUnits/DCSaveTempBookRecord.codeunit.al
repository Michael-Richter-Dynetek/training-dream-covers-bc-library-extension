/// <summary>
/// This codeUnit will be used to to save the temporary book to the normal table
/// </summary>
codeunit 50101 "DC Save Temporary Book Record"
{

    procedure SaveTempBook(TempBook: Record "DC Library Book List Table" temporary);
    var
        MainBookList: Record "DC Library Book List Table";
    begin
        MainBookList.Init();
        MainBookList := TempBook;
        MainBookList.Insert()
    end;
}