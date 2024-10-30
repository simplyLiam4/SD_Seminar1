page 50127 "CSD Customer Login"
{
    Caption = 'Customer Login';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Username"; Username)
                {
                    ApplicationArea = All;
                }
                field("Password"; Password)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = Masked;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Login)
            {
                ApplicationArea = All;
                Caption = 'Login';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    // Validate login credentials
                    if (Username = '') or (Password = '') then
                        Error('Username and Password are required.');
                    if not ValidateLogin(Username, Password) then
                        Error('Invalid username or password.');
                    // Redirect to main page or other relevant page
                    Page.Run(Page::"CSD SeminarRoleCenter");
                end;
            }
        }
    }

    local procedure ValidateLogin(Username: Text; Password: Text): Boolean
    var
        Customer: Record "CSD Registered Customers";
    begin
        if Customer.Get(Username) then
            if Customer."Password" = Password then
                exit(true);
        exit(false);
    end;

    var
        Username: Text;
        Password: Text;
}
