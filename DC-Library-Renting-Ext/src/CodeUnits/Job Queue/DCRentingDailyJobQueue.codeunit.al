codeunit 50203 "DC Renting Daily Job Queue"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        DCUpdateBookStatus: Codeunit "DC Update Book Status";
        DCUpdateCustomerStatus: Codeunit "DC Update Customer Status";
        DCAssignRanking: Codeunit "DC Assign Ranking Code";
    begin


        case Rec."Parameter String" of
            'Load_Book_Statuses':
                begin
                    DCUpdateBookStatus.UpdateBookStatus();
                    DCUpdateCustomerStatus.Run();
                end;
            'Load_Rented_Amount':
                DCAssignRanking.Run();
        end;
    end;



}