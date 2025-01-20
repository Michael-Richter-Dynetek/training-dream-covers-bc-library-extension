codeunit 50105 "DC Set 2Y Publish Filter"
{

    procedure Set2YFilter(var MainBookList: Record "DC Library Book List Table");
    var
        TwoYDate: Date;
    begin
        TwoYDate := CalcDate('-2Y', Today);
        MainBookList.SetFilter("Publication Date", '>%1', TwoYDate);
    end;


}