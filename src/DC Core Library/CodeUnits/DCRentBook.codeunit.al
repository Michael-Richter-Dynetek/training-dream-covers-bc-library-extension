codeunit 50102 "DC Rent Book"
{
    /*trigger OnRun()
    begin
        RentBook();
    end;*/

    /// <summary>
    /// RunRentBookCode.
    /// </summary>
    /// <param name="CurrentRecord">Record "Library Book List Table".</param>
    procedure RunRentBookCode(CurrentRecord: Record "DC Library Book List Table");
    begin
        RentBook(CurrentRecord);
    end;

    local procedure IsBookRented(): Boolean
    begin

    end;

    local procedure RentBook(CurrentRecord: Record "DC Library Book List Table");
    var
        OldCustomerName: Text[100];
    begin
        OldCustomerName := CurrentRecord."Customer Renting Name";
        if Page.RunModal(Page::"DC Rent Book Page", CurrentRecord) = Action::LookupOK then begin
            if (OldCustomerName = CurrentRecord."Customer Renting Name") and not ((OldCustomerName = '') or (OldCustomerName = 'None')) then
                CurrentRecord."Rented Amount" += 1;
            CurrentRecord.Modify();
            CurrentRecord.Modify();
        end;

    end;
}