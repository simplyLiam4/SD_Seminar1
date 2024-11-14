table 50114 "CSD Registered Customers"
{
    Caption = 'Registered Customers';

    fields
    {
        field(1; "CustomerNo."; Code[40])
        {
            Caption = 'CustomerNo';
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                recCustomer: Record Customer;
            begin
                if recCustomer.Get("CustomerNo.") then
                    Name := recCustomer.Name;

            end;

        }


        field(2; "Name"; Text[100])
        {
            Caption = 'Name';
            NotBlank = true;
            Editable = true;
        }

        field(3; "Seminar Registration "; Code[40])
        {
            DataClassification = CustomerContent;
            TableRelation = "CSD Seminar Reg. Header";
            trigger OnValidate()
            var
                recSeminarRegHeader: Record "CSD Seminar Reg. Header";
            begin
                if recSeminarRegHeader.Get("Seminar Registration ") then begin
                    SeminarName := recSeminarRegHeader."Seminar Name";
                    SeminarStartingDate := recSeminarRegHeader."Starting Date";
                    Status := recSeminarRegHeader.Status;
                    Amount := recSeminarRegHeader."Seminar Price";
                end;

            end;

        }
        field(4; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            TableRelation = "CSD Seminar Reg. Header";
            trigger OnValidate()
            var
                recSeminarRegHeader: Record "CSD Seminar Reg. Header";
            begin
                if recSeminarRegHeader.Get("Seminar Registration ") then
                    Amount := recSeminarRegHeader."Seminar Price";
            end;
        }
        field(5; "DateofRegistration"; Date)
        {

        }
        field(6; "SeminarName"; Text[100])
        {
            Caption = 'Seminar Name';

        }
        field(7; "SeminarStartingDate"; Date)
        {
            Caption = 'SeminarStartingDate';
        }

        field(8; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Planning,Registration,Closed,Canceled';
            OptionMembers = Planning,Registration,Closed,Canceled;
        }

    }

    keys
    {
        key(Key1; "CustomerNo.")
        {
            Clustered = true;
        }
    }

    // fieldgroups
    // {
    //     fieldgroup(DropDown; "CustomerNo.", "FirstName", "LastName", "Payment Method")
    //     {

    //     }

    // }



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