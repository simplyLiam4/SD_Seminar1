pageextension 50102 "CSD ResourceCardExt" extends "Resource Card"
//CSD1.00 - 2018-02-01 -D. E. Veloper
// Chapter 5 - Lab 1-2
//Added new fields
//Interna/External
//Maximum Participants
//Added new FastTab
//Added code to OnOpenPage trigger

{
    layout
    //layout section defines the user interface elements (fields, groups) that are added or modified on the page.
    {

        addlast(General)
        //addlast(General): Adds content at the end of the General FastTab (a predefined section on the "Resource Card" page).
        {
            field("CSD Resource Type"; Rec."CSD Resource Type")
            //Adds the field "CSD Resource Type" from the Rec (record) to the page, displaying its value.
            {

            }

            field("CSD Quantity Per Day Type"; Rec."CSD Quantity Per Day Type")
            // adds the "CSD Quantity Per Day Type" field from the record to the page.
            {


            }

        }

        addafter("Personal Data")
        //addafter("Personal Data"): Adds content after the Personal Data FastTab.
        {
            group("CSD Room")
            {
                Caption = 'Room';
                Visible = ShowMaxField;
                field("CSD Maximum Participants Type"; Rec."CSD Maximum Participants")
                {

                }
            }

        }
    }


    trigger OnAfterGetRecord()

    begin
        ShowMaxField := (rec.Type = rec.Type::Machine);
        CurrPage.Update(false);
    end;

    trigger OnAfterGetCurrRecord();

    begin
        ShowMaxField := (rec.Type = rec.Type::Machine);
        CurrPage.Update(false);

    end;

    var
        [InDataSet]
        ShowMaxField: Boolean;
}

