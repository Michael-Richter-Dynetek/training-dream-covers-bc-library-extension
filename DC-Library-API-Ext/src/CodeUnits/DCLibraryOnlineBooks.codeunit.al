codeunit 50250 "DC Library Online Books C"
{
    // This will run
    trigger OnRun()
    var
        DCSearchBookBar: Page "DC Search Book Bar";
        DCLibraryOnlineBooks: Page "DC Library Online Books";
        DCSearchAuthor: Record "DC Search Book Line" temporary;
        DCLibraryOnlineBooksTable: Record "DC Library Online Books";
    begin
        DCSearchAuthor.Insert(false);
        if Page.RunModal(Page::"DC Search Book Bar", DCSearchAuthor) = Action::LookupOK then begin
            DCSearchAuthor.FindFirst();
            SearchBook(DCSearchAuthor."Search Book", DCLibraryOnlineBooksTable);
            DCLibraryOnlineBooksTable.Modify(true);
            if DCLibraryOnlineBooksTable.FindSet() then
                Page.Run(Page::"DC Library Online Books", DCLibraryOnlineBooksTable);
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
        ಥ_ಥ: Codeunit "AAT REST Helper";
        AATJsonHelper: Codeunit "AAT JSON Helper";

        BookResponseToken: JsonToken;

        BookListJson: JsonObject;
        BookListArray: JsonArray;
        BookListToken: JsonToken;

        BookItemToken, AuthorToken : JsonToken;
        BookItemObject: JsonObject;

        ᓚᘏᗢ, "ಠ╭╮ಠ" : Text;
        UwU, AuthorsFieldText : Text;
        FirstAuthor: Boolean;
    begin
        DCGeneralSetupTable.GetRecordOnce();
        UwU := 'Search Book List (%1)';
        UwU := StrSubstNo(UwU, SearchBook);
        ᓚᘏᗢ := Text.LowerCase('/search.json?title=' + SearchBook.Replace(' ', '+'));



        ಥ_ಥ.LoadAPIConfig(DCGeneralSetupTable."Online Book API ID");
        ಥ_ಥ.Initialize('GET', "ಥ_ಥ".GetAPIConfigBaseEndpoint() + ᓚᘏᗢ);
        ಥ_ಥ.SetContentType('application/json');

        SendRequest(ಥ_ಥ, UwU);

        AATJsonHelper.InitializeJsonObjectFromText(ಥ_ಥ.GetResponseContentAsText());
        BookListJson := AATJsonHelper.GetJsonObject();
        BookListJson.SelectToken('$.docs', BookResponseToken);
        BookListArray := BookResponseToken.AsArray();
        //now you have a json object containing all zhe book.
        DCLibraryOnlineBooks.DeleteAll();
        DCLibraryOnlineBooks.Reset();

        foreach BookListToken in BookListArray do begin
            DCLibraryOnlineBooks.Init();
            BookItemObject := BookListToken.AsObject();
            DCLibraryOnlineBooks.Validate("Primary Key", 0);

            if BookItemObject.SelectToken('$.title', BookItemToken) then
                DCLibraryOnlineBooks.Validate(Title, BookItemToken.AsValue().AsText());

            if BookItemObject.SelectToken('$.author_name', BookItemToken) then begin
                AuthorsFieldText := '';
                FirstAuthor := true;
                foreach AuthorToken in BookItemToken.AsArray() do begin
                    if FirstAuthor then begin
                        AuthorsFieldText += AuthorToken.AsValue().AsText();
                        FirstAuthor := false
                    end
                    else
                        AuthorsFieldText += ', ' + AuthorToken.AsValue().AsText();
                end;
                DCLibraryOnlineBooks.Validate(Author, AuthorsFieldText);
            end;

            if BookItemObject.SelectToken('$.cover_edition_key', BookItemToken) then begin
                DCLibraryOnlineBooks.Validate("Cover Key", BookItemToken.AsValue().AsCode());
            end;

            if BookItemObject.SelectToken('$.key', BookItemToken) then begin
                "ಠ╭╮ಠ" := DelStr(BookItemToken.AsValue().AsText(), 1, 7);
                DCLibraryOnlineBooks.Validate("Book Key", "ಠ╭╮ಠ");
            end;

            DCLibraryOnlineBooks.Insert(true);

        end;
    end;

    procedure GetBookCover(var DCLibraryBookListTable: Record "DC Library Book List Table"; CoverKey: Code[20])
    var
        WebHttpClient: HttpClient;
        WebHttpRequestMessage: HttpRequestMessage;
        WebHttpResponseMessage: HttpResponseMessage;

        AATRestHelper: Codeunit "AAT REST Helper";

        SearchQuery: Text;
        Image: InStream;
    begin
        DCGeneralSetupTable.GetRecordOnce();
        SearchQuery := '/b/olid/' + CoverKey + '.jpg';
        AATRestHelper.LoadAPIConfig(DCGeneralSetupTable."Online Book Cover API ID");

        WebHttpRequestMessage.Method := 'GET';
        //WebHttpRequestMessage.SetRequestUri(AATRestHelper.GetAPIConfigBaseEndpoint() + SearchQuery);
        WebHttpClient.Get(AATRestHelper.GetAPIConfigBaseEndpoint() + SearchQuery, WebHttpResponseMessage);
        if WebHttpResponseMessage.IsSuccessStatusCode then begin
            WebHttpResponseMessage.Content.ReadAs(Image);
            DCLibraryBookListTable."Book Cover".ImportStream(Image, '');//TODO dclibrary is not currently saving things.
        end;
    end;

    procedure GetAuthorCover(var DCAuthor: Record "DC Author"; AuthorKey: Code[20])
    var
        WebHttpClient: HttpClient;
        WebHttpRequestMessage: HttpRequestMessage;
        WebHttpResponseMessage: HttpResponseMessage;

        AATRestHelper: Codeunit "AAT REST Helper";

        SearchQuery: Text;
        Image: InStream;
    begin
        DCGeneralSetupTable.GetRecordOnce();
        SearchQuery := '/a/olid/' + AuthorKey + '.jpg';
        AATRestHelper.LoadAPIConfig(DCGeneralSetupTable."Online Book Cover API ID");

        WebHttpRequestMessage.Method := 'GET';
        //WebHttpRequestMessage.SetRequestUri(AATRestHelper.GetAPIConfigBaseEndpoint() + SearchQuery);
        WebHttpClient.Get(AATRestHelper.GetAPIConfigBaseEndpoint() + SearchQuery, WebHttpResponseMessage);
        if WebHttpResponseMessage.IsSuccessStatusCode then begin
            WebHttpResponseMessage.Content.ReadAs(Image);
            DCAuthor."Author Cover Image".ImportStream(Image, '');//TODO dclibrary is not currently saving things.
        end;
    end;

    procedure GetBookPagesAndPublish(var DCLibraryBookListTable: Record "DC Library Book List Table"; BookKey: Text[20])
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        AATJsonHelper: Codeunit "AAT JSON Helper";

        SearchQuery: Text[100];
        PublishDate: Date;

        BookObj: JsonObject;
        BookToken: JsonToken;

        ReferenceID: Text;
    begin
        DCGeneralSetupTable.GetRecordOnce();
        ReferenceID := 'Additional Book Information (%1)';
        ReferenceID := StrSubstNo(ReferenceID, BookKey);
        SearchQuery := '/books/' + BookKey + '.json';
        AATRestHelper.LoadAPIConfig(DCGeneralSetupTable."Online Book API ID");
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + SearchQuery);
        AATRestHelper.SetContentType('application/json');

        SendRequest(AATRestHelper, ReferenceID);

        AATJsonHelper.InitializeJsonObjectFromText(AATRestHelper.GetResponseContentAsText());
        BookObj := AATJsonHelper.GetJsonObject();

        if BookObj.SelectToken('$.number_of_pages', BookToken) then
            DCLibraryBookListTable.Validate("Page Number", BookToken.AsValue().AsInteger());

        if BookObj.SelectToken('$.publish_date', BookToken) then begin
            if Text.StrLen(BookToken.AsValue().AsText()) <> 4 then begin
                Evaluate(PublishDate, BookToken.AsValue().AsText(), 1);
                DCLibraryBookListTable.Validate("Publication Date", PublishDate);
            end;
            /*PublishDate := BookToken.AsValue().AsDate();
            DCLibraryBookListTable.Validate("Publication Date", PublishDate);*/
        end;

        DCLibraryBookListTable.Validate("Date Added", Today); //used WorkDate()
    end;

    local procedure SendRequest(var AATRestHelper: Codeunit "AAT REST Helper"; ReferenceID: Text)
    var
        StatusMessage: Text[300];
    begin
        if not AATRESTHelper.Send(ReferenceID) then begin
            if AATRESTHelper.IsTransmitIssue() then
                Error('%1', GetLastErrorText());

            StatusMessage := StrSubstNo('%1, %2, %3', AATRESTHelper.GetHttpStatusCode(), AATRESTHelper.GetResponseContentAsText(), AATRESTHelper.GetResponseReasonPhrase());
            Error(StatusMessage);
            exit;
        end;
    end;

    procedure GetBookDescription(var DCLibraryBookListTable: Record "DC Library Book List Table"; BookKey: Text[20])
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        AATJsonHelper: Codeunit "AAT JSON Helper";

        SearchQuery: Text[100];
        StatusMessage: Text[300];

        BookObj: JsonObject;
        BookToken: JsonToken;
        DescriptionObj: JsonObject;
        ReferenceID: Text;
    begin
        DCGeneralSetupTable.GetRecordOnce();
        ReferenceID := 'Book Information (%1)';
        ReferenceID := StrSubstNo(ReferenceID, BookKey);
        SearchQuery := '/works/' + BookKey + '.json';
        AATRestHelper.LoadAPIConfig(DCGeneralSetupTable."Online Book API ID");
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + SearchQuery);
        AATRestHelper.SetContentType('application/json');

        SendRequest(AATRestHelper, ReferenceID);

        AATJsonHelper.InitializeJsonObjectFromText(AATRestHelper.GetResponseContentAsText());
        BookObj := AATJsonHelper.GetJsonObject();

        if BookObj.SelectToken('$.description', BookToken) then begin
            if BookToken.IsObject then begin
                DescriptionObj := BookToken.AsObject();
                DescriptionObj.SelectToken('$.value', BookToken);
            end;

            DCLibraryBookListTable.Validate(Description, BookToken.AsValue().AsText());
        end;
    end;



    //var
    //AATRestHelper: Codeunit "AAT REST Helper";

    procedure GetAuhtorInformation(AuthorName: Text[2000]): Code[20]
    var
        DCAuthor: Record "DC Author";
        AATRestHelper: Codeunit "AAT REST Helper";
        AATJsonHelper: Codeunit "AAT JSON Helper";

        AuthorListObj: JsonObject;
        AuthorListArray: JsonArray;
        AuthorListToken: JsonToken;

        AuthorObj: JsonObject;
        AuthorToken: JsonToken;
        AuthorArrayValueToken: JsonToken;

        StatusMessage: Text[200];
        SearchQuery: Text[300];
        AlternativeNames: Text;

        NoAuthor: Label 'No author could be found.';
        AuthorAddedLabel: Label 'The Author "%1" has been added.';

        FirstItem: Boolean;

        ReferenceID: Text;
    begin
        DCGeneralSetupTable.GetRecordOnce();
        ReferenceID := 'Author Information (%1)';
        ReferenceID := StrSubstNo(ReferenceID, AuthorName);
        SearchQuery := '/search/authors.json?q=' + Text.LowerCase(AuthorName.Replace(' ', '%20'));
        AATRestHelper.LoadAPIConfig(DCGeneralSetupTable."Online Book API ID");
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + SearchQuery);
        AATRestHelper.SetContentType('application/json');

        // Message('Worked:1');
        SendRequest(AATRestHelper, ReferenceID);
        // Message('Worked:2');
        AATJsonHelper.InitializeJsonObjectFromText(AATRestHelper.GetResponseContentAsText());
        AuthorListObj := AATJsonHelper.GetJsonObject();
        // Message('Worked:3');
        if AuthorListObj.SelectToken('$.docs', AuthorListToken) then begin
            AuthorListArray := AuthorListToken.AsArray();
            AuthorListArray.Get(0, AuthorListToken);
            AuthorObj := AuthorListToken.AsObject();
            // Message('Worked:4');
            DCAuthor.Init();

            if AuthorObj.SelectToken('$.name', AuthorToken) then
                DCAuthor.Validate("Author Name", AuthorToken.AsValue().AsText());
            // Message('Worked:5');
            if AuthorObj.SelectToken('$.alternate_names', AuthorToken) then begin
                FirstItem := true;
                AlternativeNames := '';
                // Message('Worked:6');
                foreach AuthorArrayValueToken in AuthorToken.AsArray() do begin
                    if FirstItem then begin
                        AlternativeNames += AuthorArrayValueToken.AsValue().AsText();
                        FirstItem := false;
                    end
                    else
                        AlternativeNames += ', ' + AuthorArrayValueToken.AsValue().AsText();
                end;
                // Message('Worked:7');
                DCAuthor.Validate("Alternative Names", AlternativeNames);
                // Message('Worked:8');
            end;
            // Message('Worked:9');
            if AuthorObj.SelectToken('$.key', AuthorToken) then
                GetAdditionalAuthorDetails(AuthorToken.AsValue().AsCode(), DCAuthor);
            // Message('Worked:10');
            if AuthorObj.SelectToken('$.work_count', AuthorToken) then
                DCAuthor.Validate("Work Count", AuthorToken.AsValue().AsInteger());
            // Message('Worked:11');
            if AuthorObj.SelectToken('$.top_work', AuthorToken) then
                DCAuthor.Validate("Best Work", AuthorToken.AsValue().AsText());
            // Message('Worked:12');
            DCAuthor.Insert(true);
            // Message('Worked:13');
            //Message(AuthorAddedLabel, DCAuthor."Author Name");
            exit(DCAuthor."Author ID");
        end;

        // Message('No Docs have been found');


    end;

    //Test should be run once per Author, so only one auther should be inserted at a time.
    procedure TestAuthorAlreadyExist(AuthorName: Text[2000]): Code[20]
    var
        DCAuthor: Record "DC Author";
        FilterString: Text[200];
        AuthorID: Code[20];
    begin
        AuthorID := '';
        DCAuthor.SetFilter("Author Name", '@*' + AuthorName + '*');
        //Page.Run(Page::"DC Author List", DCAuthor);

        if not DCAuthor.FindFirst() then begin
            DCAuthor.Reset();
            DCAuthor.SetCurrentKey("Alternative Names");
            DCAuthor.SetFilter("Alternative Names", '@*' + AuthorName + '*');

            //Page.Run(Page::"DC Author List", DCAuthor);
            if not DCAuthor.FindFirst() then
                AuthorID := GetAuhtorInformation(AuthorName)
            else
                AuthorID := DCAuthor."Author ID";
        end
        else
            AuthorID := DCAuthor."Author ID";
        exit(AuthorID);

    end;

    local procedure GetAdditionalAuthorDetails(AuthorCode: Code[20]; var DCAuthor: Record "DC Author")
    var
        AATRestHelper: Codeunit "AAT REST Helper";
        AATJsonHelper: Codeunit "AAT JSON Helper";

        AuthorObj: JsonObject;
        AuthorToken: JsonToken;

        SearchQuery: Text[200];
        StatusMessage: Text[300];
        BirthDate, DeathDate : Date;
        BioObj: JsonObject;
        ReferenceID: Text;
    begin
        DCGeneralSetupTable.GetRecordOnce();
        ReferenceID := 'Additional Author Information (%1)';
        ReferenceID := StrSubstNo(ReferenceID, AuthorCode);
        SearchQuery := '/authors/' + AuthorCode + '.json';
        AATRestHelper.LoadAPIConfig(DCGeneralSetupTable."Online Book API ID");
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + SearchQuery);
        AATRestHelper.SetContentType('application/json');

        GetAuthorCover(DCAuthor, AuthorCode);

        SendRequest(AATRestHelper, ReferenceID);

        AATJsonHelper.InitializeJsonObjectFromText(AATRestHelper.GetResponseContentAsText());
        AuthorObj := AATJsonHelper.GetJsonObject();

        if AuthorObj.SelectToken('$.birth_date', AuthorToken) then begin
            if Text.StrLen(AuthorToken.AsValue().AsText()) <> 4 then begin
                Evaluate(BirthDate, AuthorToken.AsValue().AsText(), 1);
                DCAuthor.Validate("Birth Date", BirthDate);
            end;
        end;


        if AuthorObj.SelectToken('$.death_date', AuthorToken) then begin
            if Text.StrLen(AuthorToken.AsValue().AsText()) <> 4 then begin
                Evaluate(DeathDate, AuthorToken.AsValue().AsText(), 1);
                DCAuthor.Validate("Death Date", DeathDate);
            end;
        end;

        if AuthorObj.SelectToken('$.bio', AuthorToken) then begin
            if AuthorToken.IsObject then begin
                BioObj := AuthorToken.AsObject();
                BioObj.SelectToken('value', AuthorToken);
            end;

            DCAuthor.Validate(Bio, AuthorToken.AsValue().AsText());
        end;

    end;

    var
        DCGeneralSetupTable: Record "DC Genral Setup Table";

}

