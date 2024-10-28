table 50111 "CSD Seminar Registration Line"

//   Chapter 6 - Lab 1-5
//     - Created new table
{
    Caption = 'Seminar Registration Line';


    fields
    {
        field(1; "Document No."; Code[20])
        {
            caption = 'Document No.';
            TableRelation = "CSD Seminar Reg. Header";
        }
        field(2; "Line No."; Integer)
        {
            caption = 'Line No.';
        }
        field(3; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;

            trigger OnValidate();
            begin
                if "Bill-to Customer No." <> xRec."Bill-to Customer No." then begin
                    if Registered then begin
                        ERROR(RegisteredErrorTxt,
                          FieldCaption("Bill-to Customer No."),
                          FieldCaption(Registered),
                          Registered);
                    end;
                end;
            end;
            //The OnValidate trigger ensures that if the customer changes, the registration status (Registered) is checked. If already registered, an error prevents the change.
        }
        field(4; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.';
            TableRelation = Contact;

            trigger OnLookup(); // Opens a lookup dialog for selecting a contact related to the customer in "Bill-to Customer No.".
            begin
                ContactBusinessRelation.Reset;
                ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
                ContactBusinessRelation.SetRange("No.", "Bill-to Customer No.");
                if ContactBusinessRelation.FindFirst then begin
                    Contact.SetRange("Company No.", ContactBusinessRelation."Contact No.");
                    if page.RunModal(page::"Contact List", Contact) = "Action"::LookupOK then
                        "Participant Contact No." := Contact."No.";
                end;

                CalcFields("Participant Name");
            end;
            //OnLookup trigger: Opens a lookup dialog to select a contact from the contacts related to the customer in "Bill-to Customer No.".

            trigger OnValidate();
            // makes sure that the contact selected by the user is related to the customer that is specified in the Bill-to Customer No. field
            begin
                if ("Bill-to Customer No." <> '') and
                   ("Participant Contact No." <> '')
                then begin
                    Contact.Get("Participant Contact No.");
                    ContactBusinessRelation.Reset;
                    ContactBusinessRelation.SetCurrentKey("Link to Table", "No.");
                    ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
                    ContactBusinessRelation.SetRange("No.", "Bill-to Customer No.");
                    if ContactBusinessRelation.FindFirst then begin
                        if ContactBusinessRelation."Contact No." <> Contact."Company No." then begin
                            ERROR(WrongContactErrorTxt, Contact."No.", Contact.Name, "Bill-to Customer No.");
                        end;
                    end;
                end;
            end;
        }
        field(5; "Participant Name"; Text[100])
        //Displays the participant's name using a FlowField to pull the contact's name from the Contact table based on "Participant Contact No.".
        {
            Caption = 'Participant Name';
            CalcFormula = Lookup(Contact.Name where("No." = Field("Participant Contact No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Registration Date"; Date)
        //The date of registration, which is not editable, typically set when the record is inserted.

        {
            Caption = 'Registration Date';
            Editable = false;
        }
        field(7; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice';
            InitValue = true;
        }
        field(8; Participated; Boolean)
        //Indicates if the participant attended the seminar.
        {
            Caption = 'Participated';
        }
        field(9; "Confirmation Date"; Date)
        //Date when registration was confirmed. It is not editable by the user.
        {
            Caption = 'Confirmation Date';
            Editable = false;
        }
        field(10; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            AutoFormatType = 2;

            trigger OnValidate();
            begin
                VALIDATE("Line Discount %");
            end;
            //OnValidate trigger: Automatically validates and recalculates the line discount percentage when the seminar price is changed.
        }
        field(11; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate();
            begin
                if "Seminar Price" = 0 then begin
                    "Line Discount Amount" := 0;
                end else begin
                    GLSetup.Get;
                    "Line Discount Amount" := Round("Line Discount %" * "Seminar Price" * 0.01, GLSetup."Amount Rounding Precision");
                end;
                UpdateAmount;
            end;
            //OnValidate trigger: If the seminar price is 0, it sets the discount amount to 0. Otherwise, it recalculates the discount amount based on the price.
        }
        field(12; "Line Discount Amount"; Decimal)
        {
            Caption = 'Line Discount Amount';
            AutoFormatType = 1;

            trigger OnValidate();
            begin
                if "Seminar Price" = 0 then begin
                    "Line Discount %" := 0;
                end else begin
                    GLSetup.Get;
                    "Line Discount %" := Round("Line Discount Amount" / "Seminar Price" * 100, GLSetup."Amount Rounding Precision");
                end;
                UpdateAmount;
            end;
            //OnValidate trigger: If the seminar price is 0, the discount percentage is set to 0. Otherwise, it calculates the discount percentage based on the discount amount.
        }
        field(13; Amount; Decimal)
        {
            Caption = 'Amount';
            AutoFormatType = 1;

            trigger OnValidate();
            begin
                TestField("Bill-to Customer No.");
                TestField("Seminar Price");
                GLSetup.Get;
                Amount := Round(Amount, GLSetup."Amount Rounding Precision");
                "Line Discount Amount" := "Seminar Price" - Amount;
                if "Seminar Price" = 0 then begin
                    "Line Discount %" := 0;
                end else begin
                    "Line Discount %" := Round("Line Discount Amount" / "Seminar Price" * 100, GLSetup."Amount Rounding Precision");
                end;
            end;
            //OnValidate trigger: Ensures that the customer and seminar price are valid, rounds the amount, and calculates the line discount and discount percentage.
        }
        field(14; Registered; Boolean)
        {
            Caption = 'Registered';
            Editable = false;
        }
        //Indicates if the participant is registered. This field is not editable by the user.
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    trigger OnDelete(); // makes sure that only the lines that are not registered can be deleted
    begin
        TestField(Registered, false);
    end;

    trigger OnInsert();//Automatically sets the Registration Date, Seminar Price, and Amount when a new line is inserted. The values are pulled from the related seminar header.
    begin
        GetSeminarRegHeader;
        "Registration Date" := WorkDate;
        "Seminar Price" := SeminarRegHeader."Seminar Price";
        Amount := SeminarRegHeader."Seminar Price";
    end;


    var
        SeminarRegHeader: Record "CSD Seminar Reg. Header";
        SeminarRegLine: Record "CSD Seminar Registration Line";
        ContactBusinessRelation: Record "Contact Business Relation";
        Contact: Record Contact;
        GLSetup: Record "General Ledger Setup";
        SkipBillToContact: Boolean;
        RegisteredErrorTxt: Label 'You cannot change the %1, because %2 is %3.';
        WrongContactErrorTxt: Label 'Contact %1 %2 is related to a different company than customer %3.';

    local procedure GetSeminarRegHeader();
    // GetSeminarRegHeader procedure is to standardize the retrieval of the header variable, and to ensure that the header is only retrieved if necessary.
    begin
        if SeminarRegHeader."No." <> "Document No." then
            SeminarRegHeader.Get("Document No.");
    end;

    local procedure CalculateAmount();
    begin
        Amount := Round(("Seminar Price" / 100) * (100 - "Line Discount %"));
    end;

    local procedure UpdateAmount();
    //UpdateAmount procedure is to standardize the calculation of the amounts.
    begin
        GLSetup.Get;
        Amount := Round("Seminar Price" - "Line Discount Amount", GLSetup."Amount Rounding Precision");
    end;
}