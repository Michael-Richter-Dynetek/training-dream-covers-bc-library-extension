pageextension 50200 "DC Rent Library List" extends "DC Library Book list Page"
{
    layout
    {
        addafter(Author)
        {

            field(Rented; Rec.Rented)
            {
                Caption = 'Rented';
                ApplicationArea = All;
                ToolTip = 'This indicates if the Book is Rented.';
            }
            field("Customer Renting"; Rec."Customer Renting Name")
            {
                Caption = 'Customer Renting Book';
                Visible = false;
                ApplicationArea = All;
                ToolTip = 'This is the Customer currently renting the Book.';
            }
            field("Renting Status"; Rec."Renting Status")
            {
                Caption = 'Renting Status';
                Visible = true;
                ApplicationArea = All;
                ToolTip = 'This is the status for the current rented Book.';
            }
            field("Customer Renting Name"; Rec."Customer Renting Name")
            {
                Caption = 'Customer Renting';
                ApplicationArea = all;
                ToolTip = 'This is the customer currently renting the book.';
                DrillDownPageId = "Customer Card";

                /*trigger OnDrillDown()
                var
                //CustomerCard: Page "Customer Card";
                begin
                    Page.RunModal(Page::"Customer Card", Rec);
                end;*/
            }
        }

        addafter("Book Price")
        {
            field("Rented Amount"; Rec."Rented Amount")
            {
                Caption = 'Rented Amount';
                ApplicationArea = All;
                ToolTip = 'This is the Amount of times customers have Rented the current book.';
            }
        }
    }



    actions
    {
        addlast(Processing)
        {
            /// <summary>
            /// This will display the top rated books in a message
            /// </summary>
            action(TopRented)
            {
                Caption = 'Top Rented Books';
                ApplicationArea = All;
                Image = AboutNav;
                ToolTip = 'This will display the top 3 rented books.';

                trigger OnAction()
                var
                    DisplayTopRented: Codeunit "DC Top Three Rented Books";
                begin
                    //run codeunit to sort list according to rented then take 3 and display as message
                    DisplayTopRented.DisplayBooks(xRec);
                end;
            }
            action(RentBook)
            {
                Caption = 'Rent Book';
                ApplicationArea = All;
                Image = Addresses;
                ToolTip = 'This allows the user to Rent out a Book.';

                trigger OnAction()
                var
                    DCManageRentBook: Codeunit "DC Manage Rent Book Code";
                begin
                    DCManageRentBook.RunRentBookCode(Rec);
                end;
            }
            action(ReturnBook)
            {
                Caption = 'Return Book';
                ApplicationArea = All;
                Image = ShipAddress;
                ToolTip = 'This allows the user to Return a Book';

                trigger OnAction()
                var
                    DCUpdateBookStatus: Codeunit "DC Update Book Status";
                    DCManageRentBook: Codeunit "DC Manage Rent Book Code";
                    DCEndProbation: Codeunit "DC Update Customer Status";
                begin
                    DCManageRentBook.ReturnBook(Rec, false);
                    DCUpdateBookStatus.UpdateBookStatus(Rec."Customer Renting ID");
                    DCEndProbation.Run();
                    CurrPage.Update(true);
                end;
            }

            action(OverdueRentingCustomers)
            {
                Caption = 'View Overdue Customers';
                ApplicationArea = All;
                Image = Absence;
                ToolTip = 'View All the Customers that have Overdue Books.';

                trigger OnAction()
                begin
                    Page.RunModal(Page::"DC Customers Overdue Page");
                end;
            }

            action(LoadStatus)
            {
                Caption = 'Load Status';
                Image = Action;

                trigger OnAction()
                var
                    DCAssignStatusCode: Codeunit "DC Update Book Status";
                    DCEndProbation: Codeunit "DC Update Customer Status";
                begin
                    DCAssignStatusCode.UpdateBookStatus();
                    DCEndProbation.Run();
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        DCAssignStatusCode: Codeunit "DC Update Book Status";
        DCEndProbation: Codeunit "DC Update Customer Status";
    begin
        if RunOnce = false then begin
            RunOnce := true;
            DCAssignStatusCode.UpdateBookStatus();
            DCEndProbation.Run();
        end;

    end;

    var
        RunOnce: Boolean;
}