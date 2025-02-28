namespace Microsoft.Purchases.Document;

using Microsoft.Foundation.Address;
using Microsoft.Foundation.Company;
using Microsoft.Foundation.PaymentTerms;
using Microsoft.Foundation.Shipping;
using Microsoft.Inventory.Location;

report 50100 "Purchase Order Report"
{
    Caption = 'Purchase Order Report';
    UsageCategory = Administration;
    ApplicationArea = All;
    //DefaultLayout = Word;
    //WordLayout = './src/Reports/Report layouts/PurchaseOrderReport.docx';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Report Layouts/PurchaseOrderReport.rdl';

    dataset
    {

        dataitem("Purchase Header"; "Purchase Header")
        {
            column(CompanyAddress1; CompanyAddr[1])
            {

            }
            column(CompanyAddress2; CompanyAddr[2])
            {

            }
            column(CompanyAddress3; CompanyAddr[3])
            {

            }
            column(CompanyAddress4; CompanyAddr[4])
            {

            }
            column(CompanyAddress5; CompanyAddr[5])
            {

            }
            column(ShipToAddr1; ShipToAddr[1]) { }
            column(ShipToAddr2; ShipToAddr[2]) { }
            column(ShipToAddr3; ShipToAddr[3]) { }
            column(ShipToAddr4; ShipToAddr[4]) { }
            column(ShipToAddr5; ShipToAddr[5]) { }
            column(BuyFromAddr1; BuyFromAddr[1]) { }
            column(BuyFromAddr2; BuyFromAddr[2]) { }
            column(BuyFromAddr3; BuyFromAddr[3]) { }
            column(BuyFromAddr4; BuyFromAddr[4]) { }
            column(BuyFromAddr5; BuyFromAddr[5]) { }
            column(PageLabel; PageLabel) { }
            column(BuyerLabel; BuyerLabel) { }
            column(VATAmtLineLabel; VATAmtLineLabel) { }
            column(ReceivedByLabel; ReceivedByLabel) { }
            column(CompanyGiroNoLabel; CompanyGiroNoLabel) { }
            column(DirectUniCostLabel; DirectUniCostLabel) { }
            column(DocumentTitleLabel; DocumentTitleLabel) { }
            column(VendorOrderNoLabel; VendorOrderNoLabel) { }
            column(ItemLineAmountLabel; ItemLineAmountLabel) { }
            column(NoPurchaseLineLabel; NoPurchaseLineLabel) { }
            column(QtyPruchaseLineLabel; QtyPruchaseLineLabel) { }
            column(UOMPurchaseLineLabel; UOMPurchaseLineLabel) { }
            column(VendorInvoiceNoLabel; VendorInvoiceNoLabel) { }
            column(DescPurchaseLineLabel; DescPurchaseLineLabel) { }
            column(PaymentTermsDescLabel; PaymentTermsDescLabel) { }
            column(ShipmentMethodDescLabel; ShipmentMethodDescLabel) { }
            column(CompanyVATRegistrationLabel; CompanyVATRegistrationLabel) { }
            column(PricesIncVAT_PurchaseHeaderLabel; PricesIncVAT_PurchaseHeaderLabel) { }
            column(ShipToAddressLabel; ShipToAddressLabel) { }
            column(VATNoLabel; VATNoLabel) { }
            column(TotalAmountExclVATLabel; TotalAmountExclVATLabel) { }
            column(TotalAmountInclVATLabel; TotalAmountInclVATLabel) { }
            column(TotalAmountVATLabel; TotalAmountVATLabel) { }

            column(ShipmentMethodDesc; ShipmentMethod.Description)
            {
            }
            column(DocumentDate_PurchaseHeader; Format("Document Date", 0, '<day,2>/<Month,2>/<Year4>'))
            {
            }
            column(ExpectedReceiptDate_PurchaseHeader; Format("Expected Receipt Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(No_PurchaseHeader; "No.")
            {
            }
            column(PricesIncludingVAT_PurchaseHeader; "Prices Including VAT")
            {
            }
            column(VendorInvoiceNo_PurchaseHeader; "Vendor Invoice No.")
            {
            }
            column(VendorOrderNo_PurchaseHeader; "Vendor Order No.")
            {
            }

            dataitem("Payment Terms"; "Payment Terms")
            {
                DataItemLink = Code = field("Payment Terms Code");

                column(Description; Description) { }
            }


            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Line No.");



                column(Description_PurchaseLine; Description)
                {
                }
                column(DirectUnitCost_PurchaseLine; "Direct Unit Cost")
                {
                }
                column(LineAmount_PurchaseLine; "Line Amount")
                {
                }
                column(No_PurchaseLine; "No.")
                {
                }
                column(Quantity_PurchaseLine; Quantity)
                {
                }
                column(UnitofMeasure_PurchaseLine; "Unit of Measure")
                {
                }
                column(VAT_PurchaseLine; "VAT %")
                {
                }

                column(TotalAmountExclVAT; TotalAmountExclVAT) { }
                column(TotalAmountInclVAT; TotalAmountInclVAT) { }
                column(TotalAmountVAT; VATAmountTotal) { }
                column(Date; Format(DocumentDate, 0, '<Day,2> <Month> <Year4>')) { }


            }
            trigger OnAfterGetRecord()
            begin
                FormatAddressFields("Purchase Header");
                CalcAmounts();
                DocumentDate := WorkDate();
            end;
        }



        dataitem("Company Information"; "Company Information")
        {




            column(Picture_CompanyInformation; Picture) { }


            column(Address_CompanyInformation; Address)
            {

            }
            column(Address2_CompanyInformation; "Address 2")
            {
            }
            column(BankAccountNo_CompanyInformation; "Bank Account No.")
            {
            }
            column(City_CompanyInformation; City)
            {
            }
            column(GiroNo_CompanyInformation; "Giro No.")
            {
            }
            column(Name_CompanyInformation; Name)
            {
            }
            column(PostCode_CompanyInformation; "Post Code")
            {
            }
            column(VATRegistrationNo_CompanyInformation; "VAT Registration No.")
            {
            }


            dataitem("Country/Region"; "Country/Region")
            {

                DataItemLink = Code = field("Country/Region Code");

                column(CompanyCountryName; Name) { }
            }

        }


    }





    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Options")
                {
                    field("Company Name"; "Company Information".Name)
                    {
                        ApplicationArea = All;
                    }
                    field(DocumentDate; DocumentDate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    var
        CompanyAddr: array[8] of Text[100];
        BuyFromAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];

        DocumentTitleLabel: Label 'Purchase Order';
        DocumentDate: Date;
        VATNoLabel: Label 'VAT No.';
        ShipToAddressLabel: Label 'Ship-to Address';
        PageLabel: Label 'Page';
        PaymentTermsDescLabel: Label 'Payment Terms';
        BuyerLabel: Label 'Buyer';
        ReceivedByLabel: Label 'Receive By';
        ShipmentMethodDescLabel: Label 'Shipment Method';
        PricesIncVAT_PurchaseHeaderLabel: Label 'Prices Including VAT';
        CompanyVATRegistrationLabel: Label 'Vat Registration No.';
        CompanyGiroNoLabel: Label 'Giro No.';
        VendorInvoiceNoLabel: Label 'Vendor Invoice No.';
        VendorOrderNoLabel: Label 'Vendor Order No.';
        NoPurchaseLineLabel: Label 'No.';
        DescPurchaseLineLabel: Label 'Description';
        QtyPruchaseLineLabel: Label 'Quantity';
        UOMPurchaseLineLabel: Label 'Unit';
        DirectUniCostLabel: Label 'Direct Unit Cost';
        VATAmtLineLabel: Label 'VAT %';
        ItemLineAmountLabel: Label 'Line Account';

        TotalAmountInclVATLabel: Label 'Total GBP Incl. VAT';
        TotalAmountExclVATLabel: Label 'Total GBP Excl. VAT';
        TotalAmountVATLabel: Label 'VAT Amount';
        /*CompanyHomePageLabel: Text;
        CompanyPhoneNoLabel: Text;
        CompanyEmailLabel: text;*/
        BuyFromAddr1: Text;
        BuyFromAddr2: Text;
        BuyFromAddr3: Text;
        BuyFromAddr4: Text;
        BuyFromAddr5: Text;
        ShipToAddr1: Text;
        ShipToAddr2: Text;
        ShipToAddr3: Text;
        ShipToAddr4: Text;
        ShipToAddr5: Text;
        CompanyAddress1: Text;
        CompanyAddress2: Text;
        CompanyAddress3: Text;
        CompanyAddress4: Text;
        CompanyAddress5: Text;

        VATAmountTotal: Decimal;
        TotalAmountExclVAT: Decimal;
        TotalAmountInclVAT: Decimal;


    protected var
        ShipmentMethod: Record "Shipment Method";
        FormatAddr: Codeunit "Format Address";
        ResponsibilityCenter: Record "Responsibility Center";
        CompanyInfo: Record "Company Information";
    //FormattedLineAmount: Text;

    trigger OnPreReport()
    begin



    end;

    local procedure CalcAmounts()
    var
        GREGVATAmountPerLine: Decimal;
    begin
        GREGVATAmountPerLine := 0;
        VATAmountTotal := 0;
        TotalAmountExclVAT := 0;
        TotalAmountInclVAT := 0;

        "Purchase Line".SetFilter("Document No.", "Purchase Header"."No.");

        if "Purchase Line".FindSet() then
            repeat
                if "Purchase Line"."VAT %" <> 0 then begin
                    GREGVATAmountPerLine := CalcVatPerLine("Purchase Line");
                    VATAmountTotal += GREGVATAmountPerLine;
                    //GREGTotalAmountInclVAT += GREGVATAmountPerLine;
                end;
                TotalAmountExclVAT += "Purchase Line"."Line Amount";
            until "Purchase Line".Next() = 0;
        TotalAmountInclVAT += VATAmountTotal;
        TotalAmountInclVAT += TotalAmountExclVAT;
    end;

    /*local procedure CalcAmountExclVAT(): Decimal
    begin

    end;*/

    /*local procedure CalcVATTotal(): Decimal
    begin

    end;*/

    local procedure CalcVatPerLine(PurchaseLine: Record "Purchase Line"): Decimal
    var
        VATAmountPerLine: Decimal;
    begin
        if "Purchase Line"."VAT %" = 0 then
            exit(0);

        VATAmountPerLine := "Purchase Line"."Line Amount" / 100 * "Purchase Line"."VAT %";
        exit(VATAmountPerLine);
    end;


    local procedure FormatAddressFields(var PurchaseHeader: Record "Purchase Header")
    var

    begin
        CompanyInfo.SetFilter(Name, CompanyName);
        CompanyInfo.FindFirst();
        //FormatAddr.GetCompanyAddr(PurchaseHeader."Responsibility Center", ResponsibilityCenter, CompanyInfo, CompanyAddr);
        FormatAddr.Company(CompanyAddr, CompanyInfo);
        FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, PurchaseHeader);
        FormatAddr.PurchHeaderShipTo(ShipToAddr, PurchaseHeader);
    end;


}