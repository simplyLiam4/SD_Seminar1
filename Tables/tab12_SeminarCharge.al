table 50112 "CSD Seminar Charge"
{

    //   Chapter 6 - Lab 1
    //     - Created new table
    Caption = 'Seminar Charge';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            NotBlank = true;//This field must always have a value.
            TableRelation = "CSD Seminar Reg. Header";//Links to the "CSD Seminar Reg. Header" table, indicating this charge is tied to a seminar registration.
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';//Represents the line number within the document, used to differentiate charges within the same document.

        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Resource,G/L Account';
            OptionMembers = Resource,"G/L Account";

            trigger OnValidate();// When the type changes, it resets the line and reinitializes the values based on the new type.

            var
                OldType: Integer;
            begin
                if Type <> xRec.Type then begin
                    OldType := Type;
                    Init;
                    Type := OldType;
                end;
            end;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(Resource)) Resource."No."
            else if (Type = const("G/L Account")) "G/L Account"."No.";

            trigger OnValidate();
            begin
                case Type of
                    Type::Resource:
                        begin
                            Resource.Get("No.");
                            Resource.TestField(Blocked, false);
                            Resource.TestField("Gen. Prod. Posting Group");
                            Description := Resource.Name;
                            "Gen. Prod. Posting Group" := Resource."Gen. Prod. Posting Group";
                            "VAT Prod. Posting Group" := Resource."VAT Prod. Posting Group";
                            "Unit of Measure Code" := Resource."Base Unit of Measure";
                            "Unit Price" := Resource."Unit Price";
                        end;
                    // Retrieves the resource details and checks if it's blocked.
                    // Populates fields like Description, Gen. Prod. Posting Group, VAT Prod. Posting Group, Unit of Measure Code, and Unit Price.


                    Type::"G/L Account":
                        begin
                            GLAccount.Get("No.");
                            GLAccount.CheckGLAcc();
                            GLAccount.TestField("Direct Posting", true);
                            Description := GLAccount.Name;
                            "Gen. Prod. Posting Group" := GLAccount."Gen. Bus. Posting Group";
                            "VAT Prod. Posting Group" := GLAccount."VAT Bus. Posting Group";
                        end;
                end;
                // Retrieves G/L account details and checks if it's valid for direct posting.
                // Populates fields like Description, Gen. Prod. Posting Group, and VAT Prod. Posting Group.
            end;
        }
        field(5; Description; Text[50])//Provides a description of the charge, such as the name of the resource or G/L account.
        {
            Caption = 'Description';
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;

            trigger OnValidate();
            begin
                "Total Price" := Round("Unit Price" * Quantity, 0.01);
            end;
        }
        field(7; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            AutoFormatType = 2;
            MinValue = 0;

            trigger OnValidate();
            begin
                "Total Price" := Round("Unit Price" * Quantity, 0.01);
            end;
            //OnValidate trigger: Recalculates the total price as Unit Price * Quantity.
        }
        field(8; "Total Price"; Decimal)
        {
            Caption = 'Total Price';
            AutoFormatType = 1;
            Editable = false;

            trigger OnValidate();//Recalculates the unit price based on the total price if the quantity is non-zero.
            begin
                if (Quantity <> 0) then
                    "Unit Price" := Round("Total Price" / Quantity, 0.01)
                else
                    "Unit Price" := 0;
            end;
        }
        field(9; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice';
            InitValue = true;
        }
        field(10; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer."No."; //Links to the Customer table to ensure a valid customer number is selected.
        }
        field(11; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = if (Type = const(Resource)) "Resource Unit of Measure".Code where("Resource No." = Field("No."))
            else
            "Unit of Measure".Code;

            trigger OnValidate();//Ensures the unit of measure is properly validated and calculates the total price based on the quantity per unit of measure.
            begin
                case Type of
                    Type::Resource:
                        begin
                            Resource.Get("No.");
                            if "Unit of Measure Code" = '' then begin
                                "Unit of Measure Code" := Resource."Base Unit of Measure";
                            end;
                            ResourceUofM.Get("No.", "Unit of Measure Code");
                            "Qty. per Unit of Measure" := ResourceUofM."Qty. per Unit of Measure";
                            "Total Price" := Round(Resource."Unit Price" * "Qty. per Unit of Measure");
                        end;
                    Type::"G/L Account":
                        begin
                            "Qty. per Unit of Measure" := 1;
                        end;
                end;
                if CurrFieldNo = FieldNO("Unit of Measure Code") then begin
                    Validate("Unit Price");
                end;
            end;
        }
        field(12; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group".Code;
        }
        field(13; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(14; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
        }
        field(15; Registered; Boolean)//Indicates whether this charge is registered, meaning it is finalized. It cannot be edited directly by the user.

        {
            Caption = 'Registered';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        TestField(Registered, false);
    end;

    trigger OnInsert();
    begin
        SeminarRegistrationHeader.Get("Document No.");
    end;

    var
        GLAccount: Record "G/L Account";
        Resource: Record Resource;
        ResourceUofM: Record "Resource Unit of Measure";
        SeminarRegistrationHeader: Record "CSD Seminar Reg. Header";
}