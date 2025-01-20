codeunit 50103 "DC On Library Table Modify"
{
    procedure RunOnLibraryTableModify(CurrentRecord: Record "DC Library Book List Table");
    var
    begin
        //run everything from here
        AssignRentedStatus(CurrentRecord);
    end;

    //add methods that test if there is a name in the 
    local procedure AssignRentedStatus(CurrentRecord: Record "DC Library Book List Table")
    begin
        if (CurrentRecord."Customer Renting Name" = 'None') or (CurrentRecord."Customer Renting Name" = '') then begin
            CurrentRecord.Rented := false;
            //CurrentRecord."Customer Renting" := 'None';
            CurrentRecord.Modify();
        end
        else begin
            CurrentRecord.Rented := true;
            CurrentRecord."Rented Amount" += 1;
            CurrentRecord.Modify()
        end;

    end;
}