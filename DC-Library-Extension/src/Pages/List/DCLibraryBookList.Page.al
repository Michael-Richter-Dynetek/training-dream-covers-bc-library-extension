/// <summary>
/// This page will display aal the Books in the library
/// </summary>
page 50100 "DC Library Book list Page"
{
    Caption = 'Library Book List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "DC Library Book List Table";
    Editable = false;
    CardPageId = 50101;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater("Library Books")
            {
                field("Book Number"; Rec."Book Number")
                {
                    Caption = 'Book Number';
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'This is the Book Number.';
                }
                field(Title; Rec.Title)
                {
                    Caption = 'Title';
                    ApplicationArea = All;
                    ToolTip = 'This is the Title of the Book.';
                }
                // field(Author; Rec."Author Name")
                // {
                //     Caption = 'Author';
                //     ApplicationArea = All;
                //     ToolTip = 'This is the Author of the Book.';
                // }
                field(Series; Rec.Series)
                {
                    Caption = 'Series';
                    ApplicationArea = All;
                    ToolTip = 'This is the Series of the Book.';
                }
                field(Genre; Rec.Genre)
                {
                    Caption = 'Genre';
                    ApplicationArea = All;
                    ToolTip = 'This is the Genre of the Book.';
                }
                field("Book Price"; Rec."Book Price")
                {
                    Caption = 'Price';
                    ApplicationArea = All;
                    ToolTip = 'This is the Price of the Book.';
                }
                field(Publisher; Rec.Publisher)
                {
                    Caption = 'Publisher';
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'This is the Publisher of the Book.';
                }
                field("Publication Date"; Rec."Publication Date")
                {
                    Caption = 'Publication Date';
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'This is the Publication Date of the Book.';
                }
                field(Pages; Rec."Page Number")
                {
                    Caption = 'Number';
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'This is the Number of Pages of the Book.';
                }
                field(Prequel; Rec."Prequel Name")
                {
                    Caption = 'Prequel';
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'This is the Prequel of the Book.';
                }
                field(Sequel; Rec."Sequel Name")
                {
                    Caption = 'Sequel';
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'This is the Sequel of the Book.';
                }
                field("Date Added"; Rec."Date Added")
                {
                    Caption = 'Date Added';
                    ApplicationArea = All;

                }



            }

        }
    }



    actions
    {

        area(Processing)
        {


            /// <summary>
            /// This action will launch a codeunit that will be used to add an addition book the libraries book list.
            /// </summary>
            action(AddBook)
            {
                Caption = 'Add Book';
                Image = FiledPosted;
                ApplicationArea = All;
                ToolTip = 'This allows the user to Add a new Book.';

                trigger OnAction()
                var
                    DCManageBooks: Codeunit "DC Manage Books Code";
                begin
                    DCManageBooks.NavigateToAddBookPage();

                end;
            }
            action(SetPublishFilter)
            {
                Caption = 'Published last 2 Years';
                ApplicationArea = All;
                Image = ContactFilter;
                ToolTip = 'This will filter the table to only show the book Published within the last 2 years.';

                trigger OnAction()
                var
                    SetDateFilter: Codeunit "DC Set 2Y Publish Filter";
                begin
                    SetDateFilter.Set2YFilter(Rec);
                end;
            }
            /*action(PopulateGenre)
            {
                Caption = 'PopulateGenre';

                trigger OnAction()
                var
                    DCPopulateGenreCode: Codeunit "DC Populate Genre Code";
                begin
                    DCPopulateGenreCode.Run();
                end;
            }*/
            action(GeneralSetup)
            {
                Caption = 'General Setup';
                ApplicationArea = all;
                Image = Setup;
                Tooltip = 'These are custom fields that can be edited by customer.';

                trigger OnAction()
                begin
                    if Page.RunModal(Page::"DC General Setup Page") = Action::LookupOK then begin
                    end;
                end;
            }
            action(AddAuthor)
            {
                Caption = 'Add Author';
                ApplicationArea = All;
                Image = AddContacts;
                ToolTip = 'Add a Author to the list of authors';

                trigger OnAction()
                var
                    DCAuthorTemp: Record "DC Author" temporary;
                    DCAuthor: Record "DC Author";
                    AuthorAddedMessage: Label 'The Author "%1" has been added to the library';
                begin
                    DCAuthorTemp.Insert();
                    if Page.RunModal(Page::"DC Add Author", DCAuthorTemp) = Action::LookupOK then begin
                        DCAuthor.Init();
                        DCAuthor := DCAuthorTemp;
                        DCAuthor.Insert(true);
                        Message(AuthorAddedMessage, DCAuthor."Author Name");
                    end;
                end;
            }
            action(ViewAuthors)
            {
                Caption = 'View Authors';
                ToolTip = 'View All Authors currently in the Library.';
                ApplicationArea = All;
                Image = ContactPerson;

                trigger OnAction()
                begin
                    if Page.RunModal(Page::"DC Author List") = Action::LookupOK then;
                end;
            }
        }
    }

    /*trigger OnOpenPage()
    var
        string: Text;
        value1: Integer;
        value2: Text;
        value3: Text;
        FullString: Text;
    begin
        string := '^XA^MMT^PW557^LL0253^LS0^FO8,8^GB543,240,3^FS^FO176,8^GB376,240,3^FS^BY3,3,50^FT24,170^BXN,10,200,0,0,1,~^FH\^FD%1^FS^FT40,220^A0N,20,19^FH\^FD%1^FS^FT352,220^A0N,20,19^FH\^FD%2^FS^FT192,170^A0N,25,26^FB346,6,0,C^FH\^FD%3^FS^PQ%4,0,1,Y^XZ';
        value1 := 222222222;
        value2 := 'Please Greeeeeeeeeeeeeeeeeeeg NNNNNNNNNNNNNNNNNNNNNNNNNNNNN';
        value3 := 'SFDhsdffffffffffffffffdddsssssssssssssssssssssssssssss';
        FullString := StrSubstNo(string, value1, value2, value3);
        Message(FullString);


    end;*/


}