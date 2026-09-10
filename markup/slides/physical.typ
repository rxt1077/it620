#import "/templates/slides.typ": *

#let title = [RF Physical Infrastructure]

#show: university-theme.with(
  short-title: [RF Infra],
)

#title-slide(
  title: title,
)

#alternate(
  title: [Caution],
  image: grid(columns: 2, gutter: 5pt, image("/images/caution.jpg"), image("/images/roof.jpg")),
  text: [
    - Typically hidden behind closed doors and locked gates, radio frequency infrastructure is everywhere
    - Lets take a look at some infrastructure on the NJIT Newark campus 
  ]
)

#alternate(
  title: [Cell Sites],
  image: grid(columns: 2, gutter: 5pt, image("/images/summit-cell.jpg"), image("/images/gitc-cell.jpg")),
  text: [
    - The campus has two cell sites on campus
    - One is on the elevator towers of the summit parking deck
    - The other is on the roof of GITC
    - Notice how they both blend in with the buildings
  ],
)

#alternate(
  title: [Cellular Frequencies],
  image: licensed-image(
    file: "/images/nokia.jpg",
    title: [Cell Phone],
    url: "https://www.flickr.com/photos/19517696@N00/54117579",
    author: [Shawn Rossi],
    author-url: "https://www.flickr.com/photos/shawnzlea/",
    license: "CC BY-SA 2.0",
  ),
  text: [
    - Low-Band (600Mhz - 900Mhz): penetrates walls and buildings
    - Mid-Band (1.7Ghz - 3.7Ghz): 4G LTE and 5G
    - High-Band/mmWave (24 Ghz - 39 Ghz+): Ultra-fast multi-gigabit speeds, but only works in small, dense, unobstructed environments
  ]
)

#alternate(
  title: [Height],
  image: grid(
    columns: 1fr,
    rows: (1fr, 1fr),
    gutter: 5pt,
    align(left, image("/images/summit-top.jpg")),
    align(right, image("/images/gitc-top.jpg"))
  ),
  text: [
    - RF is largely a line-of-sight technology and height improves "what you can see"
    - Downtilt and distance matters for cellular technologies where you are targeting a particular cell
    - Band choice also matters
    - Rooftop sites also limit height choice
  ]
)

#alternate(
  title: [Antennas],
  image: image("/images/gitc-antennas.jpg"),
  text: [
    - This is the roof of the GITC cell site
    - Notice the different sizes of antennas: large for lower frequencies, small for #link("https://www.youtube.com/watch?v=HH1qPTgIEyo&t=476s")[MIMO (Multiple-Input Multiple-Output) mid-band arrays]
    - Remote Radio Heads (RRH) prevent signal loss in feed lines
  ],
)

#alternate(
  title: [What about WiFi?],
  image: image("/images/ckb-closeup.jpg"),
  text: [
    - Wireless access points (WAP) are placed closer to the ground
    - Typically off the edges of a building
    - Wires go back to a wireless lan controller (WLCs) usually in a locked intermediate distribution frame (IDF) room
  ],
)

#slide[
  == Where are they?

  #grid(
    columns: (1fr, 1fr, 1fr),
    rows: (1fr),
    gutter: 5pt,
    image("/images/campus-center-wap.jpg"),
    place(top + left, dy:25%, image("/images/kupfrian-wap.jpg")),
    image("/images/ckb-wap.jpg"),
  )
]

#focus-slide[
  Now, get out there and notice some RF infrastructure!
]
