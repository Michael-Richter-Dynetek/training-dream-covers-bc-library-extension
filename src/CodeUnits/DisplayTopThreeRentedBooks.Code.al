codeunit 50104 "Display Top Three Rented Books"
{
    procedure DisplayBooks(LibraryBookList: Record "Library Book List Table");
    var
        MessageText: Text[400];
        Counter: Integer;


    begin
        LibraryBookList.SetCurrentKey("Rented Amount");
        LibraryBookList.Ascending(false);
        LibraryBookList.FindFirst();
        Counter := 1;
        repeat
            MessageText := MessageText + 'Book: ' + LibraryBookList.Title + ', Rented: ' + Format(LibraryBookList."Rented Amount") + ' \';
            Counter += 1;
            LibraryBookList.Next()
        until Counter > 3;
        Message(MessageText);
    end;
}