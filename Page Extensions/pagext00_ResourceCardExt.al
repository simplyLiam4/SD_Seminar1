pageextension 50100 "CSD ResourceCardExt" extends "Resource Card"
//CSD1.00 - 2018-02-01 -D. E. Veloper
// Chapter 5 - Lab 1-2
//Added new fields
//Interna/External
//Maximum Participants
//Added new FastTab
//Added code to OnOpenPage trigger

{
    layout
    {

        addlast(General)
        {
            field("CSD Resource Type")
            {

            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}