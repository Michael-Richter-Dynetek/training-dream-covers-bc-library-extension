/// <summary>
/// This Page will be used to display a single book's details
/// </summary>
page 50101 "DC Book Details"
{
    Caption = 'Book Details';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "DC Library Book List Table";


    layout
    {
        area(Content)
        {
            group("Main Information")
            {
                /// <remarks>
                /// These are all the fields related to the Book
                /// </remarks>
                Caption = 'Main Information';
                field("Book Number"; Rec."Book Number")
                {
                    Caption = 'Book Number';
                    Editable = true;
                    ApplicationArea = All;
                    ToolTip = 'This is the auto assigned book Number.';
                    Visible = false;
                }
                field(Title; Rec.Title)
                {
                    Caption = 'Title';
                    ApplicationArea = All;
                    ToolTip = 'This is the book Title.';
                    Editable = true;
                }
                field(Author; Rec."Author Name")
                {
                    Caption = 'Author';
                    ApplicationArea = All;
                    ToolTip = 'This is the book Author.';
                    Editable = true;

                    trigger OnAssistEdit()
                    var
                        DCAuthor: Record "DC Author";
                    begin
                        if Page.RunModal(Page::"DC Author List", DCAuthor) = Action::LookupOK then begin
                            Rec.Validate("Author ID", DCAuthor."Author ID");
                            Rec.Validate("Author Name", DCAuthor."Author Name");
                            Rec.Modify();
                        end;
                    end;

                }
            }
            group("Book Series")
            {
                Caption = 'Book Series';
                field(Series; Rec.Series)
                {
                    Caption = 'Series';
                    ApplicationArea = All;
                    ToolTip = 'This is the Series the book is apart of.';
                    Editable = true;
                }
                field(Prequel; Rec."Prequel Name")
                {
                    Caption = 'Prequel';
                    ApplicationArea = All;
                    ToolTip = 'This is the Prequel Title to this book.';
                    Editable = true;
                }
                field(Sequel; Rec."Sequel Name")
                {
                    Caption = 'Sequel';
                    ApplicationArea = All;
                    ToolTip = 'This is the Sequel Title to this book.';
                    Editable = true;
                }
            }
            group("More Information")
            {
                field(Genre; Rec.Genre)
                {
                    Caption = 'Genre';
                    ApplicationArea = All;
                    ToolTip = 'This is the genre of this book.';
                    //Editable = true;

                    /*trigger OnAssistEdit()
                    var
                        DCGenreTable: Record "DC Genre Table";
                    begin
                        if Page.RunModal(Page::"DC Genre List Page", DCGenreTable) = Action::LookupOK then begin
                            Rec.Validate("Genre ID", DCGenreTable."Genre ID");
                            Rec.Validate(Genre, DCGenreTable.Genre);
                            Rec.Modify();
                        end;
                    end;*/
                }

                field(Publisher; Rec.Publisher)
                {
                    Caption = 'Publisher';
                    ApplicationArea = All;
                    ToolTip = 'This is the book publisher.';
                    Editable = true;
                }
                field("Publication Date"; Rec."Publication Date")
                {
                    Caption = 'Publication Date';
                    ApplicationArea = All;
                    ToolTip = 'This is the Publication Date.';
                    Editable = true;
                }
                field(Pages; Rec."Page Number")
                {
                    Caption = 'Page Number';
                    ApplicationArea = All;
                    ToolTip = 'This is the total Amount of pages in the Book.';
                    Editable = true;
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            /// <summary>
            /// This action will delete the current selected record.
            /// The currently selected record is the record open.
            /// </summary>
            action(Delete)
            {
                Image = RemoveLine;
                Caption = 'Remove Book';
                ToolTip = 'This will remove the current book';
                ApplicationArea = All;

                trigger OnAction()
                var
                    DCManageBooks: Codeunit "DC Manage Books Code";
                begin
                    DCManageBooks.RemoveBook(Rec);
                end;
            }
            action(AddSequel)
            {
                Image = Add;
                Caption = 'Add A Sequel';
                ToolTip = 'This will add a sequel to the current book';
                ApplicationArea = All;

                trigger OnAction()
                var
                    DCManageBooks: Codeunit "DC Manage Books Code";
                begin
                    DCManageBooks.AddSequelAndSeries(Rec);
                end;
            }
        }
    }



    var
        DCBookGenreEnum: Enum "DC Book Genre Enum";
}