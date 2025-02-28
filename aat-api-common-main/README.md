# Ascent API Common Library

## General

Each extension that will make use of this Library will have their own setups where the API Code is selected for each operation.

## Client Implementations

- CoGo
- Social Mobile
- Intl. Cellars

## Documentation

[Client Documentation](./Documentation/Client_Documentation.md)

[Developer Documentation](./Documentation/Dynetek_Developers.md)

## To Do

The following lists new features and expansions for the future of this Library

- [ ] Compress blobs in log table on insert.
    For compression logic: .\src\Codeunits\AATCompressLogsJobQueue.Codeunit.al
    Job queue did not work -> Blob space was already allocated and saved no space upon re write of compressed stream

- [x] Add API pages etc to extension
- [x] Add support for request catcher
- [x] Add Enable disable functionality
- [x] Add API code et to Log table
- [ ] ~~ Add `note` field to log table ~~
- [ ] Add Log Level to log i.e. `Warning`, `Error` (Related to enabled or disabled APIs)
- [ ] Add function to AddDefaultRequestHeaders
- [ ] Add toggle for logging

- [ ] Add support to Resend failed requests.
- [ ] Add function to disable resend functionality.

- [ ] CSV Export Import for APIs
- [ ] Disable all logs
- [ ] Disable log for certain Status codes I.E. 200
- [ ] Make Number Series Optional
- [ ] Enable / disable logs per API setup
    * All Logs
    * Certain types of logs. i.e all non status==200 requests