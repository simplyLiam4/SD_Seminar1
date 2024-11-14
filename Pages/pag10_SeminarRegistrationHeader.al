page 50110 "CSD Seminar Registration"
{
    Caption = 'Seminar Registration';
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CSD Seminar Reg. Header";

    layout
    {
        area(Content)
        {
            group(General)
            {

                field("No."; rec."No.")
                {
                    AssistEdit = true;
                    trigger OnAssistEdit();
                    begin
                        if rec.AssistEdit(xRec) then
                            CurrPage.UPDATE;
                    end;

                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document Date field.', Comment = '%';
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Seminar No."; Rec."Seminar No.")
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
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}