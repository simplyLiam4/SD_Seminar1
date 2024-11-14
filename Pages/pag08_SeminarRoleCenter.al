page 50108 "CSD SeminarRoleCenter"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(headline; "Headline RC Administrator")
            {
                ApplicationArea = Basic, Suite;
            }
            part(SeminarCommentLine; "CSD Seminar Comment Line")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action(SeminarSetup)
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "CSD Seminar Setup";
                Caption = 'Seminar Setup';
                Image = Setup;
                ToolTip = 'View and edit the numbering of seminars';
            }
            action(CustomerRegistration)
            {
                ApplicationArea = Basic, Suite;
                RunObject = Page "CSD Customer Registration";
                Caption = 'Customer Registration';
                Image = Register;
                ToolTip = 'Register Customers';
            }
        }
        area(Navigation)
        {
            group("Seminar Management")
            {
                action(Seminars)
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "CSD Seminar List";
                    Caption = 'Seminars';
                    Image = List;
                    ToolTip = 'View and manage seminars';
                }
            }
        }
        area(Sections)
        {
            group(Resources)
            {
                Caption = 'Resources';
                ToolTip = 'view and edit available resources(instructors and rooms)';

                action(Rooms)
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Resource List";
                    Caption = 'Rooms';
                    ToolTip = 'Select a specific seminar room';
                    Image = BOMVersions;
                    RunPageLink = Type = const(Machine);
                }

                action(Instructor)
                {
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Resource List";
                    Caption = 'Instructor';
                    Image = Employee;
                    ToolTip = 'Select an instructor';
                    RunPageLink = Type = const(Person);
                }
            }
        }
        area(Embedding)
        {
            action(Comments)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Comments';
                Image = Comment;
                ToolTip = 'View or add comments';
                RunObject = Page "Comment List";
            }
        }
    }
}