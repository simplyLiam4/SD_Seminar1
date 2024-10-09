table 50101 "CSD Seminar"

{
    Caption = 'Seminar';

    fields
    {

        field(10; "No."; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate();
            begin

                if "No." <> xRec."No." then begin
                    SeminarSetup.GET;
                    NoSeriesMgt.TestManual(SeminarSetup."Seminar Nos.");
                    "No. Series" := '';

                end;
            end;


            // OnValidate Trigger: When a user changes the seminar number,
            // it checks if the "No." field differs from the 
            // previous value (xRec."No."). If so, it retrieves the seminar setup and validates if the "Seminar Nos." is manually entered, clearing the "No. Series" field.


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

            // OnValidate Trigger: When the name is validated, it updates the "Search Name" field with the uppercase version of 
            //the name unless the current "Search Name"
            // is already set or blank.
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
            // A boolean to indicate if the seminar is blocked or not.
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
            //  FieldClass = FlowField;

            //  CalcFormula = exist("CSD Seminar Comment Line " where "Table"
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

            //OnValidate Trigger: If the product posting group
            // has changed, it validates the VAT product posting group 
            // against the default VAT product posting group.


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

    // Key1 ("No."): Defines the primary key for the table using the "No." field,
    //  which is also clustered (indexed for performance).

    var
        SeminarSetup: Record "CSD Seminar Setup";
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

    //     OnInsert Trigger:

    //    When a new seminar is inserted,
    //     if the "No." field is blank, the seminar setup is retrieved, 
    //     and a number from the series is assigned to the seminar.


    trigger OnModify();
    begin

        "Last Date Modified" := Today;
    end;

    // OnModify Trigger:

    // When a record is modified, the "Last Date Modified" field 
    // is set to the current date.



    trigger OnRename();
    begin

        "Last Date Modified" := Today;
    end;

    // OnRename Trigger:

    // When a record is renamed, the "Last Date Modified" 
    // field is also updated to the current date.

    trigger OnDelete();
    begin
        //CommentLine.Reset;
        //Comment.SetRange("Table Name"),
        //CommentLine."Table Name" ::Seminar);
        //CommentLine.SetRange("No.","No.");
        //CommentLine.DeleteAll;
    end;


    procedure AssistEdit(): Boolean;

    begin

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



    // AssistEdit Procedure:
    // Opens a dialog to assist the user in selecting a seminar number from the defined number series.
    //  It ensures the series is set correctly before continuing
}