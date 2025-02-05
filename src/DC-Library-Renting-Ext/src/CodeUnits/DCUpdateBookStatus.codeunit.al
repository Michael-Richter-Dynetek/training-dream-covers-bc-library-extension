codeunit 50205 "DC Update Book Status"
{

    procedure UpdateBookStatus()
    var
        DCLibraryBookListTable: Record "DC Library Book List Table";
    begin
        AssignStatusAndFine(DCLibraryBookListTable);
    end;

    procedure UpdateBookStatus(CustomerID: Code[20])
    var
        DCLibraryBookListTable: Record "DC Library Book List Table";
    begin
        DCLibraryBookListTable.SetFilter("Customer Renting ID", CustomerID);

        AssignStatusAndFine(DCLibraryBookListTable);
    end;

    local procedure AssignStatusAndFine(var DCLibraryBookListTable: Record "DC Library Book List Table")
    var
        DCGeneralSetupTable: Record "DC Genral Setup Table";
        PreviousCustomer: Code[20];
        PreviousBookID: Code[20];
        TestCustomer: Code[20];
        CustomerHighestRating: Enum "DC Book Renting Status";
    begin

        DCLibraryBookListTable.SetFilter(Rented, 'true');
        DCLibraryBookListTable.SetCurrentKey("Customer Renting ID");

        if DCLibraryBookListTable.FindSet() then begin
            repeat
                DCLibraryBookListTable."Book Fine" := 0;
                TestCustomer := DCLibraryBookListTable."Customer Renting ID";

                case DCLibraryBookListTable."Date Rented" of
                    CalcDate('-1W', Today) .. Today:
                        DCLibraryBookListTable.Validate("Renting Status", Enum::"DC Book Renting Status"::" ");
                    CalcDate('-2W', Today) .. CalcDate('-1W', Today):
                        DCLibraryBookListTable.Validate("Renting Status", Enum::"DC Book Renting Status"::Mild);
                    CalcDate('-1M', Today) .. CalcDate('-2W', Today):
                        DCLibraryBookListTable.Validate("Renting Status", Enum::"DC Book Renting Status"::Medium);
                    CalcDate('-2M', Today) .. CalcDate('-1M', Today):
                        DCLibraryBookListTable.Validate("Renting Status", Enum::"DC Book Renting Status"::High);
                    else
                        DCLibraryBookListTable.Validate("Renting Status", Enum::"DC Book Renting Status"::Extreme);
                end;
                DCLibraryBookListTable.Modify();
                //DCLibraryBookListTable.Modify();


                if DCLibraryBookListTable."Customer Renting ID" = PreviousCustomer then
                    CompareCurrentHighestStatus(PreviousBookID, CustomerHighestRating)
                else begin
                    CompareCurrentHighestStatus(PreviousBookID, CustomerHighestRating);
                    CompareCurrentHighestWithCustomer(PreviousCustomer, CustomerHighestRating);
                    CustomerHighestRating := DCLibraryBookListTable."Renting Status";
                end;
                PreviousCustomer := DCLibraryBookListTable."Customer Renting ID";
                PreviousBookID := DCLibraryBookListTable."Book Number";
                DCLibraryBookListTable.Modify();

            until DCLibraryBookListTable.Next() = 0;

            CompareCurrentHighestWithCustomer(PreviousCustomer, CustomerHighestRating);
            //CustomerHighestRating := DCLibraryBookListTable."Renting Status";

            DCLibraryBookListTable.Modify();

        end
    end;



    local procedure CompareCurrentHighestStatus(BookNumber: Code[20]; var CurrentHighestStatus: Enum "DC Book Renting Status")
    var
        DCLibraryBookListTable: Record "DC Library Book List Table";
    begin
        if BookNumber = '' then
            exit;

        DCLibraryBookListTable.Get(BookNumber);
        if CurrentHighestStatus.AsInteger() < DCLibraryBookListTable."Renting Status".AsInteger() then begin
            CurrentHighestStatus := DCLibraryBookListTable."Renting Status";
        end;
    end;


    local procedure CompareCurrentHighestWithCustomer(CustomerNo: Code[20]; var CurrentHighestStatus: Enum "DC Book Renting Status")
    var
        Customer: Record Customer;
    begin
        if CustomerNo = '' then
            exit;

        Customer.Get(CustomerNo);
        if CurrentHighestStatus = Customer."Current Highest Renting Status" then
            exit;

        if Customer."Current Highest Renting Status" = Enum::"DC Book Renting Status"::Extreme then
            Customer.Validate("Book Probation", true)
        else if CurrentHighestStatus = Enum::"DC Book Renting Status"::Extreme then
            Customer.Validate("Book Probation", false);

        Customer.Validate("Current Highest Renting Status", CurrentHighestStatus);

    end;
}