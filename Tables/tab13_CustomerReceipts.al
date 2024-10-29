table 50113 "CSD Customer Receipts"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; MyField; Integer)
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; MyField)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        field(1, "Receipt No.", Integer;)
        {
            Caption = 'Receipt No.';
            NotBlank = true;
        }
        field(2, "First Name",Text[50];)
        {
            Caption = 'First Name';
        }
        field(3,"Amount", Decimal;)
        {
            Caption = 'Amount';
        }
        field(4,"Date",)
        {
           Caption = 'Date';
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