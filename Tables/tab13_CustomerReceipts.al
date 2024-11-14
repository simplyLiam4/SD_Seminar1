table 50113 "CSD Customer Receipts"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            Editable = false;
            trigger OnValidate();
            begin

                if "Receipt No." <> xRec."Receipt No." then begin
                    SeminarSetup.GET;
                    NoSeriesMgt.TestManual(SeminarSetup."Seminar Nos.");
                    "No. Series" := '';

                end;
            end;
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
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
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



    trigger OnInsert()
    begin
        if "Receipt No." = '' then begin
            SeminarSetup.get;
            SeminarSetup.TestField("Seminar Nos.");
            NoSeriesMgt.InitSeries(SeminarSetup."Seminar Nos.", xRec."No. Series", 0D, "Receipt No.", "No. Series");
        end;

    end;

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

    var
        CSDCustReceipts: Record "CSD Customer Receipts";
        SeminarSetup: Record "CSD Seminar Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;



    procedure AssistEdit(OldCustomerReceipts: Record "CSD Customer Receipts"): Boolean;
    begin

        CSDCustReceipts := Rec;
        SeminarSetup.get;
        SeminarSetup.TestField("Seminar Nos.");
        if NoSeriesMgt.SelectSeries(SeminarSetup."Seminar Nos."
           , xRec."No. Series", "No. Series") then begin
            NoSeriesMgt.SetSeries("Receipt No.");
            Rec := CSDCustReceipts;
            exit(true);
        end;
    end;
}