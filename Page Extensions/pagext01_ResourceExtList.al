pageextension 50101 "CSD ResourceListExt" extends "Resource List"
// CSD1.00 - 2018-01-01 - D.E Veloper
{
    layout
    {

        modify(Type)
        {
            Visible = Showtype;

        }

        addafter(Type)
        {
            field("CSD Resource Type"; Rec."CSD Resource Type")
            {

            }

            field("CSD Maximum Participants Type"; Rec."CSD Maximum Participants")
            {

                Visible = ShowMaxField;

            }
        }
    }



    trigger OnOpenPage()

    begin
        ShowType := (rec.GetFilter(Type) = '');
        ShowMaxField := (rec.GetFilter(Type) = format(rec.Type::machine));

    end;

    var

        [InDataSet]
        Showtype: Boolean;
        [InDataSet]
        ShowMaxField: Boolean;
}


