/// <summary>
/// This codeUnit will be used to to save the temporary book to the normal table
/// </summary>
codeunit 50101 "Save Temporary Book Record"
{

    procedure SaveTempBook(TempBook: Record "Library Book List Table" temporary);
    var
        MainBookList: Record "Library Book List Table";
    begin
        MainBookList.Init();
        MainBookList := TempBook;
        MainBookList.Insert()
    end;
}