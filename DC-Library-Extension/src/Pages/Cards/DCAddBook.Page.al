/// <summary>
/// This page will be used to add a book to the table
/// </summary>
page 50102 "Add Book Page"
{
    Caption = 'Add a Book';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "DC Library Book List Table";


    layout
    {

        area(Content)
        {
            /// <summary>
            /// These are all the fields that the user should insert to add a book
            /// </summary>

            group("Main Information")
            {
                Caption = 'Main Information';
                field(Title; Rec.Title)
                {
                    Caption = 'Title';
                    Enabled = true;
                    ApplicationArea = All;
                    ToolTip = 'Enter the Title of the book.';
                }
                field(Author; Authors)// TODO AUTHOR
                {
                    Caption = 'Author';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Enter the Author of the book.';

                    trigger OnAssistEdit()
                    var
                        DCAuthor: Record "DC Author";
                        DCAuthor2: Record "DC Author";
                        //DCBookAuthors: Record "DC Book Authors";
                        DCAuthorList: Page "DC Author List";
                        FilterText: Text;
                    begin
                        Clear(DCAuthorList);
                        DCAuthorList.SetTableView(DCAuthor);
                        DCAuthorList.SetRecord(DCAuthor);
                        DCAuthorList.LookupMode(true);
                        //DCAuthorList.LookupMode()
                        if DCBookAuthors.Count <> 0 then
                            DCBookAuthors.DeleteAll();

                        if DCAuthorList.RunModal() = Action::LookupOK then begin
                            DCAuthorList.SetSelectionFilter(DCAuthor);
                            if DCAuthor.FindSet() then begin
                                repeat
                                    DCBookAuthors.Init();
                                    DCBookAuthors."Book Number" := '';
                                    DCBookAuthors."Author ID" := DCAuthor."Author ID";
                                    DCBookAuthors.Insert();
                                until DCAuthor.Next() = 0;

                                DCBookAuthors.Modify();

                                //Page.Run(Page::"DC Books Authors", DCBookAuthors);


                                if DCAuthor.Count = 1 then
                                    Authors := DCAuthor."Author Name"
                                else
                                    Authors := 'Multiple Authors';

                                DCAuthor.Reset();
                            end;


                            //Rec.Validate("Author ID", DCAuthor."Author ID");
                            //Rec.Validate("Author Name", DCAuthor."Author Name");
                            // Rec.Modify();*/
                        end;
                    end;
                }
                field(Genre; Rec.Genre)
                {
                    Caption = 'Genre';
                    ApplicationArea = All;
                    ToolTip = 'Enter the Genre of the book.';

                    /*trigger OnAssistEdit()
                    var
                    //DCGenreTable: Record "DC Genre Table";
                    begin
                        if Page.RunModal(Page::"DC Genre List Page", DCGenreTable) = Action::LookupOK then begin
                            //Rec.Validate("Genre ID", DCGenreTable."Genre ID");
                            //Rec.Validate(Genre, DCGenreTable.Genre);
                            Rec.Modify();
                        end;
                    end;*/
                }
                field("Book Price"; Rec."Book Price")
                {
                    Caption = 'Price';
                    ApplicationArea = All;
                    ToolTip = 'Enter this book"s price';
                }
            }
            group("Book Series")
            {
                Caption = 'Book Series';
                field(Series; Rec.Series)
                {
                    Caption = 'Series';
                    ApplicationArea = All;
                    ToolTip = 'Enter the Series the book is apart of.';
                }
                field(Prequel; Rec."Prequel Name")
                {
                    Caption = 'Prequel';
                    ApplicationArea = All;
                    ToolTip = 'Enter the Prequel name of this book.';
                }
                field(Sequel; Rec."Sequel Name")
                {
                    Caption = 'Sequel';
                    ApplicationArea = All;
                    ToolTip = 'Enter the Sequel name of this book.';
                }
            }
            group("More Information")
            {
                Caption = 'More Information';

                field(Publisher; Rec.Publisher)
                {
                    Caption = 'Publisher';
                    ApplicationArea = All;
                    ToolTip = 'Enter the Publisher name for this book.';
                }
                field("Publication Date"; Rec."Publication Date")
                {
                    Caption = 'Publication Date';
                    ApplicationArea = All;
                    ToolTip = 'Enter the Publication Date for this book';
                }
                field(Pages; Rec."Page Number")
                {
                    Caption = 'Page Number';
                    ApplicationArea = All;
                    ToolTip = 'Enter the total amount of Page Number this Book has.';
                }

            }
        }


    }

    actions
    {
        area(Processing)
        {
            action(UploadImage)
            {
                Image = Picture;
                Caption = 'Upload Book Cover';
                ToolTip = 'This will insert a manual image for the book.';
                ApplicationArea = All;

                trigger OnAction()
                var
                    GetImage: InStream;
                    InsertImage: OutStream;
                    Filename: Text;
                begin
                    if not UploadIntoStream('Upload Image', '', '', Filename, GetImage) then
                        exit;

                    Rec."Book Cover".ImportStream(GetImage, '');
                    Rec.Validate("Book Cover Filename", Filename);
                end;

            }
        }
    }


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        DCBookAuthors2: Record "DC Book Authors";
    begin
        if CloseAction = Action::LookupOK then begin
            if DCBookAuthors.FindSet() then begin
                repeat
                    DCBookAuthors2.Init();
                    DCBookAuthors2.Validate("Book Number", DCBookAuthors."Book Number");
                    DCBookAuthors2.Validate("Author ID", DCBookAuthors."Author ID");
                    DCBookAuthors2.Insert(true);
                until DCBookAuthors.Next() = 0;
                //Page.Run(Page::"DC Books Authors", DCBookAuthors2);
                DCBookAuthors2.Modify(true);
            end;
        end;
    end;

    trigger OnOpenPage()
    begin
        //Rec.Insert(false);
    end;

    var
        DCBookGenreEnum: Enum "DC Book Genre Enum";
        DCBookAuthors: Record "DC Book Authors" temporary;
        Authors: Text;
}