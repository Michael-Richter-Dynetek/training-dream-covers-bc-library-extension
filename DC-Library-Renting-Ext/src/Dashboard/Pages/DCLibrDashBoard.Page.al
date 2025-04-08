page 50204 "DC Library DashBoard"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "DC Libr DashBoard";

    layout
    {
        area(Content)
        {
            group(Filters)
            {
                field("Author Filter"; AuthorFilter)
                {
                    trigger OnValidate()
                    begin
                        /*
                        AuthorFilter := '@*' + AuthorFilter + '*';
                        Rec.SetFilter("Author Filter", AuthorFilter);*/
                        if TestBrackets(AuthorFilter) then begin
                            Rec.SetAuthorFilter(AuthorFilter);
                            CurrPage.Update();
                        end
                        else
                            Error(GetLastErrorText());
                    end;
                }
                field("Genre Filter"; GenreFilter)
                {
                    trigger OnValidate()
                    var
                        NoBracketsAllowed: label 'No Brackets are Allowed.';
                    begin
                        /*if GenreFilter = Enum::"DC Book Genre Enum"::" " then begin
                            Rec.SetRange("Genre Filter");
                            CurrPage.Update();
                            exit;
                        end;
                        Rec.SetFilter("Genre Filter", '%1', GenreFilter);
                        CurrPage.Update();*/
                        //GenreFilter := '@*' + GenreFilter + '*';
                        if TestBrackets(GenreFilter) then begin
                            Rec.SetFilter("Genre Filter", '@*' + GenreFilter + '*');
                            CurrPage.Update();
                        end
                        else
                            Error(GetLastErrorText());
                    end;
                }
                field("Publishing Date Filter"; PublishingDateFilter)
                {
                    trigger OnValidate()
                    begin
                        if TestBrackets(PublishingDateFilter) then begin
                            Rec.SetFilter("Publishing Date Filter", PublishingDateFilter);
                            PublishingDateFilter := Rec.GetFilter("Publishing Date Filter");//TODO add to all fields
                            CurrPage.Update();
                        end
                        else
                            Error(GetLastErrorText());
                    end;
                }
                field("Book Added Date Filter"; BookAddedDateFilter)
                {
                    trigger OnValidate()
                    begin
                        if TestBrackets(BookAddedDateFilter) then begin
                            Rec.SetFilter("Book Added Date Filter", BookAddedDateFilter);
                            BookAddedDateFilter := Rec.GetFilter("Book Added Date Filter");
                            CurrPage.Update();
                        end
                        else
                            Error(GetLastErrorText());
                    end;
                }
            }
            group(BooksRented)
            {
                Caption = 'Books Rented';
                Editable = false;
                field("Total Available Books"; Rec."Total Available Books")
                {
                    DrillDownPageId = "DC Library Book list Page";
                }
                field("Total Rented Books"; Rec."Total Rented Books")
                {
                    ToolTip = 'Specifies the value of the Total Rented Books field.', Comment = '%';
                    DrillDownPageId = "DC Library Book list Page";
                }
            }
            group(BookStatus)
            {
                Caption = 'Book Status';
                Editable = false;
                field("Total Mild Books"; Rec."Total Mild Books")
                {
                    ToolTip = 'Specifies the value of the Total Mild Status Books field.', Comment = '%';
                    DrillDownPageId = "DC Library Book list Page";
                }
                field("Total Medium Books"; Rec."Total Medium Books")
                {
                    ToolTip = 'Specifies the value of the Total Medium Status Books field.', Comment = '%';
                    DrillDownPageId = "DC Library Book list Page";
                }
                field("Total High Books"; Rec."Total High Books")
                {
                    ToolTip = 'Specifies the value of the Total High Status Books field.', Comment = '%';
                    DrillDownPageId = "DC Library Book list Page";
                }
                field("Total Extreme Books"; Rec."Total Extreme Books")
                {
                    ToolTip = 'Specifies the value of the Total Extreme Status Books field.', Comment = '%';
                    DrillDownPageId = "DC Library Book list Page";
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.get() then begin
            Rec.Init();
            Rec.Insert();
        end;
        /*DCLibrDashBoard.CalcFields("Total Rented Books");
        DCLibrDashBoard.CalcFields("Total Mild Books");
        DCLibrDashBoard.CalcFields("Total Medium Books");
        DCLibrDashBoard.CalcFields("Total High Books");
        DCLibrDashBoard.CalcFields("Total Extreme Books");*/
    end;

    var
        AuthorFilter: Text[100];
        GenreFilter: Text[203] /*Enum "DC Book Genre Enum"*/;
        PublishingDateFilter: Text[100];
        BookAddedDateFilter: Text[100];

    //Rec: Record "DC Libr DashBoard";

    [TryFunction]
    local procedure TestBrackets(FilterText: Text)
    var
        NoBracketsAllowed: label 'No Brackets are Allowed.';
    begin
        if FilterText.Contains('(') or FilterText.Contains(')') then
            Error(NoBracketsAllowed);
    end;
}