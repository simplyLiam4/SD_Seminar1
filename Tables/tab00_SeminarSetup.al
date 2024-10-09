table 50100 "CSD Seminar Setup"
{
    Caption = 'Seminar Setup';

    fields
    {
        field(10; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';

        }

        field(20; "Seminar Nos."; Code[20])
        {
            Caption = 'Seminar Nos';
            TableRelation = "No. Series";

        }
        field(30; "Seminar Registration Nos"; Code[20])
        {
            Caption = 'Seminar Registration Nos';
            TableRelation = "No. Series";

        }
        field(40; "Posted Seminar Reg. Nos."; Code[20])
        {
            Caption = 'Posted Seminar Reg. Nos';
            TableRelation = "No. Series";

        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

    var

        SeminarSetup: Record "CSD Seminar Setup";
        //CommentLine : record "CSD Seminar Comment Line";

        Seminar: Record "CSD Seminar";
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        NoSeriesMgt: Codeunit NoSeriesManagement;





}