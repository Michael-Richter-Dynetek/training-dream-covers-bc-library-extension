codeunit 50250 "DC Library Online Books C"
{
    // This will run
    trigger OnRun()
    var
        //DCLibraryOnlineBooks: Page "DC Library Online Books";
        DCSearchBookBar: Page "DC Search Book Bar";
        DCLibraryOnlineBooks: Page "DC Library Online Books";
        DCSearchAuthor: Record "DC Search Book Line" temporary;
        DCLibraryOnlineBooksTable: Record "DC Library Online Books";
    begin
        DCSearchAuthor.Insert(false);
        //DCLibraryOnlineBooksTable.DeleteAll();


        if Page.RunModal(Page::"DC Search Book Bar", DCSearchAuthor) = Action::LookupOK then begin
            DCSearchAuthor.FindFirst();
            SearchBook(DCSearchAuthor."Search Book", DCLibraryOnlineBooksTable);
            DCLibraryOnlineBooksTable.Modify(true);
            if DCLibraryOnlineBooksTable.FindSet() then begin
                Page.Run(Page::"DC Library Online Books", DCLibraryOnlineBooksTable);
                //Message(DCLibraryOnlineBooksTable.Title);
            end
            else
                Error('Why?');
            //DCLibraryOnlineBooksTable.DeleteAll();

        end;

    end;

    /*procedure SearchBooks(SearchBook: Text)
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        //AATJSONHelper: Codeunit "AAT JSON Helper";
        // v: Codeunit API;
        SearchQuery, StatusMessage : Text;

    begin
        SearchQuery := '.json?title=' + SearchBook.Replace(' ', '+');
        AATRestHelper.LoadAPIConfig('API-0001');
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + SearchQuery);
        AATRestHelper.SetContentType('application/json');


        if not AATRESTHelper.Send() then begin
            if AATRESTHelper.IsTransmitIssue() then
                Error('%1', GetLastErrorText());

            StatusMessage := StrSubstNo('%1, %2, %3', AATRESTHelper.GetHttpStatusCode(), AATRESTHelper.GetResponseContentAsText(), AATRESTHelper.GetResponseReasonPhrase());
            Error(StatusMessage);
            exit;
        end;


    end;*/

    local procedure SearchBook(SearchBook: Text; var DCLibraryOnlineBooks: Record "DC Library Online Books");
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        //DCLibraryOnlineBooks: Record "DC Library Online Books";
        AATJsonHelper: Codeunit "AAT JSON Helper";


        BookResponseJson: JsonObject;
        BookResponseArray: JsonArray;
        BookResponseToken: JsonToken;

        BookListJson: JsonObject;
        BookListArray: JsonArray;
        BookListToken: JsonToken;

        BookItemToken: JsonToken;
        BookItemObject: JsonObject;

        blablaObj: JsonObject;

        AuthorsArr: array[1000] of Text[100];

        SearchQuery, StatusMessage, BookKey : Text;
        Counter: Integer;

    begin
        Counter := 0;

        SearchQuery := '.json?title=' + SearchBook.Replace(' ', '+');
        AATRestHelper.LoadAPIConfig('API-0001');
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + SearchQuery);
        AATRestHelper.SetContentType('application/json');

        if not AATRESTHelper.Send() then begin
            if AATRESTHelper.IsTransmitIssue() then
                Error('%1', GetLastErrorText());

            StatusMessage := StrSubstNo('%1, %2, %3', AATRESTHelper.GetHttpStatusCode(), AATRESTHelper.GetResponseContentAsText(), AATRESTHelper.GetResponseReasonPhrase());
            Error(StatusMessage);
            exit;
        end;

        //Message(AATRestHelper.GetResponseContentAsText());

        AATJsonHelper.InitializeJsonObjectFromText(AATRestHelper.GetResponseContentAsText());
        BookListJson := AATJsonHelper.GetJsonObject();
        BookListJson.SelectToken('$.docs', BookResponseToken);
        BookListArray := BookResponseToken.AsArray();
        //now you have a json object containing all zhe book.
        DCLibraryOnlineBooks.DeleteAll();
        DCLibraryOnlineBooks.Reset();

        foreach BookListToken in BookListArray do begin
            Counter += 1;

            DCLibraryOnlineBooks.Init();



            BookItemObject := BookListToken.AsObject();
            DCLibraryOnlineBooks.Validate("Primary Key", 0);
            //DCLibraryOnlineBooks."Primary Key" := Counter;
            if BookItemObject.SelectToken('$.title', BookItemToken) then begin
                DCLibraryOnlineBooks.Validate(Title, BookItemToken.AsValue().AsText());
                //Message(BookItemToken.AsValue().AsText());
            end;

            if BookItemObject.SelectToken('$.author_name', BookItemToken) then begin
                BookItemToken.AsArray().Get(0, BookItemToken); //.Get(1).AsValue().AsText());
                DCLibraryOnlineBooks.Validate(Author, BookItemToken.AsValue().AsText());
            end;

            if BookItemObject.SelectToken('$.key', BookItemToken) then begin
                BookKey := DelStr(BookItemToken.AsValue().AsText(), 1, 7);
                DCLibraryOnlineBooks.Validate("Book Key", BookKey);
            end;

            DCLibraryOnlineBooks.Insert(true)

            /*if Counter = 3 then
                exit(DCLibraryOnlineBooks);*/

            /*Message('Not Brocken');
            if BookItemObject.SelectToken('$.author_name', BookItemToken) then begin
                DCLibraryOnlineBooks.Validate(Author, BookItemToken.AsArray().);
            end;*/

        end;

        //Message(AATRestHelper.GetResponseContentAsText());
    end;

    procedure GetBookPagesAndPublish(var DCLibraryBookListTable: Record "DC Library Book List Table"; BookKey: Text[20])
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        AATJsonHelper: Codeunit "AAT JSON Helper";

        SearchQuery: Text[100];
        StatusMessage: Text[300];
        PublishDate: Date;

        BookObj: JsonObject;
        BookToken: JsonToken;
    begin
        SearchQuery := '/' + BookKey + '.json';
        AATRestHelper.LoadAPIConfig('API-0003');
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + SearchQuery);
        AATRestHelper.SetContentType('application/json');

        if not AATRESTHelper.Send() then begin
            if AATRESTHelper.IsTransmitIssue() then
                Error('%1', GetLastErrorText());

            StatusMessage := StrSubstNo('%1, %2, %3', AATRESTHelper.GetHttpStatusCode(), AATRESTHelper.GetResponseContentAsText(), AATRESTHelper.GetResponseReasonPhrase());
            Error(StatusMessage);
            exit;
        end;

        Message('Running');
        Message(BookKey);

        AATJsonHelper.InitializeJsonObjectFromText(AATRestHelper.GetResponseContentAsText());
        BookObj := AATJsonHelper.GetJsonObject();

        if BookObj.SelectToken('$.number_of_pages', BookToken) then begin
            DCLibraryBookListTable.Validate("Page Number", BookToken.AsValue().AsInteger());
            Message(Format(BookToken.AsValue().AsInteger()));
        end;

        if BookObj.SelectToken('$.publish_date', BookToken) then begin
            PublishDate := BookToken.AsValue().AsDate();
            DCLibraryBookListTable.Validate("Publication Date", PublishDate);
        end;

        DCLibraryBookListTable.Validate("Date Added", WorkDate());
    end;

    procedure GetBookDescription(var DCLibraryBookListTable: Record "DC Library Book List Table"; BookKey: Text[20])
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        AATJsonHelper: Codeunit "AAT JSON Helper";

        SearchQuery: Text[100];
        StatusMessage: Text[300];

        BookObj: JsonObject;
        BookToken: JsonToken;
    begin
        SearchQuery := '/' + BookKey + '.json';
        AATRestHelper.LoadAPIConfig('API-0002');
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + SearchQuery);
        AATRestHelper.SetContentType('application/json');

        if not AATRESTHelper.Send() then begin
            if AATRESTHelper.IsTransmitIssue() then
                Error('%1', GetLastErrorText());

            StatusMessage := StrSubstNo('%1, %2, %3', AATRESTHelper.GetHttpStatusCode(), AATRESTHelper.GetResponseContentAsText(), AATRESTHelper.GetResponseReasonPhrase());
            Error(StatusMessage);
            exit;
        end;

        AATJsonHelper.InitializeJsonObjectFromText(AATRestHelper.GetResponseContentAsText());
        BookObj := AATJsonHelper.GetJsonObject();

        if BookObj.SelectToken('$.description', BookToken) then begin
            DCLibraryBookListTable.Validate(Description, BookToken.AsValue().AsText());
        end;
    end;

    //var
    //AATRestHelper: Codeunit "AAT REST Helper";

    procedure GetAuhtorInformation()
    begin

    end;

    procedure TestAuthorAlreadyExist()
    begin
        
    end;


}