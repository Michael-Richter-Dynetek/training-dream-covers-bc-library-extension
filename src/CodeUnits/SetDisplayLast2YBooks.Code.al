codeunit 50105 Set2YPublishFilter
{

    procedure Set2YFilter(var MainBookList: Record "Library Book List Table");
    var
        TwoYDate: Date;
    begin
        TwoYDate := CalcDate('-2Y', Today);
        MainBookList.SetFilter("Publication Date", '>%1', TwoYDate);
    end;


}