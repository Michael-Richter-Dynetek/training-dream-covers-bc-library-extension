# Develop Logic using Ascent API Common Library

## general Objects

### Pages

See [Client Documentation](Client_Documentation.md)

### Permission Sets

* Set for Log, Setup and API Details Table

### Enum

* Enum for API Status

### Code Units

* AAT Show Request Message
* Helper CU to view Request Body
* AAT Show Response Message
* Helper CU to view Response Body
* AAT REST Helper
* Main Code unit to load API Data
* Build and Send Requests
* AAT JSON Helper
* Helper to Create / Read Json Bodies


## Example use: AAT REST Helper

Load configs and make an API Call

```al
var
 AATRestHelper: Codeunit "AAT REST Helper";
 RequestJsonBody: JsonObject;
begin
 StationAPISetup.GetRecordOnce();
 StationAPISetup.testfield("Cust. Credit Limit API");

 AATRestHelper.LoadAPIConfig(StationAPISetup."Cust. Credit Limit API");
 AATRestHelper.Initialize('PATCH', AATRestHelper.GetAPIConfigBaseEndpoint() + '/' + Customer."Name 2");
 AATRestHelper.AddBasicAuthHeader();

 RequestJsonBody.Add('companyId', GetCompanyID());
 RequestJsonBody.Add('amount', Customer."Credit Limit (LCY)");
 RequestJsonBody.WriteTo(ReqBodyText);

 AATRestHelper.AddBody(ReqBodyText);
 AATRestHelper.SetContentType('application/json');

 if not AATRestHelper.Send() then begin
  if AATRestHelper.IsTransmitIssue() then
   DisplayError('Failed to send Request. Check URL and try again.');

  DisplayAPIFailureMessage(AATRestHelper);
 end;

 DisplayAPISuccessMessage(AATRestHelper);
end;

```

Display failure information to Client, getting information from the Helper

```al
local procedure DisplayAPIFailureMessage(var AATRestHelper: Codeunit "AAT REST Helper")
var
 ErrorBreakDownLbl: Label 'Code: %1\Message: %2\Reason: %3', Comment = '%1=Error Code, %2 = Err Message %3 = Err. Reason';
begin
 DisplayError(
  StrSubstNo(
  ErrorBreakDownLbl,
  AATRestHelper.GetHttpStatusCode(),
  AATRestHelper.GetResponseContentAsText(),
  AATRestHelper.GetResponseReasonPhrase()
  )
 );
end;
```

## Example use: JSON Helper

Read a property from JSON string

```al
var
    AATRestHelper: Codeunit "AAT REST Helper"
    AATJSONHelper: Codeunit "AAT JSON Helper";
begin
    AATJSONHelper.InitializeJsonObjectFromText(AATRestHelper.GetResponseContentAsText());
    
    := AATJSONHelper.SelectJsonValueAsText('$.response.data.requestStatus', false);
    := AATJSONHelper.SelectJsonValueAsDecimal('$.response.data.requestStatus', false);
    := AATJSONHelper.SelectJsonValueAsInteger('$.response.data.requestStatus', false);
    := AATJSONHelper.SelectJsonValueAsDate('$.response.data.requestStatus', false);
    := AATJSONHelper.SelectJsonValueAsDateTime('$.response.data.requestStatus', false);
    := AATJSONHelper.SelectJsonValueAsBoolean('$.response.data.requestStatus', false);
end;
```

Parse Json String and get AL types back

```al
var
    AATRestHelper: Codeunit "AAT REST Helper"
    AATJSONHelper: Codeunit "AAT JSON Helper";

    ResultObject: JsonObject;

    LinesArray: JsonArray;
    LinesToken: JsonToken;
begin
    AATJSONHelper.InitializeJsonObjectFromText(AATRestHelper.GetResponseContentAsText());

    // Json Object
    ResultObject := AATJSONHelper.GetJsonObject();
    
    // Json Array
    if AATJSONHelper.GetJsonArray(ResponseObject, 'lines', LinesArray) then
        foreach LinesToken in LinesArray do begin
end;
```

read from a JsonObject

```al
var
    DataObject: JsonObject;
    SONumber: Text[50]
begin
    SONumber := AATJSONHelper.GetJsonTokenAsValue(DataObject, 'soNumber').AsText();
end;

```
