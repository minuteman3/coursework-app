# Requirements

## Global

### Security/Data Integrity

The whole application should be SSLed. Authentication should happen once per session, and time out after a user-configurable amount of time, not longer than 30 minutes. 

The data being uploaded should be inaccessible to any user except the uploading user and the administrators. It should not be possible for an administrator to accidentally leak a user's data, for example, absolutely no magic URLs, etc.

The site should be RESTful and support proper sessions. (i.e. just do it right and use common sense)

No URL on the site should *ever* leak any user data. The username, password, submission content, etc. should *never* appear in any request or response URL. (See the immediately previous point)

## User Visible

### Authentication

Authentication should happen. It should ideally be against some external authentication service, and the communication between the application and that authentication service should be as secure as is reasonably possible.

Authentication should time out, and the timeout should be user-configurable.

[Mozilla Persona](http://www.mozilla.org/en-US/persona/) would make an effective authentication and authorization platform. Suitability would need to be explored, and ideally the application could be fully abstracted from its authentication service and provide an interface to which various authentication services can be easily connected.

### Configuration

The user should be able to configure some things. Username and password should not be configurable, and ideally should never pass through the application at all, if it uses an external authentication service. They absolutely should never be stored anywhere by the application or even be resident in the application's memory after authentication is complete.

### Enrolment

The user should be able to view a list of available courses, select courses, and request enrolment in those courses.

### Submission

The user should be able to view past submissions (ideally using a github-style embedded diff view, or some equally visually appealling method) and upload new submissions for assignments that are open for submission. The user should always be able to view past submissions for assignments that are no longer submissible.

### Grades

The user should be able to view their submitted assignments, and the grade they attained in each assignment.

#### Class Ranking

The user should be able to view their ranking within the class. If they are struggling with the material, then knowing that other people are also struggling provides some moral support, and a group of students who are all struggling are more likely to do something about it than a collection of individuals who think they alone are finding the class heavy going.

The ranking graphic should be anonymous, and should not be able to be misused to divine the grades of other people enrolled in the class. A good solution would be a frequency distribution of marks in the class, with percentile along X in bins, each of width 10%, and frequency along Y. There should be a single data point on the graph, at the top of the bin into which the user falls. Ideally, a trace of the bins (a pretty curve) should be shown, as opposed to an actual histogram.

For example:

                |
                |
                |
            F   |
            r   |                             .   .
            e   |                         . *  
            q   |                     .               .
            u   |         .   .   .
            e   |     .
            n   | .
            c   |
            y   |___.___.___.___.___.___.___.___.___.___.
                0%  10  20  30  40  50  60  70  80  90  100%
                              
                              Average Grade
                
                * == You

#### Detailed Feedback

Ideally, the grader should be able to highlight a section of any submitted document, and type a comment to show to the user about that section of code or text. Things like "You lost some marks here because you didn't do such-and-such a thing that was stated in the assignment brief". This would be helpful for obvious reasons, and if it was very easy to do (literally highlight, click and type a comment) then graders might actually use it. A culture of detailed constructive feedback is quite clearly beneficial to the student.

For example:

        _____________________________________________________________
       | FireSheep Wub Br0wsor                                    - X|
       |_____________________________________________________________|
       |                                                             |
       |    Assignment 5                                             |
       |                                                             |
       |     ______________________________                          |
       |    |                              |                         |
       |    | * * * * * 1 * * * * * *      |  Comment 1:             |
       |    | * int main (void) {   *      |  _____________________  |
       |    | * * * * * * * * * * * *      | |                     | |
       |    |       printf("%d==D", 8);    | | In class we learned | |
       |    |       return 0;              | | "main" is supposed  | |
       |    |   }                          | | to take an int and  | |
       |    |                              | | a char**.           | |
       |    |                              | |_____________________| |
       |    |                              |                         |
       |    |                              |                         |
       |    |                              |                         |
       |    |                              |                         |
       |    |                              |                         |
       |    |                              |                         |
       |    |                              |                         |
       |    |                              |                         |
       |    |                              |                         |
       |    |                              |                         |
       |    |______________________________|                         |
       |                                                             |
       |                                                             |
       |                                                             |
       |_____________________________________________________________|

Obviously this mockup is a mockup. The asterisk surrounded region could be a highlighted CSS roundrect, the comment box too, the comments mightn't necessarily be identified by integers, etc.

The Open Knowledge Foundation's [Annotator](http://okfnlabs.org/annotator/) would be eminently suitable for this task.

## Admin Visible

### Grading Interface

The grading interface should allow an admin to:

1. Create assignments
2. Create courses with which assignments are associated
3. Accept student enrolment in courses
4. Globally set and change weights for assignments and have all user grades recalculated
5. Assign a grade to a user for a particular assignment.
6. Globally set assignments as submissible or not submissible
7. Globally set a time window within which the assignment is submissible and outside of which it is not submissible
8. Access the assignment submissions for any user for any assignment

### Management Interface

Administrators should be able to modify system parameters, such as:

1. The maximum upload size for submissions
2. Number of submission attempts per time period (avoid DoS)
3. Number of download attempts for submitted assignments per time period (avoid DoS)
4. User roles for administrators (can create new assignments, can create new courses, etc.)
5. Versioning backend for submissions (if multiple supported), versioning backend parameters
6. Data store (if multiple supported), data store parameters (db location etc. etc.)
7. Themes? (shudder)
    
## Backend

Assignment submissions should be versioned, and successive submissions should be stored, not just the current submission or the last N submissions.
