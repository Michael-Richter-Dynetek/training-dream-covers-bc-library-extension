pageextension 50201 "DC Book Details Renting Ext" extends "DC Book Details"
{
    layout
    {
        addafter("Main Information")
        {
            group("Renting Information")
            {
                Caption = 'Renting Information';
                field("Book Price"; Rec."Book Price")
                {
                    Caption = 'Price';
                    ApplicationArea = All;
                    ToolTip = 'Enter the Title of the book.';
                    Editable = true;
                }
                field(Rented; Rec.Rented)
                {
                    Caption = 'Rented';
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'This shows if the book is currently rented.';

                    trigger OnValidate()
                    begin
                        if Rec.Rented = false then begin
                            Rec."Customer Renting ID" := '';
                            Rec."Customer Renting Name" := '';
                            //gives field must be decimal error.
                            //Rec.Validate("Customer Renting ID", '');
                            //Rec.Validate("Customer Renting Name", '');
                            Rec.Modify();
                        end;
                    end;
                }
                field("Customer Renting"; Rec."Customer Renting Name")
                {
                    Caption = 'Customer Renting Book';
                    ApplicationArea = All;
                    ToolTip = 'This is the customer currently renting the book.';
                    Editable = false;

                    /*trigger OnAssistEdit()
                    var
                        Customer: Record Customer;
                    begin
                        if Page.RunModal(Page::"Customer List", Customer) = Action::LookupOK then begin
                            Rec."Customer Renting ID" := Customer."No.";
                            Rec."Customer Renting Name" := Customer.Name;
                            //gives field must be decimal error.
                            //Rec.Validate("Customer Renting ID", Customer."No.");
                            //Rec.Validate("Customer Renting Name", Customer.Name);
                            Rec.Validate(Rented, true);
                            if xRec."Customer Renting ID" <> Rec."Customer Renting ID" then
                                Rec."Rented Amount" += 1;
                            Rec.Modify();
                        end;

                    end;*/
                }
                field("Rented Amount"; Rec."Rented Amount")
                {
                    Caption = 'Rented Amount';
                    ApplicationArea = All;
                    ToolTip = 'This is the Amount of times the book has been rented out.';
                    Editable = false;
                }
                field("Last Rented Date"; Rec."Date Rented")
                {
                    Caption = 'Last Rented Date';
                    ApplicationArea = All;
                    ToolTip = 'This is the Amount of times the book has been rented out.';
                    Editable = true;
                }
                field("Date Returned"; Rec."Date Returned")
                {
                    Caption = 'Date Returned';
                    ApplicationArea = All;
                    ToolTip = 'This is the Amount of times the book has been rented out.';
                    Editable = false;
                }
                field("Renting Status"; Rec."Renting Status")
                {
                    Caption = 'Renting Status';
                    ApplicationArea = All;
                    ToolTip = 'This is the Amount of times the book has been rented out.';
                    Editable = false;
                }
                field("Book Fine"; Rec."Book Fine")
                {
                    Caption = 'Book Fine';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}