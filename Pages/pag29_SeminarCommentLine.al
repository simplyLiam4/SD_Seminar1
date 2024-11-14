page 50129 "CSD Seminar comment Line"
{
    Caption = 'Seminar comment sheet';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CSD COMMENT LINE";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Date; Rec.Date)
                {
                }
                field(Code; Rec.Code)
                {
                    Visible = false;
                }
                field(Comment; Rec.Comment)
                {
                }
            }
        }

    }
    trigger OnOpenPage()


    begin
        Rec.SetUpNewLine();
    end;
}