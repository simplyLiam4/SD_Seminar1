page 50106 "CSD Seminar Comment Sheet"

{
    Caption = 'Seminar Comment Sheet';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CSD Seminar Comment Line";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Date"; Rec.Date)
                {

                }

                field("Code"; Rec.Code)
                {
                    Visible = false;
                }

                field("Comment"; Rec.Comment)
                {

                }
            }


        }

    }

}