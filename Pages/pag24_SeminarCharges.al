page 50124 "CSD Seminar Charges"
{
    Caption = 'Seminar Charges';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CSD Seminar Charge";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; rec."No.")
                {

                }
                field("Description"; rec."Description")
                {

                }
                field("Unit Price"; rec."Unit Price")
                {

                }

                field("Total Price"; rec."Total Price")
                {

                }

                field("To Invoice"; rec."To Invoice")
                {

                }

                field("Bill-to Customer No."; rec."Bill-to Customer No.")
                {

                }

                field("Unit of Measure Code"; rec."Unit of Measure Code")
                {

                }

                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
                {

                }
                field("VAT Prod. Posting Group"; rec."VAT Prod. Posting Group")
                {

                }

                field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
                {

                }

                field("Registered"; rec.Registered)
                {

                }
            }
        }


    }

    actions
    {

    }
}