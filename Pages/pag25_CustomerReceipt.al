page 50125 "CSD Customer Receipts"
{
    Caption = ' Customer Receipts';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CSD Customer Receipts";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                // field(Name; NameSource)
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
    
    var
        myInt: Integer;
}