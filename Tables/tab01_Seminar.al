table 50101 "CSD Seminar"

{
    Caption = 'Seminar';
    fields
    {

        field(10; "No."; Code[20])
        {
            Caption = 'No.';
        }

        field(20; "Name"; Text[50])
        {
            Caption = 'Name';
            trigger OnValidate();

            begin
                if ("Search Name" = UpperCase(xRec.Name)) or
                ("Search Name" = '') then
                    "Search Name" := Name;
            end;
        }

        field(30; "Seminar Duration"; Decimal)
        {
            Caption = 'Seminar Duration';
        }

        field(40; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
        }

        field(50; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
        }

        field(60; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }

        field(70; "Blocked"; Boolean)
        {
            Caption = 'Blocked';
        }

        field(80; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }

        field(90; "Comment"; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;

            //CalcFormula = exist("CSD Seminar Comment Line " where "Table"
            //Name" = const ("seminar") , "No." = field("No.")));
        }

        field(100; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
        }

        field(110; "Gen. Prod. Posting Group "; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';

            trigger OnValidate();
            begin
                if (xRec."Gen. Prod. Posting Group " <>
                    "Gen. Prod. Posting Group ") then begin
                    if GenProdPostingGroup.ValidateVatProdPostingGroup
                       (GenProdPostingGroup, "Gen. Prod. Posting Group ") then
                        Validate("VAT Prod. Posting Group",
                        GenProdPostingGroup."Def. VAT Prod. Posting Group");
                end;
            end;
        }

        field(120; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
        }

        field(130; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
        }

    }


    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    var
        SeminarSetup: Record "CSD Seminart Setup";
        //CommentLine : record "CSD Seminar Comment Line";

        Seminar: Record "CSD Seminar";
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert();

    begin
        if "No." = '' then begin
            SeminarSetup.get;
            SeminarSetup.TestField("Seminar Nos.");
            NoSeriesMgt.InitSeries(SeminarSetup."Seminar Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;

    end;


    trigger OnModify();
    begin

        "Last Date Modified" := Today;
    end;

    trigger OnRename();
    begin

        "Last Date Modified" := Today;
    end;

    trigger OnDelete();
    begin
        //CommentLine.Reset;
        //Comment.SetRange("Table Name"),
        //CommentLine."Table Name" ::Seminar);
        //CommentLine.SetRange("No.","No.");
        //CommentLine.DeleteAll;
    end;

    trigger OnValidate();
    begin

        if "No." <> xRec."No." then begin
            SeminarSetup.GET;
            NoSeriesMgt.TestManual(SeminarSetup."Seminar Nos.");
            "No. Series" := '';

        end;
    end;

    procedure AssistEdit(): Boolean;

    begin
        with Seminar do begin
            Seminar := Rec;
            SeminarSetup.get;
            SeminarSetup.TestField("Seminar Nos.");
            if NoSeriesMgt.SelectSeries(SeminarSetup."Seminar Nos."
               , xRec."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := Seminar;
                exit(true);
            end;
        end;

    end;

}