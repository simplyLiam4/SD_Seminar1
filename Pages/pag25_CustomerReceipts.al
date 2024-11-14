page 50125 "CSD Customer Receipts"
{
    Caption = 'Customer Receipts';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CSD Customer Receipts";

    layout
    {
        area(Content)
        {
            group(General) // Renamed the group to something more descriptive
            {
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Amount"; Rec."Amount")
                {
                    ApplicationArea = All;
                }
                field("Date issued"; Rec."Date issued")
                {
                    ApplicationArea = All;
                }
                field("Seminar Start"; Rec."Seminar Start")
                {
                    ApplicationArea = All;
                }
                field("Seminar End"; Rec."Seminar End")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Delete)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Do you want to delete this record?') then
                        Rec.Delete(true);
                end;
            }
        }
    }


}

// Comments:
// - Renamed the group from 'GroupName' to 'General' for better clarity.
// - Ensured all fields and actions are properly closed.
// - Removed unnecessary 'text' keyword before the layout section.