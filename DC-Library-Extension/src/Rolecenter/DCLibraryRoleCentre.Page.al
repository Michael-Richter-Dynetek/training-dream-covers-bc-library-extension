page 50106 "DC Library Role Center"
{
    PageType = RoleCenter;
    Caption = 'Library';

    layout
    {
        area(RoleCenter)
        {
            part(Activities; "DC Library Activity CuePart")
            {
                Caption = 'Library Activities';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action(LibraryBookList)
            {
                Caption = 'Library Book List';
                ToolTip = 'This will navigate you to the Library Book List Page of the Library Extension';
                RunObject = Page "DC Library Book list Page";
            }

        }
    }
    /*
    actions
    {
        area(Creation)
        {
            action("AppNameDocumentCard")
            {
                RunPageMode = Create;
                Caption = 'AppNameDocumentCard';
                ToolTip = 'Add some tooltip here';
                Image = New;
                RunObject = page "AppNameDocumentCard";
                ApplicationArea = Basic, Suite;
            }
        }
        area(Processing)
        {
            group(New)
            {
                action("AppNameMasterData")
                {
                    RunPageMode = Create;
                    Caption = 'AppNameMasterData';
                    ToolTip = 'Register new AppNameMasterData';
                    RunObject = page "AppNameMasterData Card";
                    Image = DataEntry;
                    ApplicationArea = Basic, Suite;
                }
            }
            group("AppNameSomeProcess Group")
            {
                action("AppNameSomeProcess")
                {
                    Caption = 'AppNameSomeProcess';
                    ToolTip = 'AppNameSomeProcess description';
                    Image = Process;
                    RunObject = Codeunit "AppNameSomeProcess";
                    ApplicationArea = Basic, Suite;
                }
            }
            group("AppName Reports")
            {
                action("AppNameSomeReport")
                {
                    Caption = 'AppNameSomeReport';
                    ToolTip = 'AppNameSomeReport description';
                    Image = Report;
                    RunObject = report "AppNameSomeReport";
                    ApplicationArea = Basic, Suite;
                }
            }
        }
        area(Reporting)
        {
            action("AppNameSomeReport")
            {
                Caption = 'AppNameSomeReport';
                ToolTip = 'AppNameSomeReport description';
                Image = Report;
                RunObject = report "AppNameSomeReport";
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
            }

        }
        area(Embedding)
        {
            action("AppNameMasterData List")
            {
                RunObject = page "AppNameMasterData List";
                ApplicationArea = Basic, Suite;
            }

        }
        area(Sections)
        {
            group(Setup)
            {
                Caption = 'Setup';
                ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                Image = Setup;

                action("AppName Setup")
                {
                    ToolTip = 'Setup AppName';
                    RunObject = Page "AppName Setup";
                    ApplicationArea = Basic, Suite;

                }

                action("Assisted Setup")
                {
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                    RunObject = Page "Assisted Setup";
                    ApplicationArea = Basic, Suite;
                }
                action("Manual Setup")
                {
                    ToolTip = 'Define your company policies for business departments and for general activities by filling setup windows manually.';
                    RunObject = Page "Business Setup";
                    ApplicationArea = Basic, Suite;
                }
                action("Service Connections")
                {
                    ToolTip = 'Enable and configure external services, such as exchange rate updates, Microsoft Social Engagement, and electronic bank integration.';
                    RunObject = Page "Service Connections";
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }*/

}