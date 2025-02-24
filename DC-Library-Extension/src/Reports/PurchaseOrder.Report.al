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
            column(ShipmentMethodDesc; ShipmentMethod.Description)
            {
            }
            column(ARcdNotInvExVATLCY_PurchaseHeader; "A. Rcd. Not Inv. Ex. VAT (LCY)")
            {
            }
            column(Amount_PurchaseHeader; Amount)
            {
            }
            column(AmountIncludingVAT_PurchaseHeader; "Amount Including VAT")
            {
            }
            column(AmtRcdNotInvoicedLCY_PurchaseHeader; "Amt. Rcd. Not Invoiced (LCY)")
            {
            }
            column(AppliestoDocNo_PurchaseHeader; "Applies-to Doc. No.")
            {
            }
            column(AppliestoDocType_PurchaseHeader; "Applies-to Doc. Type")
            {
            }
            column(AppliestoID_PurchaseHeader; "Applies-to ID")
            {
            }
            column(Area_PurchaseHeader; "Area")
            {
            }
            column(AssignedUserID_PurchaseHeader; "Assigned User ID")
            {
            }
            column(BalAccountNo_PurchaseHeader; "Bal. Account No.")
            {
            }
            column(BalAccountType_PurchaseHeader; "Bal. Account Type")
            {
            }
            column(BuyfromAddress_PurchaseHeader; "Buy-from Address")
            {
            }
            column(BuyfromAddress2_PurchaseHeader; "Buy-from Address 2")
            {
            }
            column(BuyfromCity_PurchaseHeader; "Buy-from City")
            {
            }
            column(BuyfromContact_PurchaseHeader; "Buy-from Contact")
            {
            }
            column(BuyfromContactNo_PurchaseHeader; "Buy-from Contact No.")
            {
            }
            column(BuyfromCountryRegionCode_PurchaseHeader; "Buy-from Country/Region Code")
            {
            }
            column(BuyfromCounty_PurchaseHeader; "Buy-from County")
            {
            }
            column(BuyfromICPartnerCode_PurchaseHeader; "Buy-from IC Partner Code")
            {
            }
            column(BuyfromPostCode_PurchaseHeader; "Buy-from Post Code")
            {
            }
            column(BuyfromVendorName_PurchaseHeader; "Buy-from Vendor Name")
            {
            }
            column(BuyfromVendorName2_PurchaseHeader; "Buy-from Vendor Name 2")
            {
            }
            column(BuyfromVendorNo_PurchaseHeader; "Buy-from Vendor No.")
            {
            }
            column(CampaignNo_PurchaseHeader; "Campaign No.")
            {
            }
            column(Comment_PurchaseHeader; Comment)
            {
            }
            column(CompletelyReceived_PurchaseHeader; "Completely Received")
            {
            }
            column(CompressPrepayment_PurchaseHeader; "Compress Prepayment")
            {
            }
            column(Correction_PurchaseHeader; Correction)
            {
            }
            column(CreditorNo_PurchaseHeader; "Creditor No.")
            {
            }
            column(CurrencyCode_PurchaseHeader; "Currency Code")
            {
            }
            column(CurrencyFactor_PurchaseHeader; "Currency Factor")
            {
            }
            column(DimensionSetID_PurchaseHeader; "Dimension Set ID")
            {
            }
            column(DocNoOccurrence_PurchaseHeader; "Doc. No. Occurrence")
            {
            }
            column(DocumentDate_PurchaseHeader; Format("Document Date", 0, '<day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DocumentType_PurchaseHeader; "Document Type")
            {
            }
            column(DueDate_PurchaseHeader; "Due Date")
            {
            }
            column(EntryPoint_PurchaseHeader; "Entry Point")
            {
            }
            column(ExpectedReceiptDate_PurchaseHeader; Format("Expected Receipt Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(FormatRegion_PurchaseHeader; "Format Region")
            {
            }
            column(GenBusPostingGroup_PurchaseHeader; "Gen. Bus. Posting Group")
            {
            }
            column(ICDirection_PurchaseHeader; "IC Direction")
            {
            }
            column(ICReferenceDocumentNo_PurchaseHeader; "IC Reference Document No.")
            {
            }
            column(ICStatus_PurchaseHeader; "IC Status")
            {
            }
            column(InboundWhseHandlingTime_PurchaseHeader; "Inbound Whse. Handling Time")
            {
            }
            column(IncomingDocumentEntryNo_PurchaseHeader; "Incoming Document Entry No.")
            {
            }
            column(Invoice_PurchaseHeader; Invoice)
            {
            }
            column(InvoiceDiscCode_PurchaseHeader; "Invoice Disc. Code")
            {
            }
            column(InvoiceDiscountAmount_PurchaseHeader; "Invoice Discount Amount")
            {
            }
            column(InvoiceDiscountCalculation_PurchaseHeader; "Invoice Discount Calculation")
            {
            }
            column(InvoiceDiscountValue_PurchaseHeader; "Invoice Discount Value")
            {
            }
            column(InvoiceReceivedDate_PurchaseHeader; "Invoice Received Date")
            {
            }
            column(JobQueueEntryID_PurchaseHeader; "Job Queue Entry ID")
            {
            }
            column(JobQueueStatus_PurchaseHeader; "Job Queue Status")
            {
            }
            column(JournalTemplName_PurchaseHeader; "Journal Templ. Name")
            {
            }
            column(LanguageCode_PurchaseHeader; "Language Code")
            {
            }
            column(LastPostingNo_PurchaseHeader; "Last Posting No.")
            {
            }
            column(LastPrepaymentNo_PurchaseHeader; "Last Prepayment No.")
            {
            }
            column(LastPrepmtCrMemoNo_PurchaseHeader; "Last Prepmt. Cr. Memo No.")
            {
            }
            column(LastReceivingNo_PurchaseHeader; "Last Receiving No.")
            {
            }
            column(LastReturnShipmentNo_PurchaseHeader; "Last Return Shipment No.")
            {
            }
            column(LeadTimeCalculation_PurchaseHeader; "Lead Time Calculation")
            {
            }
            column(LocationCode_PurchaseHeader; "Location Code")
            {
            }
            column(No_PurchaseHeader; "No.")
            {
            }
            column(NoofArchivedVersions_PurchaseHeader; "No. of Archived Versions")
            {
            }
            column(NoPrinted_PurchaseHeader; "No. Printed")
            {
            }
            column(NoSeries_PurchaseHeader; "No. Series")
            {
            }
            column(OnHold_PurchaseHeader; "On Hold")
            {
            }
            column(OrderAddressCode_PurchaseHeader; "Order Address Code")
            {
            }
            column(OrderClass_PurchaseHeader; "Order Class")
            {
            }
            column(OrderDate_PurchaseHeader; "Order Date")
            {
            }
            column(PartiallyInvoiced_PurchaseHeader; "Partially Invoiced")
            {
            }
            column(PaytoAddress_PurchaseHeader; "Pay-to Address")
            {
            }
            column(PaytoAddress2_PurchaseHeader; "Pay-to Address 2")
            {
            }
            column(PaytoCity_PurchaseHeader; "Pay-to City")
            {
            }
            column(PaytoContact_PurchaseHeader; "Pay-to Contact")
            {
            }
            column(PaytoContactNo_PurchaseHeader; "Pay-to Contact No.")
            {
            }
            column(PaytoCountryRegionCode_PurchaseHeader; "Pay-to Country/Region Code")
            {
            }
            column(PaytoCounty_PurchaseHeader; "Pay-to County")
            {
            }
            column(PaytoICPartnerCode_PurchaseHeader; "Pay-to IC Partner Code")
            {
            }
            column(PaytoName_PurchaseHeader; "Pay-to Name")
            {
            }
            column(PaytoName2_PurchaseHeader; "Pay-to Name 2")
            {
            }
            column(PaytoPostCode_PurchaseHeader; "Pay-to Post Code")
            {
            }
            column(PaytoVendorNo_PurchaseHeader; "Pay-to Vendor No.")
            {
            }
            column(PaymentDiscount_PurchaseHeader; "Payment Discount %")
            {
            }
            column(PaymentMethodCode_PurchaseHeader; "Payment Method Code")
            {
            }
            column(PaymentReference_PurchaseHeader; "Payment Reference")
            {
            }
            column(PaymentTermsCode_PurchaseHeader; "Payment Terms Code")
            {
            }
            column(PendingApprovals_PurchaseHeader; "Pending Approvals")
            {
            }
            column(PmtDiscountDate_PurchaseHeader; "Pmt. Discount Date")
            {
            }
            column(PostingDate_PurchaseHeader; "Posting Date")
            {
            }
            column(PostingDescription_PurchaseHeader; "Posting Description")
            {
            }
            column(PostingfromWhseRef_PurchaseHeader; "Posting from Whse. Ref.")
            {
            }
            column(PostingNo_PurchaseHeader; "Posting No.")
            {
            }
            column(PostingNoSeries_PurchaseHeader; "Posting No. Series")
            {
            }
            column(Prepayment_PurchaseHeader; "Prepayment %")
            {
            }
            column(PrepaymentDueDate_PurchaseHeader; "Prepayment Due Date")
            {
            }
            column(PrepaymentNo_PurchaseHeader; "Prepayment No.")
            {
            }
            column(PrepaymentNoSeries_PurchaseHeader; "Prepayment No. Series")
            {
            }
            column(PrepmtCrMemoNo_PurchaseHeader; "Prepmt. Cr. Memo No.")
            {
            }
            column(PrepmtCrMemoNoSeries_PurchaseHeader; "Prepmt. Cr. Memo No. Series")
            {
            }
            column(PrepmtPaymentDiscount_PurchaseHeader; "Prepmt. Payment Discount %")
            {
            }
            column(PrepmtPaymentTermsCode_PurchaseHeader; "Prepmt. Payment Terms Code")
            {
            }
            column(PrepmtPmtDiscountDate_PurchaseHeader; "Prepmt. Pmt. Discount Date")
            {
            }
            column(PrepmtPostingDescription_PurchaseHeader; "Prepmt. Posting Description")
            {
            }
            column(PriceCalculationMethod_PurchaseHeader; "Price Calculation Method")
            {
            }
            column(PricesIncludingVAT_PurchaseHeader; "Prices Including VAT")
            {
            }
            column(PrintPostedDocuments_PurchaseHeader; "Print Posted Documents")
            {
            }
            column(PromisedReceiptDate_PurchaseHeader; "Promised Receipt Date")
            {
            }
            column(PurchaserCode_PurchaseHeader; "Purchaser Code")
            {
            }
            column(QuoteNo_PurchaseHeader; "Quote No.")
            {
            }
            column(ReasonCode_PurchaseHeader; "Reason Code")
            {
            }
            column(RecalculateInvoiceDisc_PurchaseHeader; "Recalculate Invoice Disc.")
            {
            }
            column(Receive_PurchaseHeader; Receive)
            {
            }
            column(ReceivedNotInvoiced_PurchaseHeader; "Received Not Invoiced")
            {
            }
            column(ReceivingNo_PurchaseHeader; "Receiving No.")
            {
            }
            column(ReceivingNoSeries_PurchaseHeader; "Receiving No. Series")
            {
            }
            column(RemittoCode_PurchaseHeader; "Remit-to Code")
            {
            }
            column(RequestedReceiptDate_PurchaseHeader; "Requested Receipt Date")
            {
            }
            column(ResponsibilityCenter_PurchaseHeader; "Responsibility Center")
            {
            }
            column(ReturnShipmentNo_PurchaseHeader; "Return Shipment No.")
            {
            }
            column(ReturnShipmentNoSeries_PurchaseHeader; "Return Shipment No. Series")
            {
            }
            column(SelltoCustomerNo_PurchaseHeader; "Sell-to Customer No.")
            {
            }
            column(SendICDocument_PurchaseHeader; "Send IC Document")
            {
            }
            column(Ship_PurchaseHeader; Ship)
            {
            }
            column(ShiptoAddress_PurchaseHeader; "Ship-to Address")
            {
            }
            column(ShiptoAddress2_PurchaseHeader; "Ship-to Address 2")
            {
            }
            column(ShiptoCity_PurchaseHeader; "Ship-to City")
            {
            }
            column(ShiptoCode_PurchaseHeader; "Ship-to Code")
            {
            }
            column(ShiptoContact_PurchaseHeader; "Ship-to Contact")
            {
            }
            column(ShiptoCountryRegionCode_PurchaseHeader; "Ship-to Country/Region Code")
            {
            }
            column(ShiptoCounty_PurchaseHeader; "Ship-to County")
            {
            }
            column(ShiptoName_PurchaseHeader; "Ship-to Name")
            {
            }
            column(ShiptoName2_PurchaseHeader; "Ship-to Name 2")
            {
            }
            column(ShiptoPhoneNo_PurchaseHeader; "Ship-to Phone No.")
            {
            }
            column(ShiptoPostCode_PurchaseHeader; "Ship-to Post Code")
            {
            }
            column(ShipmentMethodCode_PurchaseHeader; "Shipment Method Code")
            {
            }
            column(ShortcutDimension1Code_PurchaseHeader; "Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code_PurchaseHeader; "Shortcut Dimension 2 Code")
            {
            }
            column(Status_PurchaseHeader; Status)
            {
            }
            column(SystemCreatedAt_PurchaseHeader; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy_PurchaseHeader; SystemCreatedBy)
            {
            }
            column(SystemId_PurchaseHeader; SystemId)
            {
            }
            column(SystemModifiedAt_PurchaseHeader; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy_PurchaseHeader; SystemModifiedBy)
            {
            }
            column(TaxAreaCode_PurchaseHeader; "Tax Area Code")
            {
            }
            column(TaxLiable_PurchaseHeader; "Tax Liable")
            {
            }
            column(TransactionSpecification_PurchaseHeader; "Transaction Specification")
            {
            }
            column(TransactionType_PurchaseHeader; "Transaction Type")
            {
            }
            column(TransportMethod_PurchaseHeader; "Transport Method")
            {
            }
            column(VATBaseDiscount_PurchaseHeader; "VAT Base Discount %")
            {
            }
            column(VATBusPostingGroup_PurchaseHeader; "VAT Bus. Posting Group")
            {
            }
            column(VATCountryRegionCode_PurchaseHeader; "VAT Country/Region Code")
            {
            }
            column(VATRegistrationNo_PurchaseHeader; "VAT Registration No.")
            {
            }
            column(VATReportingDate_PurchaseHeader; "VAT Reporting Date")
            {
            }
            column(VendorAuthorizationNo_PurchaseHeader; "Vendor Authorization No.")
            {
            }
            column(VendorCrMemoNo_PurchaseHeader; "Vendor Cr. Memo No.")
            {
            }
            column(VendorInvoiceNo_PurchaseHeader; "Vendor Invoice No.")
            {
            }
            column(VendorOrderNo_PurchaseHeader; "Vendor Order No.")
            {
            }
            column(VendorPostingGroup_PurchaseHeader; "Vendor Posting Group")
            {
            }
            column(VendorShipmentNo_PurchaseHeader; "Vendor Shipment No.")
            {
            }
            column(YourReference_PurchaseHeader; "Your Reference")
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

                column(ARcdNotInvExVATLCY_PurchaseLine; "A. Rcd. Not Inv. Ex. VAT (LCY)")
                {
                }
                column(AllocAccModifiedbyUser_PurchaseLine; "Alloc. Acc. Modified by User")
                {
                }
                column(AllocationAccountNo_PurchaseLine; "Allocation Account No.")
                {
                }
                column(AllowInvoiceDisc_PurchaseLine; "Allow Invoice Disc.")
                {
                }
                column(AllowItemChargeAssignment_PurchaseLine; "Allow Item Charge Assignment")
                {
                }
                column(Amount_PurchaseLine; Amount)
                {
                }
                column(AmountIncludingVAT_PurchaseLine; "Amount Including VAT")
                {
                }
                column(AmtRcdNotInvoiced_PurchaseLine; "Amt. Rcd. Not Invoiced")
                {
                }
                column(AmtRcdNotInvoicedLCY_PurchaseLine; "Amt. Rcd. Not Invoiced (LCY)")
                {
                }
                column(AppltoItemEntry_PurchaseLine; "Appl.-to Item Entry")
                {
                }
                column(Area_PurchaseLine; "Area")
                {
                }
                column(AttachedDocCount_PurchaseLine; "Attached Doc Count")
                {
                }
                column(AttachedLinesCount_PurchaseLine; "Attached Lines Count")
                {
                }
                column(AttachedtoLineNo_PurchaseLine; "Attached to Line No.")
                {
                }
                column(BinCode_PurchaseLine; "Bin Code")
                {
                }
                column(BlanketOrderLineNo_PurchaseLine; "Blanket Order Line No.")
                {
                }
                column(BlanketOrderNo_PurchaseLine; "Blanket Order No.")
                {
                }
                column(BudgetedFANo_PurchaseLine; "Budgeted FA No.")
                {
                }
                column(BuyfromVendorNo_PurchaseLine; "Buy-from Vendor No.")
                {
                }
                column(CompletelyReceived_PurchaseLine; "Completely Received")
                {
                }
                column(CopiedFromPostedDoc_PurchaseLine; "Copied From Posted Doc.")
                {
                }
                column(CurrencyCode_PurchaseLine; "Currency Code")
                {
                }
                column(DeferralCode_PurchaseLine; "Deferral Code")
                {
                }
                column(DeprAcquisitionCost_PurchaseLine; "Depr. Acquisition Cost")
                {
                }
                column(DepruntilFAPostingDate_PurchaseLine; "Depr. until FA Posting Date")
                {
                }
                column(DepreciationBookCode_PurchaseLine; "Depreciation Book Code")
                {
                }
                column(Description_PurchaseLine; Description)
                {
                }
                column(Description2_PurchaseLine; "Description 2")
                {
                }
                column(DimensionSetID_PurchaseLine; "Dimension Set ID")
                {
                }
                column(DirectUnitCost_PurchaseLine; "Direct Unit Cost")
                {
                }
                column(DocumentNo_PurchaseLine; "Document No.")
                {
                }
                column(DocumentType_PurchaseLine; "Document Type")
                {
                }
                column(DropShipment_PurchaseLine; "Drop Shipment")
                {
                }
                column(DuplicateinDepreciationBook_PurchaseLine; "Duplicate in Depreciation Book")
                {
                }
                column(EntryPoint_PurchaseLine; "Entry Point")
                {
                }
                column(ExpectedReceiptDate_PurchaseLine; "Expected Receipt Date")
                {
                }
                column(FAPostingDate_PurchaseLine; "FA Posting Date")
                {
                }
                column(FAPostingType_PurchaseLine; "FA Posting Type")
                {
                }
                column(Finished_PurchaseLine; Finished)
                {
                }
                column(GenBusPostingGroup_PurchaseLine; "Gen. Bus. Posting Group")
                {
                }
                column(GenProdPostingGroup_PurchaseLine; "Gen. Prod. Posting Group")
                {
                }
                column(GrossWeight_PurchaseLine; "Gross Weight")
                {
                }
                column(ICItemReferenceNo_PurchaseLine; "IC Item Reference No.")
                {
                }
                column(ICPartnerCode_PurchaseLine; "IC Partner Code")
                {
                }
                column(ICPartnerRefType_PurchaseLine; "IC Partner Ref. Type")
                {
                }
                column(ICPartnerReference_PurchaseLine; "IC Partner Reference")
                {
                }
                column(InboundWhseHandlingTime_PurchaseLine; "Inbound Whse. Handling Time")
                {
                }
                column(IndirectCost_PurchaseLine; "Indirect Cost %")
                {
                }
                column(InsuranceNo_PurchaseLine; "Insurance No.")
                {
                }
                column(InvDiscAmounttoInvoice_PurchaseLine; "Inv. Disc. Amount to Invoice")
                {
                }
                column(InvDiscountAmount_PurchaseLine; "Inv. Discount Amount")
                {
                }
                column(ItemCategoryCode_PurchaseLine; "Item Category Code")
                {
                }
                column(ItemChargeQtytoHandle_PurchaseLine; "Item Charge Qty. to Handle")
                {
                }
                column(ItemReferenceNo_PurchaseLine; "Item Reference No.")
                {
                }
                column(ItemReferenceType_PurchaseLine; "Item Reference Type")
                {
                }
                column(ItemReferenceTypeNo_PurchaseLine; "Item Reference Type No.")
                {
                }
                column(ItemReferenceUnitofMeasure_PurchaseLine; "Item Reference Unit of Measure")
                {
                }
                column(JobCurrencyCode_PurchaseLine; "Job Currency Code")
                {
                }
                column(JobCurrencyFactor_PurchaseLine; "Job Currency Factor")
                {
                }
                column(JobLineAmount_PurchaseLine; "Job Line Amount")
                {
                }
                column(JobLineAmountLCY_PurchaseLine; "Job Line Amount (LCY)")
                {
                }
                column(JobLineDiscAmountLCY_PurchaseLine; "Job Line Disc. Amount (LCY)")
                {
                }
                column(JobLineDiscount_PurchaseLine; "Job Line Discount %")
                {
                }
                column(JobLineDiscountAmount_PurchaseLine; "Job Line Discount Amount")
                {
                }
                column(JobLineType_PurchaseLine; "Job Line Type")
                {
                }
                column(JobNo_PurchaseLine; "Job No.")
                {
                }
                column(JobPlanningLineNo_PurchaseLine; "Job Planning Line No.")
                {
                }
                column(JobRemainingQty_PurchaseLine; "Job Remaining Qty.")
                {
                }
                column(JobRemainingQtyBase_PurchaseLine; "Job Remaining Qty. (Base)")
                {
                }
                column(JobTaskNo_PurchaseLine; "Job Task No.")
                {
                }
                column(JobTotalPrice_PurchaseLine; "Job Total Price")
                {
                }
                column(JobTotalPriceLCY_PurchaseLine; "Job Total Price (LCY)")
                {
                }
                column(JobUnitPrice_PurchaseLine; "Job Unit Price")
                {
                }
                column(JobUnitPriceLCY_PurchaseLine; "Job Unit Price (LCY)")
                {
                }
                column(LeadTimeCalculation_PurchaseLine; "Lead Time Calculation")
                {
                }
                column(LineAmount_PurchaseLine; "Line Amount")
                {
                }
                column(LineDiscount_PurchaseLine; "Line Discount %")
                {
                }
                column(LineDiscountAmount_PurchaseLine; "Line Discount Amount")
                {
                }
                column(LineNo_PurchaseLine; "Line No.")
                {
                }
                column(LocationCode_PurchaseLine; "Location Code")
                {
                }
                column(MaintenanceCode_PurchaseLine; "Maintenance Code")
                {
                }
                column(MPSOrder_PurchaseLine; "MPS Order")
                {
                }
                column(NetWeight_PurchaseLine; "Net Weight")
                {
                }
                column(No_PurchaseLine; "No.")
                {
                }
                column(NonDeductibleVAT_PurchaseLine; "Non-Deductible VAT %")
                {
                }
                column(NonDeductibleVATAmount_PurchaseLine; "Non-Deductible VAT Amount")
                {
                }
                column(NonDeductibleVATBase_PurchaseLine; "Non-Deductible VAT Base")
                {
                }
                column(NonDeductibleVATDiff_PurchaseLine; "Non-Deductible VAT Diff.")
                {
                }
                column(Nonstock_PurchaseLine; Nonstock)
                {
                }
                column(OperationNo_PurchaseLine; "Operation No.")
                {
                }
                column(OrderDate_PurchaseLine; "Order Date")
                {
                }
                column(OrderLineNo_PurchaseLine; "Order Line No.")
                {
                }
                column(OrderNo_PurchaseLine; "Order No.")
                {
                }
                column(OutstandingAmount_PurchaseLine; "Outstanding Amount")
                {
                }
                column(OutstandingAmountLCY_PurchaseLine; "Outstanding Amount (LCY)")
                {
                }
                column(OutstandingAmtExVATLCY_PurchaseLine; "Outstanding Amt. Ex. VAT (LCY)")
                {
                }
                column(OutstandingQtyBase_PurchaseLine; "Outstanding Qty. (Base)")
                {
                }
                column(OutstandingQuantity_PurchaseLine; "Outstanding Quantity")
                {
                }
                column(OverReceiptApprovalStatus_PurchaseLine; "Over-Receipt Approval Status")
                {
                }
                column(OverReceiptCode_PurchaseLine; "Over-Receipt Code")
                {
                }
                column(OverReceiptQuantity_PurchaseLine; "Over-Receipt Quantity")
                {
                }
                column(OverheadRate_PurchaseLine; "Overhead Rate")
                {
                }
                column(PaytoVendorNo_PurchaseLine; "Pay-to Vendor No.")
                {
                }
                column(PlannedReceiptDate_PurchaseLine; "Planned Receipt Date")
                {
                }
                column(PlanningFlexibility_PurchaseLine; "Planning Flexibility")
                {
                }
                column(PmtDiscountAmount_PurchaseLine; "Pmt. Discount Amount")
                {
                }
                column(PostingGroup_PurchaseLine; "Posting Group")
                {
                }
                column(Prepayment_PurchaseLine; "Prepayment %")
                {
                }
                column(PrepaymentAmount_PurchaseLine; "Prepayment Amount")
                {
                }
                column(PrepaymentLine_PurchaseLine; "Prepayment Line")
                {
                }
                column(PrepaymentTaxAreaCode_PurchaseLine; "Prepayment Tax Area Code")
                {
                }
                column(PrepaymentTaxGroupCode_PurchaseLine; "Prepayment Tax Group Code")
                {
                }
                column(PrepaymentTaxLiable_PurchaseLine; "Prepayment Tax Liable")
                {
                }
                column(PrepaymentVAT_PurchaseLine; "Prepayment VAT %")
                {
                }
                column(PrepaymentVATDifference_PurchaseLine; "Prepayment VAT Difference")
                {
                }
                column(PrepaymentVATIdentifier_PurchaseLine; "Prepayment VAT Identifier")
                {
                }
                column(PrepmtAmtDeducted_PurchaseLine; "Prepmt Amt Deducted")
                {
                }
                column(PrepmtAmttoDeduct_PurchaseLine; "Prepmt Amt to Deduct")
                {
                }
                column(PrepmtVATDiffDeducted_PurchaseLine; "Prepmt VAT Diff. Deducted")
                {
                }
                column(PrepmtVATDifftoDeduct_PurchaseLine; "Prepmt VAT Diff. to Deduct")
                {
                }
                column(PrepmtAmountInvLCY_PurchaseLine; "Prepmt. Amount Inv. (LCY)")
                {
                }
                column(PrepmtAmountInvInclVAT_PurchaseLine; "Prepmt. Amount Inv. Incl. VAT")
                {
                }
                column(PrepmtAmtInclVAT_PurchaseLine; "Prepmt. Amt. Incl. VAT")
                {
                }
                column(PrepmtAmtInv_PurchaseLine; "Prepmt. Amt. Inv.")
                {
                }
                column(PrepmtLineAmount_PurchaseLine; "Prepmt. Line Amount")
                {
                }
                column(PrepmtNonDeductVATAmount_PurchaseLine; "Prepmt. Non-Deduct. VAT Amount")
                {
                }
                column(PrepmtNonDeductVATBase_PurchaseLine; "Prepmt. Non-Deduct. VAT Base")
                {
                }
                column(PrepmtPmtDiscountAmount_PurchaseLine; "Prepmt. Pmt. Discount Amount")
                {
                }
                column(PrepmtVATAmountInvLCY_PurchaseLine; "Prepmt. VAT Amount Inv. (LCY)")
                {
                }
                column(PrepmtVATBaseAmt_PurchaseLine; "Prepmt. VAT Base Amt.")
                {
                }
                column(PrepmtVATCalcType_PurchaseLine; "Prepmt. VAT Calc. Type")
                {
                }
                column(PriceCalculationMethod_PurchaseLine; "Price Calculation Method")
                {
                }
                column(ProdOrderLineNo_PurchaseLine; "Prod. Order Line No.")
                {
                }
                column(ProdOrderNo_PurchaseLine; "Prod. Order No.")
                {
                }
                column(Profit_PurchaseLine; "Profit %")
                {
                }
                column(PromisedReceiptDate_PurchaseLine; "Promised Receipt Date")
                {
                }
                column(PurchasingCode_PurchaseLine; "Purchasing Code")
                {
                }
                column(QtyAssigned_PurchaseLine; "Qty. Assigned")
                {
                }
                column(QtyInvoicedBase_PurchaseLine; "Qty. Invoiced (Base)")
                {
                }
                column(QtyperUnitofMeasure_PurchaseLine; "Qty. per Unit of Measure")
                {
                }
                column(QtyRcdNotInvoiced_PurchaseLine; "Qty. Rcd. Not Invoiced")
                {
                }
                column(QtyRcdNotInvoicedBase_PurchaseLine; "Qty. Rcd. Not Invoiced (Base)")
                {
                }
                column(QtyReceivedBase_PurchaseLine; "Qty. Received (Base)")
                {
                }
                column(QtyRoundingPrecision_PurchaseLine; "Qty. Rounding Precision")
                {
                }
                column(QtyRoundingPrecisionBase_PurchaseLine; "Qty. Rounding Precision (Base)")
                {
                }
                column(QtytoAssign_PurchaseLine; "Qty. to Assign")
                {
                }
                column(QtytoInvoice_PurchaseLine; "Qty. to Invoice")
                {
                }
                column(QtytoInvoiceBase_PurchaseLine; "Qty. to Invoice (Base)")
                {
                }
                column(QtytoReceive_PurchaseLine; "Qty. to Receive")
                {
                }
                column(QtytoReceiveBase_PurchaseLine; "Qty. to Receive (Base)")
                {
                }
                column(Quantity_PurchaseLine; Quantity)
                {
                }
                column(QuantityBase_PurchaseLine; "Quantity (Base)")
                {
                }
                column(QuantityInvoiced_PurchaseLine; "Quantity Invoiced")
                {
                }
                column(QuantityReceived_PurchaseLine; "Quantity Received")
                {
                }
                column(RecalculateInvoiceDisc_PurchaseLine; "Recalculate Invoice Disc.")
                {
                }
                column(ReceiptLineNo_PurchaseLine; "Receipt Line No.")
                {
                }
                column(ReceiptNo_PurchaseLine; "Receipt No.")
                {
                }
                column(RequestedReceiptDate_PurchaseLine; "Requested Receipt Date")
                {
                }
                column(ReservedQtyBase_PurchaseLine; "Reserved Qty. (Base)")
                {
                }
                column(ReservedQuantity_PurchaseLine; "Reserved Quantity")
                {
                }
                column(ResponsibilityCenter_PurchaseLine; "Responsibility Center")
                {
                }
                column(RetQtyShpdNotInvdBase_PurchaseLine; "Ret. Qty. Shpd Not Invd.(Base)")
                {
                }
                column(ReturnQtyShipped_PurchaseLine; "Return Qty. Shipped")
                {
                }
                column(ReturnQtyShippedBase_PurchaseLine; "Return Qty. Shipped (Base)")
                {
                }
                column(ReturnQtyShippedNotInvd_PurchaseLine; "Return Qty. Shipped Not Invd.")
                {
                }
                column(ReturnQtytoShip_PurchaseLine; "Return Qty. to Ship")
                {
                }
                column(ReturnQtytoShipBase_PurchaseLine; "Return Qty. to Ship (Base)")
                {
                }
                column(ReturnReasonCode_PurchaseLine; "Return Reason Code")
                {
                }
                column(ReturnShipmentLineNo_PurchaseLine; "Return Shipment Line No.")
                {
                }
                column(ReturnShipmentNo_PurchaseLine; "Return Shipment No.")
                {
                }
                column(ReturnShpdNotInvd_PurchaseLine; "Return Shpd. Not Invd.")
                {
                }
                column(ReturnShpdNotInvdLCY_PurchaseLine; "Return Shpd. Not Invd. (LCY)")
                {
                }
                column(ReturnsDeferralStartDate_PurchaseLine; "Returns Deferral Start Date")
                {
                }
                column(RoutingNo_PurchaseLine; "Routing No.")
                {
                }
                column(RoutingReferenceNo_PurchaseLine; "Routing Reference No.")
                {
                }
                column(SafetyLeadTime_PurchaseLine; "Safety Lead Time")
                {
                }
                column(SalesOrderLineNo_PurchaseLine; "Sales Order Line No.")
                {
                }
                column(SalesOrderNo_PurchaseLine; "Sales Order No.")
                {
                }
                column(SalvageValue_PurchaseLine; "Salvage Value")
                {
                }
                column(SelectedAllocAccountNo_PurchaseLine; "Selected Alloc. Account No.")
                {
                }
                column(ShortcutDimension1Code_PurchaseLine; "Shortcut Dimension 1 Code")
                {
                }
                column(ShortcutDimension2Code_PurchaseLine; "Shortcut Dimension 2 Code")
                {
                }
                column(SpecialOrder_PurchaseLine; "Special Order")
                {
                }
                column(SpecialOrderSalesLineNo_PurchaseLine; "Special Order Sales Line No.")
                {
                }
                column(SpecialOrderSalesNo_PurchaseLine; "Special Order Sales No.")
                {
                }
                column(Subtype_PurchaseLine; Subtype)
                {
                }
                column(SystemCreatedEntry_PurchaseLine; "System-Created Entry")
                {
                }
                column(SystemCreatedAt_PurchaseLine; SystemCreatedAt)
                {
                }
                column(SystemCreatedBy_PurchaseLine; SystemCreatedBy)
                {
                }
                column(SystemId_PurchaseLine; SystemId)
                {
                }
                column(SystemModifiedAt_PurchaseLine; SystemModifiedAt)
                {
                }
                column(SystemModifiedBy_PurchaseLine; SystemModifiedBy)
                {
                }
                column(TaxAreaCode_PurchaseLine; "Tax Area Code")
                {
                }
                column(TaxGroupCode_PurchaseLine; "Tax Group Code")
                {
                }
                column(TaxLiable_PurchaseLine; "Tax Liable")
                {
                }
                column(TransactionSpecification_PurchaseLine; "Transaction Specification")
                {
                }
                column(TransactionType_PurchaseLine; "Transaction Type")
                {
                }
                column(TransportMethod_PurchaseLine; "Transport Method")
                {
                }
                column(Type_PurchaseLine; "Type")
                {
                }
                column(UnitCost_PurchaseLine; "Unit Cost")
                {
                }
                column(UnitCostLCY_PurchaseLine; "Unit Cost (LCY)")
                {
                }
                column(UnitofMeasure_PurchaseLine; "Unit of Measure")
                {
                }
                column(UnitofMeasureCode_PurchaseLine; "Unit of Measure Code")
                {
                }
                column(UnitPriceLCY_PurchaseLine; "Unit Price (LCY)")
                {
                }
                column(UnitVolume_PurchaseLine; "Unit Volume")
                {
                }
                column(UnitsperParcel_PurchaseLine; "Units per Parcel")
                {
                }
                column(UseDuplicationList_PurchaseLine; "Use Duplication List")
                {
                }
                column(UseTax_PurchaseLine; "Use Tax")
                {
                }
                column(VariantCode_PurchaseLine; "Variant Code")
                {
                }
                column(VAT_PurchaseLine; "VAT %")
                {
                }
                column(VATBaseAmount_PurchaseLine; "VAT Base Amount")
                {
                }
                column(VATBusPostingGroup_PurchaseLine; "VAT Bus. Posting Group")
                {
                }
                column(VATCalculationType_PurchaseLine; "VAT Calculation Type")
                {
                }
                column(VATDifference_PurchaseLine; "VAT Difference")
                {
                }
                column(VATIdentifier_PurchaseLine; "VAT Identifier")
                {
                }
                column(VATProdPostingGroup_PurchaseLine; "VAT Prod. Posting Group")
                {
                }
                column(VendorItemNo_PurchaseLine; "Vendor Item No.")
                {
                }
                column(WhseOutstandingQtyBase_PurchaseLine; "Whse. Outstanding Qty. (Base)")
                {
                }
                column(WorkCenterNo_PurchaseLine; "Work Center No.")
                {
                }
                column(PurchLine_VATPct; "VAT %")
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



            column(Address_CompanyInformation; Address)
            {

            }
            column(Address2_CompanyInformation; "Address 2")
            {
            }
            column(AllowBlankPaymentInfo_CompanyInformation; "Allow Blank Payment Info.")
            {
            }
            column(AlternativeLanguageCode_CompanyInformation; "Alternative Language Code")
            {
            }
            column(BankAccountNo_CompanyInformation; "Bank Account No.")
            {
            }
            column(BankBranchNo_CompanyInformation; "Bank Branch No.")
            {
            }
            column(BankName_CompanyInformation; "Bank Name")
            {
            }
            column(BaseCalendarCode_CompanyInformation; "Base Calendar Code")
            {
            }
            column(BrandColorCode_CompanyInformation; "Brand Color Code")
            {
            }
            column(BrandColorValue_CompanyInformation; "Brand Color Value")
            {
            }
            column(CalConvergenceTimeFrame_CompanyInformation; "Cal. Convergence Time Frame")
            {
            }
            column(CheckAvailPeriodCalc_CompanyInformation; "Check-Avail. Period Calc.")
            {
            }
            column(CheckAvailTimeBucket_CompanyInformation; "Check-Avail. Time Bucket")
            {
            }
            column(City_CompanyInformation; City)
            {
            }
            column(ContactPerson_CompanyInformation; "Contact Person")
            {
            }
            column(CountryRegionCode_CompanyInformation; "Country/Region Code")
            {
            }
            column(County_CompanyInformation; County)
            {
            }
            column(CreatedDateTime_CompanyInformation; "Created DateTime")
            {
            }
            column(CustomSystemIndicatorText_CompanyInformation; "Custom System Indicator Text")
            {
            }
            column(CustomsPermitDate_CompanyInformation; "Customs Permit Date")
            {
            }
            column(CustomsPermitNo_CompanyInformation; "Customs Permit No.")
            {
            }
            column(DemoCompany_CompanyInformation; "Demo Company")
            {
            }
            column(EMail_CompanyInformation; "E-Mail")
            {
            }
            column(EORINumber_CompanyInformation; "EORI Number")
            {
            }
            column(FaxNo_CompanyInformation; "Fax No.")
            {
            }
            column(GiroNo_CompanyInformation; "Giro No.")
            {
            }
            column(GLN_CompanyInformation; GLN)
            {
            }
            column(IBAN_CompanyInformation; IBAN)
            {
            }
            column(IndustrialClassification_CompanyInformation; "Industrial Classification")
            {
            }
            column(LastModifiedDateTime_CompanyInformation; "Last Modified Date Time")
            {
            }
            column(LocationCode_CompanyInformation; "Location Code")
            {
            }
            column(Name_CompanyInformation; Name)
            {
            }
            column(Name2_CompanyInformation; "Name 2")
            {
            }
            column(PaymentRoutingNo_CompanyInformation; "Payment Routing No.")
            {
            }
            column(PhoneNo_CompanyInformation; "Phone No.")
            {
            }
            column(PhoneNo2_CompanyInformation; "Phone No. 2")
            {
            }
            column(Picture_CompanyInformation; Picture)
            {
            }
            column(PictureLastModDateTime_CompanyInformation; "Picture - Last Mod. Date Time")
            {
            }
            column(PostCode_CompanyInformation; "Post Code")
            {
            }
            column(PrimaryKey_CompanyInformation; "Primary Key")
            {
            }
            column(RegistrationNo_CompanyInformation; "Registration No.")
            {
            }
            column(ResponsibilityCenter_CompanyInformation; "Responsibility Center")
            {
            }
            column(ShiptoAddress_CompanyInformation; "Ship-to Address")
            {
            }
            column(ShiptoAddress2_CompanyInformation; "Ship-to Address 2")
            {
            }
            column(ShiptoCity_CompanyInformation; "Ship-to City")
            {
            }
            column(ShiptoContact_CompanyInformation; "Ship-to Contact")
            {
            }
            column(ShiptoCountryRegionCode_CompanyInformation; "Ship-to Country/Region Code")
            {
            }
            column(ShiptoCounty_CompanyInformation; "Ship-to County")
            {
            }
            column(ShiptoName_CompanyInformation; "Ship-to Name")
            {
            }
            column(ShiptoName2_CompanyInformation; "Ship-to Name 2")
            {
            }
            column(ShiptoPhoneNo_CompanyInformation; "Ship-to Phone No.")
            {
            }
            column(ShiptoPostCode_CompanyInformation; "Ship-to Post Code")
            {
            }
            column(SWIFTCode_CompanyInformation; "SWIFT Code")
            {
            }
            column(TelexAnswerBack_CompanyInformation; "Telex Answer Back")
            {
            }
            column(TelexNo_CompanyInformation; "Telex No.")
            {
            }
            column(UseGLNinElectronicDocument_CompanyInformation; "Use GLN in Electronic Document")
            {
            }
            column(VATRegistrationNo_CompanyInformation; "VAT Registration No.")
            {
            }
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