codeunit 50202 "DC HighestRentingStatusChange"
{
    var
        CustomerStatusMessage: Label 'Customer "%1" has reached status "%2".';

    procedure HighestStatusChanged(Customer: Record Customer)
    begin
        if Customer."Current Highest Renting Status".AsInteger() > Customer."Highest Renting Status".AsInteger() then
            Customer."Highest Renting Status" := Customer."Current Highest Renting Status";

        case Customer."Current Highest Renting Status" of
            Enum::"DC Book Renting Status"::" ":
                Customer."Allowed To Rent" := true;
            Enum::"DC Book Renting Status"::Mild:
                begin
                    if Customer."Books Rented" >= 3 then
                        NotifyAndDenyCustomer(Customer, false)
                    else
                        NotifyAndDenyCustomer(Customer, true);
                end;
            Enum::"DC Book Renting Status"::Medium:
                NotifyAndDenyCustomer(Customer, false);
            Enum::"DC Book Renting Status"::High:
                NotifyAndDenyCustomer(Customer, false);
            Enum::"DC Book Renting Status"::Extreme:
                NotifyAndDenyCustomer(Customer, false);
            else
        end;

        Customer.Modify();
    end;

    local procedure NotifyAndDenyCustomer(var Customer: Record Customer; isAllowedToRent: Boolean)
    begin
        Customer."Allowed To Rent" := isAllowedToRent;
        Message(CustomerStatusMessage, Customer.Name, Customer."Current Highest Renting Status");
    end;
}