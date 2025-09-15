xmlport 50250 "XML ports"
{
    Caption = 'Export Contacts to XML';
    Direction = Export;
    Format = FixedText;
    TextEncoding = UTF8;
    UseRequestPage = false;
    // DefaultFieldsValidation = true;

    schema
    {
        textelement(Contracts)
        {
            //XmlName = 'Contracts';

            tableelement(Contact; Contact)
            {
                RequestFilterFields = "No.";
                //XmlName = 'Contacts';

                fieldattribute(No; Contact."No.")
                {
                }
                fieldattribute(ExternalID; Contact."External ID")
                {
                }
                fieldelement(Name; Contact.Name)
                {
                }
                fieldelement("E-Mail"; Contact."E-Mail")
                {
                }
                fieldelement(HomePage; Contact."Home Page")
                {
                }
                fieldelement(CompanyNo; Contact."Company No.")
                {
                }
                fieldelement(CompanyName; Contact."Company Name")
                {
                }
            }
        }
    }

    var
        myInt: Integer;
}