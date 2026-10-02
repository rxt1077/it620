#import "templates/syllabus.typ": syllabus
#import "outcomes.typ": outcomes

#show: doc => syllabus(
  course: [IT 620 Wireless Networks Security and Administration],
  office-hours: [12:00PM to 1:00PM on Thursdays and Fridays or via Zoom (email to schedule)],
  objective: [
    This course introduces the fundamentals of wireless network security and administration.
    Topics include: wireless LAN vulnerabilities, passive and active wireless attacks, enterprise wireless hardware security, secure wireless authentication and communication, wireless intrusion detection and prevention systems, WiFi and cellular network management, location privacy, personal area network administration and security, mobile IP security, GSM, CDPD, 3G and 4G network security.
    The course provides both a theoretical foundation and hands-on experience in these areas.
  ],
  grading: (
    [20% Labs],
    [20% Quizzes],
    [20% Project],
    [20% Midterm Exam],
    [20% Final Exam]),
  course-materials: (
    [A laptop meeting the #link("https://ist.njit.edu/student-computers-recommended-specs")[YWCC minimum specs]],
    [#link("https://www.virtualbox.org/wiki/Downloads")[VirtualBox] installed and working],
    [#link("https://git-scm.com/downloads")[git] installed and working],
    [#link("https://www.python.org/downloads/")[Python] installed and working],
    [#link("https://mininet-wifi.github.io/")[Mininet-WiFi]],
    [Textbook: #link("https://wndw.net")[Wireless Networking in the Developing World (WNDW)]],
    [Textbook: #link("https://hpbn.com")[High Performance Browser Networking (HPBN)]],
  ),
  outcomes: outcomes,
  outline: (
    (
      _type: "standard",
      week: [1],
      slides: (),
      labs: ()
    ),
    (
      _type: "standard",
      week: [2],
      slides: (),
      labs: ()
    ),
    (
      _type: "standard",
      week: [3],
      slides: (),
      labs: (),
    ),
    (
      _type: "standard",
      week: [4],
      slides: (),
      labs: (),
    ),
    (
      _type: "standard",
      week: [5],
      slides: (),
      labs: (),
    ),
    (
      _type: "standard",
      week: [6],
      slides: (),
      labs: (),
    ),
    (
      _type: "exam",
      week: [7],
      body: [
        - Midterm
      ],
      outcomes: (),
    ),
    (
      _type: "standard",
      week: [8],
      slides: (),
      labs: (),
    ),
    (
      _type: "standard",
      week: [9],
      slides: (),
      labs: (),
    ),
    (
      _type: "standard",
      week: [10],
      slides: (),
      labs: (),
    ),
    (
      _type: "standard",
      week: [11],
      slides: (),
      labs: (),
    ),
    (
      _type: "standard",
      week: [12],
      slides: (),
      labs: (),
    ),
    (
      _type: "standard",
      week: [13],
      slides: (),
      labs: (),
    ),
    (
      _type: "standard",
      week: [14],
      slides: (),
      labs: (),
    ),
    (
      _type: "standard",
      week: [15],
      slides: (),
      labs: (),
    ),
    (
      _type: "exam",
      week: [Finals],
      body: [
        - Final
      ],
      outcomes: (),
    ),
  ),
  doc,
)
