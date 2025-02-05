/// <summary>
/// This CodeUnit is used to calculate and display the top three rented books
/// </summary>
codeunit 50201 "DC Top Three Rented Books"
{

    /// <summary>
    /// This procedure will receive the current record and use that record to calculate the top 3 rented books.
    /// The procedure will also be used to display the top 3 rented books in message form
    /// </summary>
    /// <param name="DCLibraryBookListTable">Record "DC Library Book List Table".</param>
    procedure DisplayBooks(DCLibraryBookListTable: Record "DC Library Book List Table");
    var
        MessageText: Text[400];
        Counter: Integer;
    begin
        DCLibraryBookListTable.SetCurrentKey("Rented Amount");
        DCLibraryBookListTable.Ascending(false);
        DCLibraryBookListTable.FindFirst();
        Counter := 0;
        repeat
            MessageText := MessageText + 'Book: ' + DCLibraryBookListTable.Title + ', Rented: ' + Format(DCLibraryBookListTable."Rented Amount") + ' \';
            Counter += 1;
            DCLibraryBookListTable.Next()
        until (Counter = 3) or (DCLibraryBookListTable.Next() = 0);
        Message(MessageText);
    end;
}