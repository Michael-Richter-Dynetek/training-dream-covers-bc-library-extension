codeunit 50204 "DC Update Customer Status"
{
    trigger OnRun()
    begin
        EndProbation();
        MakeCustomerBeAbleToRentBook();
    end;



    local procedure EndProbation()
    var
        Customer: Record Customer;
    begin
        Customer.SetFilter("Book Probation", 'true');
        if Customer.FindSet() then
            repeat
                if Customer."Book Probation Started" < CalcDate('-6M', Today) then begin
                    Customer.Validate("Book Probation", false);
                    Customer.Modify(true);
                end;
            until Customer.Next() = 0;
    end;

    Local procedure MakeCustomerBeAbleToRentBook()
    var
        Customer: Record Customer;
        CustRecordref: RecordRef;
        MyFieldRef: FieldRef;
        CustomerTable: Integer;
        CustomerBooksRented: Integer;
    begin
        CustomerTable := Database::Customer;
        CustRecordref.Open(CustomerTable);


        //used to run calc field, since field in customer is not calculated.
        /*if CustRecordref.FindSet() then
            repeat
                MyFieldRef := CustRecordref.Field(50200);
                MyFieldRef.CalcField;
            until CustRecordref.Next() = 0;*/

        //Customer.LoadFields("Current Highest Renting Status", "Books Rented", "Allowed To Rent");
        Customer.SetCurrentKey("No.");
        Customer.FindFirst();
        if Customer.FindSet() then
            repeat
                SetIndividualStatus(Customer);
            until Customer.Next() = 0;
    end;

    local procedure SetIndividualStatus(var Customer: Record Customer)
    begin
        if Customer."Book Probation" then begin
            Customer."Allowed To Rent" := false;
            Customer.Modify();
            exit;
        end;


        if (Customer."Books Rented" = 0)then begin
            Customer.Validate("Current Highest Renting Status", Enum::"DC Book Renting Status"::" ");
            Customer.Modify();
        end;

        case Customer."Current Highest Renting Status" of
            Enum::"DC Book Renting Status"::" ":
                begin
                    Customer.Validate("Allowed To Rent", true);
                end;
            Enum::"DC Book Renting Status"::Mild:
                if Customer."Books Rented" < 3 then
                    Customer.Validate("Allowed To Rent", true);
            else
                Customer.Validate("Allowed To Rent", false);
        end;
        Customer.Modify();
    end;
}