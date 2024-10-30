page 50126 "CSD Customer Registration"
{
    Caption = 'Customer Registration';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CSD Registered Customers";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("UserName"; Rec."UserName")
                {
                    Caption = 'UserName';
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Password"; Rec."Password")
                {
                    Caption = 'Password';
                    ApplicationArea = All;
                    ExtendedDatatype = Masked;
                    Editable = true;
                }
                field("FirstName"; Rec."FirstName")
                {
                    Caption = 'FirstName';
                    ApplicationArea = All;
                    Editable = true;
                }
                field("LastName"; Rec."LastName")
                {
                    Caption = 'LastName';
                    ApplicationArea = All;
                    Editable = true;
                }
                // Other fields as needed
            }
            group(Payment)
            {
                field("Seminar 1 Paid"; Rec."Seminar 1 Paid")
                {
                    Caption = 'Seminar 1 Paid';
                    ApplicationArea = All;
                }
                field("Seminar 2 Paid"; Rec."Seminar 2 Paid")
                {
                    Caption = 'Seminar 2 Paid';
                    ApplicationArea = All;
                }
                field("Payment Method"; Rec."Payment Method")
                {
                    Caption = 'Payment Method';
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    Caption = 'Receipt No.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Submit)
            {
                ApplicationArea = All;
                Caption = 'Submit';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    // Validate and submit the registration
                    if (Rec."UserName" = '') or (Rec."Password" = '') then
                        Error('Username and Password are required.');

                    if Rec."Seminar 1 Paid" <= 0 then
                        Error('You must pay for Seminar 1 first.');

                    if Rec."Seminar 2 Paid" <= 0 then
                        Error('You must pay for Seminar 2 after Seminar 1.');

                    Rec.Insert(true);

                    // Generate a receipt number and insert into CSD Customer Receipts
                    CreateCustomerReceipt(Rec);

                    Message('Registration successful. You will be redirected to the login page.');

                    // Redirect to login page (ensure this page exists)
                    Page.Run(Page::"CSD Customer Login");
                end;
            }
        }
    }

    local procedure CreateCustomerReceipt(Customer: Record "CSD Registered Customers")
    var
        CustomerReceipt: Record "CSD Customer Receipts";
    begin
        CustomerReceipt.Init();
        CustomerReceipt."First Name" := Customer."FirstName";
        CustomerReceipt."Last Name" := Customer."LastName";
        CustomerReceipt."Amount" := 500; // Assuming 500 KSHS per seminar
        CustomerReceipt."Date issued" := Today; // Assuming the field is named "Receipt Date" instead of "Date"
        CustomerReceipt.Insert(true);
    end;
}
