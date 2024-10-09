page 50101 "CSD Seminar Card"

{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CSD Seminar";
    Caption = 'Seminar';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    trigger OnAssistEdit()
                    begin
                        // if AssistEdit() then
                        //     CurrPage.Update();

                    end;
                }
                field("Name"; rec."Name")
                {

                }

                field("Search Name"; rec."Search Name")
                {

                }

                field("Seminar Duration"; rec."Seminar Duration")
                {

                }

                field("Minimum Participants"; rec."Minimum Participants")
                {

                }

                field("Maximum Participants"; rec."Maximum Participants")
                {

                }

                field(Blocked; rec.Blocked)
                {

                }

                field("Last Date Modified"; rec."Last Date Modified")
                {

                }



            }




            group(Invoicing)
            {
                field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group ")
                {

                }

                field("VAT Prod. Posting Group"; rec."VAT Prod. Posting Group")
                {

                }

                field("Seminar Price"; rec."Seminar Price")
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