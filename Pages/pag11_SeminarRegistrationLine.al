page 50111 "CSD Seminar Registration Line"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CSD Seminar Registration Line";
    AutoSplitKey = true;//Automatically increments the primary key when a new record is inserted. It helps in managing unique keys for new records 

    layout
    {
        area(Content)
        {
            group(Group)
            {
                field("Bill-to Customer No."; rec."Bill-to Customer No.")
                {
                }
                field("Participant Contact No."; rec."Participant Contact No.")
                {
                }
                field("Participant Name"; rec."Participant Name")
                {
                }
                field(Participated; rec.Participated)
                {
                }
                field("Registration Date"; rec."Registration Date")
                {
                }
                field("Confirmation Date"; rec."Confirmation Date")
                {
                }
                field("To Invoice"; rec."To Invoice")
                {
                }
                field(Registered; rec."Registered")
                {
                }
                field("Seminar Price"; rec."Seminar Price")
                {
                }
                field("Line Discount %"; rec."Line Discount %")
                {
                }
                field("Line Discount Amount"; rec."Line Discount Amount")
                {
                }
                field(Amount; rec."Amount")
                {

                }
            }
        }
    }

    actions
    {

    }


}