#import "/templates/exercise.typ": exercise, code, admonition

#let outcomes = ("monitor", "build-managed")

#show: doc => exercise(
  course-name: "Wireless Network Security and Administration",
  exercise-name: "Project",
  exercise-type: "Project",
  outcomes: outcomes,
  doc,
)

== Summary

For your project you will create a ten minute video presentation based on a paper from the #link("https://docs.google.com/spreadsheets/d/1zycL5WweIgtDHuGEZHiE5zUpn5wyCtX5uDGHk7RZ6Fw/edit?usp=sharing")[Mininet-WiFi Use Case Catalog].
Your video should cover the topics addressed by the paper _and_ include a Mininet-WiFi demo on the topic.
It may be helpful to look for papers where the source code is listed in the spreadsheet.
You may need to use #link("https://researchguides.njit.edu/remoteaccess")[NJIT's library access] to read full PDFS of the journal articles.

== Rubric

#table(
  columns: 3,
  table.header[*Topic*][*Description*][*Points*],
  [Subject Knowledge], [The presentation clearly demonstrates an understanding of the topics covered in the paper], [10],
  [Demonstration], [The presentation utilizes a Mininet-WiFi demonstration to more clearly explain a topic from the paper], [10],
  [Organization], [The presentation is between 8 and 12 minutes with a suitable flow and pacing], [10],
  [Citations], [The presentation cites its sources, including the paper being referenced], [5],
)
