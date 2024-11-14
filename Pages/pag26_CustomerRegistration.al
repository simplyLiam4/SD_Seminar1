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
                field("Name"; Rec."Name")
                {
                    Caption = 'Name';
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Email"; Rec."Email")
                {
                    Caption = 'Email';
                    ApplicationArea = All;
                    Editable = true;
                }
                field("DateofRegistration"; Rec."DateofRegistration")
                {
                    Caption = 'Date of Registration';
                    ApplicationArea = All;
                    Editable = true;

                }
                field("CustomerNo."; Rec."CustomerNo.")
                {
                    Caption = 'CustomerNo.';
                    ApplicationArea = All;

                }
                field("SeminarName"; Rec."SeminarName")
                {
                    Caption = 'Seminar Name';
                    ApplicationArea = All;
                }
                field("SeminarStartingDate"; Rec."SeminarStartingDate")
                {
                    Caption = 'Seminar Starting Date';
                    ApplicationArea = All;
                }
                field("Status"; Rec.Status)
                {
                    Caption = 'Status';
                    ApplicationArea = All;
                }
            }
            group(Payment)
            {

                field("Seminar Selection"; Rec."Seminar Registration ")
                {
                    Caption = 'Select Seminar';
                    ApplicationArea = All;

                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount to Pay';
                    ApplicationArea = All;
                    Editable = false;
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


            }
            action(SendEmail)
            {
                Caption = 'send an email';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    Email: Codeunit Email;
                    EmailMessage: Codeunit "Email Message";
                    body: label '%1 have sent an email';

                begin
                    EmailMessage.Create(rec.Email, rec.Name + ' Email Sent', '', true);
                    EmailMessage.AppendToBody(StrSubstNo(body, UserId));
                    Email.Send(EmailMessage);


                end;
            }
        }
    }


}
