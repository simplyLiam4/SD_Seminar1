table 50114 "CSD Registered Customers"
{
    Caption = 'Registered Customers';

    fields
    {
        field(1; "UserName"; Text[100])
        {
            Caption = 'Username';
            NotBlank = true;
            Editable = true;

        }
        field(2; "Password"; Text[20])
        {
            Caption = 'Password';
            NotBlank = true;
            Editable = true;

        }

        field(3; "FirstName"; Text[100])
        {
            Caption = 'FirstName';
            NotBlank = true;
            Editable = true;
        }

        field(4; "LastName"; Text[100])
        {
            Caption = 'LastName';
            NotBlank = true;
            Editable = true;
        }
        field(5; "Seminar 1 Paid"; Decimal)
        {
            Caption = 'Seminar 1 Paid';
            NotBlank = true;
            Editable = true;
        }
        field(6; "Seminar 2 Paid"; Decimal)
        {
            Caption = 'Seminar 2 Paid';
            NotBlank = true;
            Editable = true;
        }
        field(7; "Payment Method"; Text[100])
        {
            Caption = 'Payment Method';
            NotBlank = true;
            Editable = true;

        }
        field(8; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            NotBlank = true;
            Editable = true;

        }
    }

    keys
    {
        key(Key1; "UserName")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "UserName", "Password", "FirstName", "LastName", "Seminar 1 Paid", "Seminar 2 Paid", "Payment Method", "Receipt No.")
        {

        }

    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}