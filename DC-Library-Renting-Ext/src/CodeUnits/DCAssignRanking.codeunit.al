codeunit 50207 "DC Assign Ranking Code"
{
    trigger OnRun()
    begin
        //AssignMonthlyRented();
        ResetRanking();
        AssignMonthlyRented();
        AssignRanking();
    end;

    /*local procedure AssignRankingForMonth()
    var
        DCLibraryBookListTable: Record "DC Library Book List Table";
        DCRentedBooksLogTable: Record "DC Rented Books Log Table";
        TotalSetsFound: Integer;
    begin

        //DCLibraryBookListTable.SetFilter("Rented Amount", '>0');
        //calculate rented this month then assign all
        DCLibraryBookListTable.SetCurrentKey("Rented Amount");
        DCLibraryBookListTable.Ascending(false);


    end;*/

    local procedure ResetRanking()
    var
        DCLibraryBookListTable: Record "DC Library Book List Table";
    begin
        if DCLibraryBookListTable.FindSet() then
            repeat
                DCLibraryBookListTable.Validate("Book Ranking", 0);
                DCLibraryBookListTable.Validate("Amount Rented Month", 0);
            until DCLibraryBookListTable.Next() = 0;

        DCLibraryBookListTable.Modify();
    end;


    local procedure AssignMonthlyRented()
    var
        DCLibraryBookListTable: Record "DC Library Book List Table";
        DCRentedBooksLogTable: Record "DC Rented Books Log Table";
        RecordCount: Integer;
    begin
        //DCRentedBooksLogTable.SetRange("Date Rented", CalcDate('<-6M>', Today), Today);

        if DCLibraryBookListTable.FindSet() then
            repeat
                DCRentedBooksLogTable.SetRange("Date Time log", CreateDateTime(CalcDate('<-1M>',CurrentDateTime.Date), CurrentDateTime.Time) ,CurrentDateTime);
                //DCRentedBooksLogTable.SetFilter("Date Time log", '%1 .. %2',CreateDateTime(CalcDate('<-1M>',CurrentDateTime.Date), CurrentDateTime.Time) ,CurrentDateTime);
                DCRentedBooksLogTable.SetFilter(Title, DCLibraryBookListTable.Title);
                if DCRentedBooksLogTable.FindSet() then begin
                    DCLibraryBookListTable.Validate("Amount Rented Month", DCRentedBooksLogTable.Count());
                    DCLibraryBookListTable.Modify();
                end
                else begin
                    DCLibraryBookListTable.Validate("Amount Rented Month", 0);
                    DCLibraryBookListTable.Modify();
                end;
                System.Clear(DCRentedBooksLogTable);
                RecordCount := DCLibraryBookListTable.Next();
            until RecordCount = 0;//DCLibraryBookListTable.Next() = 0;

    end;

    local procedure AssignRanking()
    var
        DCLibraryBookListTable: Record "DC Library Book List Table";
        RankCounter: Integer;
        PreviousBookRentedAmount: Integer;
    begin
        DCLibraryBookListTable.SetCurrentKey("Amount Rented Month");
        DCLibraryBookListTable.Ascending(false);
        RankCounter := 1;
        PreviousBookRentedAmount := -100;

        if DCLibraryBookListTable.FindSet() then
            repeat
                DCLibraryBookListTable.Validate("Book Ranking", RankCounter);

                if PreviousBookRentedAmount = DCLibraryBookListTable."Amount Rented Month" then
                    RankCounter -= 1;

                PreviousBookRentedAmount := DCLibraryBookListTable."Amount Rented Month";
                DCLibraryBookListTable.Modify();

                RankCounter += 1;
                PreviousBookRentedAmount := DCLibraryBookListTable."Amount Rented Month";
            until DCLibraryBookListTable.Next() = 0;
    end;

}