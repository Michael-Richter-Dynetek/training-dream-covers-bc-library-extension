codeunit 50103 OnLibraryTableModify
{
    procedure RunOnLibraryTableModify(CurrentRecord: Record "Library Book List Table");
    var
    begin
        //run everything from here
        AssignRentedStatus(CurrentRecord);
    end;

    //add methods that test if there is a name in the 
    local procedure AssignRentedStatus(CurrentRecord: Record "Library Book List Table")
    begin
        if (CurrentRecord."Customer Renting" = 'None') or (CurrentRecord."Customer Renting" = '') then begin
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