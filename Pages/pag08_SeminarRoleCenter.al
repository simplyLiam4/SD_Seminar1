page 50108 "CSD SeminarRoleCenter"
{
    PageType = RoleCenter; //Specifies that the page is of type RoleCenter, which is a dashboard-type page in BC, often used as a landing page for users in specific roles.

    layout
    {
        area(RoleCenter)
        {
            part(headline; "Headline RC Administrator")
            {
                ApplicationArea = basic, suite;//Defines the application areas in which this part is available. basic and suite are predefined areas in BC.
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
                Image = Setup;//Specifies the icon for this action, in this case, a setup-related icon.
                ToolTip = 'Enables you to view and Edit The numbering of Seminars ';//text that appears when a user hovers over the action.
            }
        }
        area(Sections)
        {
            group(Resources)
            {
                action(Rooms)//Adds an action named Rooms
                {
                    RunObject = Page "Resource List";//This action opens the "Resource List" page.
                    Caption = 'Rooms';
                    ToolTip = 'Enables you select a specific Seminar Room';
                    Image = BOMVersions;
                    RunPageLink = Type = const(Machine);//Filters the "Resource List" page to only show resources of the type Machine (likely corresponding to rooms).
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
        area(Embedding)//A new area for embedding additional actions or sections.
        {

            action(Comments)//Adds an action for managing comments
            {
                Caption = 'Comments';
                Image = Comment;
                ToolTip = 'Enables you include comments';
                RunObject = Page "Comment List";//This action opens the "Comment List" page.
            }
        }
    }
}
profile Seminar//This section defines a Profile for the "Seminar" role

{
    Caption = 'Seminar';
    RoleCenter = "CSD SeminarRoleCenter";// Links the "CSD SeminarRoleCenter" page as the RoleCenter for users with this profile, meaning this RoleCenter will be displayed when they log in.
}