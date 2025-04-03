/// <summary>
/// This codeUnit will be used to to save the temporary book to the normal table
/// </summary>
codeunit 50101 "DC Save Temporary Book Record"
{


    /// <summary>
    /// This procedure will save a temporary record to the "DC Library Book List Table" table
    /// </summary>
    /// <param name="TempDCLibraryBookListTable">Temporary Record "DC Library Book List Table".</param>
    /*procedure SaveTempBook(TempDCLibraryBookListTable: Record "DC Library Book List Table" temporary);
    var
        MainBookList: Record "DC Library Book List Table";
    begin
        MainBookList.Init();
        TempDCLibraryBookListTable.Validate("Date Added", WorkDate());
        //TempDCLibraryBookListTable.Modify();
        MainBookList := TempDCLibraryBookListTable;
        MainBookList.Insert(true);
    end;*/

    procedure SaveTempBook(TempDCLibraryBookListTable: Record "DC Library Book List Table" temporary): Code[20];
    var
        DCLibraryBookListTable: Record "DC Library Book List Table";
    begin
        DCLibraryBookListTable.Init();
        TempDCLibraryBookListTable.Validate("Date Added", WorkDate());
        //TempDCLibraryBookListTable.Modify();
        DCLibraryBookListTable := TempDCLibraryBookListTable;
        DCLibraryBookListTable.Insert(true);
        exit(DCLibraryBookListTable."Book Number");
    end;

    procedure SaveAuthorsToBook(BookNumber: Code[20])
    var
        DCBookAuthors: Record "DC Book Authors";
        DCBookAuthorsTemp: Record "DC Book Authors" temporary;
    begin
        DCBookAuthors.SetRange("Book Number", '');
        if DCBookAuthors.FindSet() then begin
            //DCBookAuthorsTemp.Insert();
            repeat
                DCBookAuthorsTemp.Init();
                DCBookAuthorsTemp."Book Number" := BookNumber;
                DCBookAuthorsTemp."Author ID" := DCBookAuthors."Author ID";
                DCBookAuthorsTemp.Insert();
            //DCBookAuthors.Validate("Book Number", BookNumber);
            until DCBookAuthors.Next() = 0;
            DCBookAuthors.DeleteAll();
            DCBookAuthorsTemp.FindFirst();
            repeat
                DCBookAuthors.Init();
                DCBookAuthors := DCBookAuthorsTemp;
                DCBookAuthors.Insert();
            until DCBookAuthorsTemp.Next() = 0;
        end;
        DCBookAuthors.Modify(true);
    end;

    procedure CopyAuthorsToBook(BookNumberCopyFrom: Code[20]; BookNumberCopyTo: Code[20]): Record "DC Book Authors"
    var
        DCBookAuthors: Record "DC Book Authors";
        DCBookAuthors2: Record "DC Book Authors";
    begin
        DCBookAuthors.SetRange("Book Number", BookNumberCopyFrom);
        if DCBookAuthors.FindSet() then
            repeat
                DCBookAuthors2.Init();
                DCBookAuthors2."Book Number" := BookNumberCopyTo;
                DCBookAuthors2."Author ID" := DCBookAuthors."Author ID";
                DCBookAuthors2.Insert();
            until DCBookAuthors.Next() = 0;
        exit(DCBookAuthors2);
    end;
}