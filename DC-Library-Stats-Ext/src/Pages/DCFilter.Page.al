/// <summary>
/// Page DC Filter Page (ID 50150).
/// This is the page that will contain the list of current books as wel as option on how to filter it.
/// </summary>
page 50150 "DC Filter Page"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "DC Library Book List Table";
    CardPageId = 50101;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            group(Filters)
            {
                /*
                field(DateFromFilter; DateFromFilter)
                {
                    Caption = 'Date Filter From';
                    ApplicationArea = all;
                    ToolTip = 'Enter the Date you would like to Filter From.';

                    trigger OnValidate()
                    begin
                        If DateToFilter <> 0D then begin
                            Rec.SetRange("Publication Date");
                            Rec.SetRange("Publication Date", DateFromFilter, DateToFilter)
                        end
                        else if DateFromFilter <> 0D then begin
                            Rec.SetRange("Publication Date");
                            Rec.SetRange("Publication Date", DateFromFilter, );
                        end
                        else
                            Rec.SetRange("Publication Date");
                        CurrPage.Update();
                    end;
                }
                field(DateToFilter; DateToFilter)
                {
                    Caption = 'Date Filter To';
                    ApplicationArea = all;
                    ToolTip = 'Enter the Date you would like to Filter To.';

                    trigger OnValidate()
                    begin
                        If DateFromFilter <> 0D then begin
                            Rec.SetRange("Publication Date");
                            Rec.SetRange("Publication Date", DateFromFilter, DateToFilter)
                        end
                        else if DateToFilter <> 0D then begin
                            Rec.SetRange("Publication Date");
                            Rec.SetRange("Publication Date", DateToFilter);
                        end
                        else
                            Rec.SetRange("Publication Date");
                        CurrPage.Update();
                    end;
                }*/
                field(DateFilter; DateFilter)
                {
                    Caption = 'Date Filter To';
                    ApplicationArea = all;
                    ToolTip = 'Enter the Date you would like to Filter according to (ranges are supported).';

                    trigger OnValidate()
                    begin
                        Rec.SetFilter("Publication Date", DateFilter);
                        CurrPage.Update();
                    end;
                }
                field(RentedAmountFilter; RentedAmountFilter)
                {
                    Caption = 'Rented Amount Filter';
                    ApplicationArea = all;
                    ToolTip = 'Enter the Amount you would like to Filter according to.';

                    trigger OnValidate()
                    begin
                        Rec.SetFilter("Rented Amount", RentedAmountFilter);
                        CurrPage.Update();
                    end;

                }
                field(BookPriceFilter; BookPriceFilter)
                {
                    Caption = 'Book Price Filter';
                    ApplicationArea = all;
                    ToolTip = 'Enter the Book Price you would like to Filter according to.';

                    trigger OnValidate()
                    begin
                        Rec.SetFilter("Book Price", BookPriceFilter);
                        CurrPage.Update();
                    end;
                }
                field(DCBookGenreEnum; DCBookGenreEnum)
                {
                    Caption = 'Genre';
                    ApplicationArea = all;
                    ToolTip = 'Enter Genre you would like to Filter to.';
                    trigger OnValidate()
                    begin
                        Rec.SetFilter(Genre, Format(DCBookGenreEnum));
                        CurrPage.Update();
                    end;
                }
                field("DC Filter Text Options Enum"; DCFilterTextOptionsEnum)
                {
                    Caption = 'Category Filter';
                    ApplicationArea = all;
                    ToolTip = 'Enter the Category you would like to Filter according to.';

                    trigger OnValidate()
                    var
                        DCCategoryFilterCode: Codeunit "DC Category Filter Code";
                    begin
                        DCCategoryFilterCode.FilterTextOptions(Rec, DCFilterTextOptionsEnum, MiscTextFilter);
                        CurrPage.Update();
                    end;
                }
                field(MiscTextFilter; MiscTextFilter)
                {
                    Caption = 'Text Filter';
                    ApplicationArea = all;
                    ToolTip = 'Enter Text you would like to Filter to.';

                    trigger OnValidate()
                    var
                        DCCategoryFilterCode: Codeunit "DC Category Filter Code";
                    begin
                        DCCategoryFilterCode.FilterTextOptions(Rec, DCFilterTextOptionsEnum, MiscTextFilter);
                        CurrPage.Update();
                    end;
                }


            }
            repeater(FilterTable)
            {
                Editable = false;
                field("Book Number"; Rec."Book Number")
                {
                    Caption = 'Book Number';
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    Caption = 'Title';
                    ApplicationArea = All;
                }
                /*field(Author; Rec.Author)
                {
                    Caption = 'Author';
                    ApplicationArea = All;
                }*/
                field(Rented; Rec.Rented)
                {
                    Caption = 'Rented';
                    ApplicationArea = All;
                }
                field("Customer Renting"; Rec."Customer Renting Name")
                {
                    Caption = 'Customer Renting Book';
                    ApplicationArea = All;
                }
                field(Series; Rec.Series)
                {
                    Caption = 'Series';
                    ApplicationArea = All;
                }
                field(Genre; Rec.Genre)
                {
                    Caption = 'Genre';
                    ApplicationArea = All;
                }
                field("Book Price"; Rec."Book Price")
                {
                    Caption = 'Price';
                    ApplicationArea = All;
                }
                field(Publisher; Rec.Publisher)
                {
                    Caption = 'Publisher';
                    ApplicationArea = All;
                }
                field("Publication Date"; Rec."Publication Date")
                {
                    Caption = 'Publication Date';
                    ApplicationArea = All;
                }
                field(Pages; Rec."Page Number")
                {
                    Caption = 'Number of Pages';
                    ApplicationArea = All;
                }
                field(Prequel; Rec."Prequel Name")
                {
                    Caption = 'Prequel';
                    ApplicationArea = All;
                }
                field(Sequel; Rec."Sequel Name")
                {
                    Caption = 'Sequel';
                    ApplicationArea = All;
                }
                field("Rented Amount"; Rec."Rented Amount")
                {
                    Caption = 'Rented Amount';
                    ApplicationArea = All;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(MainListPage)
            {
                Caption = 'Navigate to Book List Page';
                Image = LedgerBook;
                ToolTip = 'This will navigate you to the Book List page.';
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Page.Run(Page::"DC Library Book list Page", Rec)
                end;
            }
            action(RemoveFilters)
            {
                Caption = 'Remove All Filters';
                ApplicationArea = all;
                ToolTip = 'This action will Remove All current Filters.';
                Image = RemoveFilterLines;

                trigger OnAction()
                begin
                    if Confirm(ConfirmRemoveFilterLabel) then begin
                        Rec.Reset();
                        System.Clear(DateFromFilter);
                        System.Clear(DateToFilter);
                        System.Clear(RentedAmountFilter);
                        System.Clear(BookPriceFilter);
                        System.Clear(MiscTextFilter);
                        System.Clear(DCFilterTextOptionsEnum);
                    end;
                end;
            }
        }
    }

    var
        MiscTextFilter: Text[100];
        DateFromFilter: Date;
        DateToFilter: Date;
        DateFilter: Text[100];
        RentedAmountFilter: Text[100];
        BookPriceFilter: Text[100];
        DCFilterTextOptionsEnum: Enum "DC Filter Text Options Enum";
        DCBookGenreEnum: Enum "DC Book Genre Enum";
        ConfirmRemoveFilterLabel: Label 'Are you sure you want to remove all filters';


}