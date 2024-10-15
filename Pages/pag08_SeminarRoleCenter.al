page 50108 "CSD SeminarRoleCenter"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(headline; "Headline RC Administrator")
            {
                ApplicationArea = basic, suite;
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action(SeminarSetup)
            {
                RunObject = Page "CSD Seminar Setup";
                Caption = 'Seminar Setup';
                Image = Setup;
                ToolTip = 'Enables you to view and Edit The numbering of Seminars ';
            }
        }
        area(Sections)
        {
            group(Resources)
            {
                action(Rooms)
                {
                    RunObject = Page "Resource List";//
                    Caption = 'Rooms';
                    ToolTip = 'Enables you select a specific Seminar Room';
                    Image = BOMVersions;
                    RunPageLink = Type = const(Machine);
                }

                action(Instructor)
                {
                    RunObject = Page "Resource List";
                    Caption = 'Instructor';
                    Image = Employee;
                    ToolTip = 'Enables you select an instructor';
                    RunPageLink = Type = const(Person);
                }
            }
        }
        area(Embedding)
        {

            action(Comments)
            {
                Caption = 'Comments';
                Image = Comment;
                ToolTip = 'Enables you include comments';
                RunObject = Page "Comment List";
            }
        }
    }
}
profile Seminar

{
    Caption = 'Seminar';
    RoleCenter = "CSD SeminarRoleCenter";
}