/// <summary>
/// This page will be used to rent a book
/// </summary>
page 50200 "DC Rent Book Page"
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
                field("Book Number"; Rec."Book Number")
                {
                    Caption = 'Book Number';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'This is the book Number of the book you are renting out.';
                    Visible = false;
                }
                field(Title; Rec.Title)
                {
                    Caption = 'Book Title';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'This is the Title of the book you are renting out.';
                }
                field("Customer Renting"; Rec."Customer Renting Name")
                {
                    Caption = 'Customer Renting';
                    ApplicationArea = All;
                    ToolTip = 'Enter the Customer who will be Renting the book.';

                    trigger OnAssistEdit();
                    var
                        Customer: Record Customer;
                        CustomerNotAllowedMessage: Label 'The customer "%1" is not allowed to rent this book, since they have "%2" books outstanding and have a status of "%3", with probation:"%4"';
                        CustomerOnProbation: Label 'The customer "%1" is currently on probation until %2';
                        CustomerBooksOutstanding: Label 'The customer "&1" is at a "%2" status, since they have %3 books outstanding.';
                    begin
                        //don't increase book amount here since the user can click cancel
                        if Page.RunModal(Page::"Customer List", Customer) = Action::LookupOK then
                            if Customer."Current Highest Renting Status" = Enum::"DC Book Renting Status"::Mild then
                                if Customer."Books Rented" >= 3 then begin
                                    Customer.Validate("Allowed To Rent", false);
                                    Customer.Modify(true);
                                end;
                        if Customer."Allowed To Rent" then begin
                            Rec."Customer Renting ID" := Customer."No."; //do not use validate, it gives error because FlowField
                            Rec."Customer Renting Name" := Customer.Name;
                            Rec.Modify();
                            Customer.Modify();

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


                        end;
                        //Message(CustomerNotAllowedMessage, Customer.Name, Customer."Books Rented", Customer."Current Highest Renting Status", Customer."Book Probation");

                    end;
                }

            }
            /*
            group(Button)
            {
                field(clearRentingName; ClearRentingName)
                {
                    Caption = 'Clear Renting Customer';
                    ApplicationArea = All;
                    ToolTip = 'This button will remove the current Renting Customer.';

                    trigger OnValidate()
                    begin
                        if ClearRentingName = true then begin
                            Rec."Customer Renting ID" := '';
                            Rec."Customer Renting Name" := '';
                            ClearRentingName := false;
                        end;
                    end;
                }
            }
            */
        }
    }

    actions
    {
        area(Processing)
        {   /*
            action(ClearRentingCustomer)//TODO Change this to a function that will return the book
            {
                Caption = 'Clear Renting Customer';
                ApplicationArea = All;
                ToolTip = 'This button will remove the current Renting Customer.';
                Image = RemoveContacts;

                trigger OnAction()
                begin
                    Rec.Validate("Customer Renting ID", '');
                    Rec.Validate("Customer Renting Name", '');
                    ClearRentingName := false;
                    Rec.Modify();
                end;
            }*/
        }
    }

    var
        ClearRentingName: Boolean;


}