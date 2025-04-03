/// <summary>
/// This page will be used to rent a book
/// </summary>
page 50205 "DC Rent Multiple Books Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "DC Library Book List Table";


    layout
    {
        area(Content)
        {
            group("RentBook")
            {
                Caption = 'Rent a Book';
                field("Customer Renting"; Rec."Customer Renting Name")
                {
                    Caption = 'Customer Renting';
                    ApplicationArea = All;
                    ToolTip = 'Enter the Customer who will be Renting the book.';

                    trigger OnAssistEdit();
                    var
                        Customer: Record Customer;
                        AllowedToRent: Boolean;
                        CustomerNotAllowedMessage: Label 'The customer "%1" is not allowed to rent this book, since they have "%2" books outstanding and have a status of "%3", with probation:"%4"';
                        CustomerOnProbation: Label 'The customer "%1" is currently on probation until %2';
                        CustomerBooksOutstanding: Label 'The customer "&1" is at a "%2" status, since they have %3 books outstanding.';
                        ToManyBooksError: Label ' The customer "%1" is trying to rent to many books, while having a "Mild" status';
                    begin
                        //don't increase book amount here since the user can click cancel
                        AllowedToRent := true;
                        if Page.RunModal(Page::"Customer List", Customer) = Action::LookupOK then
                            if Customer."Current Highest Renting Status" = Enum::"DC Book Renting Status"::Mild then begin
                                if (Customer."Books Rented" + Rec.Count) >= 3 then
                                    AllowedToRent := false;
                                if Customer."Books Rented" >= 3 then begin
                                    Customer.Validate("Allowed To Rent", false);
                                    Customer.Modify(true);
                                end;
                            end;


                        if Customer."Allowed To Rent" and AllowedToRent then begin
                            repeat
                                Rec."Customer Renting ID" := Customer."No."; //do not use validate, it gives error because FlowField
                                Rec."Customer Renting Name" := Customer.Name;
                                Rec.Modify();
                            until Rec.Next() = 0;
                        end
                        else begin
                            if Customer."Book Probation" then begin
                                Rec.FieldError("Customer Renting Name", StrSubstNo(CustomerOnProbation, Customer.Name, CalcDate('<+6M>', Customer."Book Probation Started")));
                                exit;
                            end;

                            //if mild then more than three books outstanding;
                            if Customer."Current Highest Renting Status".asInteger() >= Enum::"DC Book Renting Status"::Mild.asInteger() then begin
                                Rec.FieldError("Customer Renting Name", StrSubstNo(CustomerBooksOutstanding, Customer.Name, Customer."Current Highest Renting Status", Customer."Books Rented"));
                                exit;
                            end;

                            if not AllowedToRent then begin
                                Rec.FieldError("Customer Renting Name", StrSubstNo(ToManyBooksError, Customer.Name));
                                exit;
                            end;
                        end;
                    end;
                }

            }
            group("Books Rented")
            {
                Caption = 'Books Being Rented';
                part("DC Library Card Part"; "DC Library Card Part")
                {
                    SubPageLink = "Book Number" = field("Book Authors Filter");
                }
            }
        }

    }

    trigger OnAfterGetRecord()
    begin
        generateFilterText();
    end;

    local procedure generateFilterText()
    var
        FirstBook: Boolean;
        BookFilterText: Text;
    begin
        FirstBook := true;
        BookFilterText := '';
        if Rec.FindSet() then begin
            repeat
                if FirstBook then begin
                    FirstBook := false;
                    BookFilterText += Rec."Book Number";
                end
                else
                    BookFilterText += '|' + Rec."Book Number";
            until Rec.Next() = 0;
            Rec.FindFirst();
            Rec.SetFilter("Book Authors Filter", BookFilterText);
        end;
    end;

}