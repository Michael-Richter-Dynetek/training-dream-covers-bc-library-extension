page 50252 "XML Demo Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    // SourceTable = ;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Run XML Demo"; RunXMLDemo)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        FileManagement: Codeunit "File Management";
                        TempBlob: Codeunit "Temp Blob";
                        XMLports: XmlPort "XML ports";
                        Outstr: OutStream;
                        Instr: Instream;
                        Filename: Text;
                    begin

                        if not RunXMLDemo then
                            exit;

                        Filename := 'Testing.xml';
                        TempBlob.CreateOutStream(Outstr);
                        XMLports.SetDestination(Outstr);
                        XMLports.Export();

                        TempBlob.CreateInStream(Instr);
                        File.DownloadFromStream(Instr, 'Download XML Export', '', FileManagement.GetToFilterText('', Filename), Filename);

                        RunXMLDemo := false
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        RunXMLDemo: Boolean;
}