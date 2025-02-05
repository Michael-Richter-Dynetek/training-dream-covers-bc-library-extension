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
                field(Author; Rec.Author)
                {
                    Caption = 'Author';
                    ApplicationArea = All;
                    ToolTip = 'This is the Author of the Book.';
                }
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
        }
    }


}