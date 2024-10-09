page 50100 "CSD Seminar Setup"

//CSD1.00 = 2018-01-01 - D. E. Veloper
//Cahpter 5 - Lab 2-3
{
    Caption = 'Seminar Setup';
    InsertAllowed = false;
    DeleteAllowed = false;
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CSD Seminar Setup";

    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                field("Seminar Nos."; rec."Seminar Nos.")
                {

                }

                field("Seminar Registration Nos."; rec."Seminar Registration Nos")
                {

                }

                field("Posted Seminar Reg. Nos"; rec."Posted Seminar Reg. Nos.")
                {

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

    trigger OnOpenPage();

    begin
        if not rec.get then begin
            rec.init;

            rec.insert;
        end;

    end;
}