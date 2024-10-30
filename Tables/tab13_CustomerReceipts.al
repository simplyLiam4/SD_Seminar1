table 50113 "CSD Customer Receipts"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            NotBlank = true;
            Editable = false;
        }
        field(2; "First Name"; Text[100])
        {
            Caption = 'First Name';
            Editable = true;
        }
        field(3; "Last Name"; Text[100])
        {
            Caption = 'Last Name';
            Editable = true;
        }

        field(4; "Amount"; Decimal)
        {
            Caption = 'Amount';
            Editable = true;
        }
        field(5; "Date issued"; Date)
        {
            Caption = 'Date';
            Editable = true;
        }
        field(6; "Seminar Start"; Date)
        {
            Caption = 'Seminar Start';

        }
        field(7; "Seminar End"; Date)
        {
            Caption = 'Seminar End';
        }
    }

    keys
    {
        key(Key1; "Receipt No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Receipt No.", "First Name", "Amount", "Date issued", "Last Name")
        {
        }
    }

    //  var
    //     NoSeries: Codeunit "No. Series";



    //     trigger OnInsert()
    // begin
    //     if "Receipt No." = '' then begin
    //         "Receipt No." := No. Series.GetNextNo('RECEIPT', WorkDate, false);
    //         if "Receipt No." = '' then
    //             Error('Unable to generate receipt number. Please check the number series setup.');
    //     end;
    // end;

    // var
    //         NoSeries: Codeunit "No. Series";

    trigger OnModify()
    begin
        // Any logic to execute on modify
    end;

    trigger OnDelete()
    begin
        // Any logic to execute on delete
    end;

    trigger OnRename()
    begin
        // Any logic to execute on rename
    end;
}