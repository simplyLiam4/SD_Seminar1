page 50102 "CSD Seminar List"

{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CSD Seminar";
    //Caption =
    Editable = false;
    CardPageId = 50101;
    //UsageCategory = Lists;



    layout
    {
        area(Content)
        {


            Repeater(Group)
            {

                field("No."; Rec."No.")
                {

                }

                field("Name"; Rec."Name")
                {

                }

                field("Seminar Duration"; Rec."Seminar Duration")
                {

                }

                field("Minimum Participants"; Rec."Minimum Participants")
                {

                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {

                }

            }
        }

        area(FactBoxes)
        {
            systempart("Links"; Links)
            {

            }
            systempart("Notes"; Notes)
            {

            }

        }


    }

    actions
    {
        area(Navigation)
        {
            group("&Seminar")
            {
                action("Co&mment")
                {

                    // RunObject=page "CSD Seminar Comment Sheet";
                    // RunPageLink = "Table Name" = const(seminar),
                    //             "No."=field("No.");

                    Image = Comment;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;



                }
            }
        }
    }


}