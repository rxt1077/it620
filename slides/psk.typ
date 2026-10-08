#import "/templates/slides.typ": *
#import "@preview/cetz:0.5.1"
#import "@preview/cntopo:0.1.0": cetz, fletcher-shapes
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#let outcomes = ("monitor", "build-manage", "deauth", "psk")
#let title = [Pre-Shared Key Attacks]

#show: university-theme.with(
  short-title: [PSK],
)

#title-slide(
  title: title,
)

#slide[
  == Pre-shared Key vs Enterprise

  #grid(columns: (1fr, 1fr), inset: 1em)[
    // WiFi symbol, lock, and key
    #align(center)[
      #cetz.canvas({
        import cetz.draw: *

        circle((0, 0), fill: black, radius: 8pt)
        arc((0.7cm, 0.3cm), start: 45deg, stop: 135deg, radius: 1cm, stroke: (thickness: 8pt, cap: "round"))
        arc((1.0cm, 0.6cm), start: 45deg, stop: 135deg, radius: 1.45cm, stroke: (thickness: 8pt, cap: "round"))
        arc((1.4cm, 0.9cm), start: 45deg, stop: 135deg, radius: 2cm, stroke: (thickness: 8pt, cap: "round"))
        rect((0.6cm, -2cm), (rel: (1.5cm, 1.5cm)), fill: red.lighten(50%), stroke: 8pt, radius: 0.2cm)
        arc((2.0cm, -0.5cm), start: 0deg, stop: 180deg, radius: 0.65cm, stroke: 8pt)
        circle((1.35cm, -1.0cm), fill: black, radius: 6pt)
        line((1.35cm, -1.0cm), (1.15cm, -1.7cm), (1.55cm, -1.7cm), close: true, fill: black)
        circle((-1.3cm, -1.0cm), fill: black, radius: 10pt)
        line((-1.3cm, -1.0cm), (0.3cm, -1.0cm), stroke: 8pt)
        line((0.1cm, -1.0cm), (0.1cm, -1.4cm), stroke: 8pt)
      })

      === PSK
    ]

    - Easy setup
    - One password for everyone
    - Usually used in homes
    - Hard to revoke access
  ][
    #align(center)[
      // WiFi symbol, person, and server
      #cetz.canvas({
        import cetz.draw: *

        circle((0, 0), fill: black, radius: 8pt)
        arc((0.7cm, 0.3cm), start: 45deg, stop: 135deg, radius: 1cm, stroke: (thickness: 8pt, cap: "round"))
        arc((1.0cm, 0.6cm), start: 45deg, stop: 135deg, radius: 1.45cm, stroke: (thickness: 8pt, cap: "round"))
        arc((1.4cm, 0.9cm), start: 45deg, stop: 135deg, radius: 2cm, stroke: (thickness: 8pt, cap: "round"))
        circle((1.7cm, -0.1cm), radius: 0.5cm, stroke: 8pt, fill: blue.lighten(50%))
        arc((2.7cm, -1.6cm), start: 0deg, stop: 180deg, radius: 1cm, stroke: 8pt, mode: "CLOSE", fill: blue.lighten(50%))
        rect((-3cm, -1.6cm), (rel: (3cm, 1cm)), stroke: 8pt, radius: 0.2cm, fill: blue.lighten(50%))
        circle((-2.5cm, -1.1cm), fill: black, radius: 5pt)
        line((-1.6cm, -1.1cm), (-0.4cm, -1.1cm), stroke: 6pt)
      })

      === Enterprise
    ]

    - #link("https://en.wikipedia.org/wiki/RADIUS")[RADIUS authentication]
    - Harder to set up
    - Usually used in businesses
    - Easy to revoke access
  ]
]

#alternate(
  title: "WEP",
  image: licensed-image(
    file: "/images/wep.jpg",
    license: "CC BY-SA 2.0",
    author: [Wesley Fryer],
    author-url: "https://www.flickr.com/photos/wfryer/",
    title: [Hex equivalents for WEP passphrase],
    url: "https://www.flickr.com/photos/31442459@N00/313328400",
  ),
  text: [
    - Wireless Equivalent Privacy (WEP)
    - Uses RC4, a broken cipher
    - Uses initialization vectors and PSK to initialize RC4
    - IV are transmitted in plaintext and _may_ leak information about the PSK
  ],
)

#alternate(
  title: "RC4, WEP, and Weak IVs",
  image: licensed-image(
    file: "/images/rc4.svg",
    license: "CC BY-SA 3.0",
    author: [Stannered],
    author-url: "https://commons.wikimedia.org/wiki/User:Stannered",
    title: [Basic WEP Encryption: RC4 keystream XORed with plaintext],
    url: "https://en.wikipedia.org/wiki/Wired_Equivalent_Privacy#/media/File:Wep-crypt-alt.svg",
  ),
  text: [
    - Subnet Access Protocol (SNAP) headers are usually encrypted (IP and ARP traffic), they all start with 0xAA
    - With the cipher text and the plain text you can get the key stream
    - With the IV (transmitted plaintext) and key stream #link("https://cacm.acm.org/opinion/wifi-attack-vectors/")[you _may_ be able to get part of the key if the IV is weak]
    - IVs are 24 bits and repeat after about 5000 frames, which makes things easier
    - With enough frames and you can crack the WEP key
  ]
)

#slide[
  == Pairwise vs Group Keys in WPA

  #let (
    monitor,
    w-ap,
  ) = fletcher-shapes(
    flat: false,
  )
  #let node = node.with(width: 2em, height: 2em)
  #let edge = edge.with(dash: "dashed")
  #let topo(title, key1, key2, key3) = [
    #diagram(
      node((1, 0), shape: w-ap.with(detail: "AP"), name: <ap1>),
      node((0, 1), shape: monitor.with(label: "Station 1"), name: <sta1>),
      node((1, 1), shape: monitor.with(label: "Station 2"), name: <sta2>),
      node((2, 1), shape: monitor.with(label: "Station 3"), name: <sta3>),
      edge(<ap1>, <sta1>, label: text(size: 0.5em)[#key1], label-pos: 0.99),
      edge(<ap1>, <sta2>, label: text(size: 0.5em)[#key2], label-pos: 0.75),
      edge(<ap1>, <sta3>, label: text(size: 0.5em)[#key3], label-pos: 0.99),
    )
    === #title
  ]
  #grid(columns: 2, rows: 1, gutter: 1em, align:  horizon + center, stroke: 1pt, inset: 1em,
    topo("Pairwise", "Key 1", "Key 2", "Key 3"),
    topo("Group", "Group Key", "Group Key", "Group Key")
  )
]

#let handshake(step) = {
  let hide-if-less-than(step, num, items) = {
    if (step < num) {
      return fletcher.hide({items})
    }
    return items
  }

  return diagram(
    spacing: (3em, 0.75em),
    node-stroke: 1pt,
    edge-stroke: 1pt,
    {
      node((0,0), text(size: 0.75em)[*Access Point*], fill: orange)
      node((1,0), text(size: 0.75em)[*Station*], fill: yellow)

      node((-0.25,0.6), text(size: 0.5em)[*PMK*], fill: red) 
      node((1.25,0.6), text(size: 0.5em)[*PMK*], fill: red) 

      edge((0,0), (0,8), stroke: (dash: "dashed", paint: gray))
      edge((1,0), (1,8), stroke: (dash: "dashed", paint: gray))

      //EAPOL-Key Message 1
      hide-if-less-than(step, 1, {
        edge((0,1), (1,2), "->", label: [Anonce], label-size: 0.5em)
        node((-0.25,1.2), text(size: 0.5em)[*Anonce*], fill: green)
        node((1.25,2), text(size: 0.5em)[*Anonce*], fill: green)
      })

      //EAPOL-Key Message 2
      hide-if-less-than(step, 2, {
        edge((1,3), (0,4), "->", label: [Snonce + MIC], label-size: 0.5em)
        node((1.25,3), text(size: 0.5em)[*Snonce*], fill: blue)
        node((1.25,3.55), text(size: 0.5em)[*MIC*], fill: purple)
        node((1.25,4.10), text(size: 0.5em)[*PTK*], fill: red)
        node((-0.25,4), text(size: 0.5em)[*Snonce*], fill: blue)
        node((-0.25,4.55), text(size: 0.5em)[*MIC*], fill: purple)
      })

      //EAPOL-Key Message 3
      hide-if-less-than(step, 3, {
        edge((0,5), (1,6), "->", label: [GTK + MIC], label-size: 0.5em)
        node((-0.25,5), text(size:0.5em)[*PTK*], fill: red)
        node((-0.25,5.55), text(size:0.5em)[*GTK*], fill: red)
        node((1.25,6), text(size:0.5em)[*GTK*], fill: red)
      })

      //EAPOL-Key Message 4
      hide-if-less-than(step, 4, {
        edge((1,7), (0,8), "->", label: [ACK], label-size: 0.5em)
      })
    }
  )
}

#slide[
  == WPA2-Personal (PSK) 4-Way Handshake

  #grid(columns: (1fr, 1fr), handshake(0))[
    - Mostly _unencrypted_ EAPOL-Key frames (Extensible Authentication Protocol over LAN)
    - Starts after the station completes the association phase
    - Everyone has the Pairwise Master Key (PMK) (built from the passphrase and SSID)
  ]
]

#slide[
  == WPA2-Personal (PSK) 4-Way Handshake

  #grid(columns: (1fr, 1fr), handshake(1))[
    - AP generates Anonce and sends it
    - Anonce is a random 256 bit number
  ]
]

#slide[
  == WPA2-Personal (PSK) 4-Way Handshake

  #grid(columns: (1fr, 1fr), handshake(2), text(size: 0.85em)[
    - Station generates Snonce
    - Station derives Pairwise Temporal Key (PTK) from PMK, ANonce, SNonce, and MAC addresses
    - Station generates Message Integrity Check (MIC) from MAC addresses, ANonce, SNonce, and PMK
    - The MIC _does not_ contain the PMK but you can only get it right if you have the PMK
    - Station sends Snonce and MIC _unencrypted_
  ])
]

#slide[
  == WPA2-Personal (PSK) 4-Way Handshake

  #grid(columns: (1fr, 1fr), handshake(3), text(size: 0.9em)[
    - AP generates and compares MICs
    - AP derives PTK from PMK, ANonce, SNonce, and MAC addresses
    - AP sends key installation request, MIC, and current Group Temporal Key (GTK)
    - Stations all use a GTK for multicast traffic
    - The GTK is encrypted with the derived PTK!
  ])
]

#slide[
  == WPA2-Personal (PSK) 4-Way Handshake

  #grid(columns: (1fr, 1fr), handshake(4))[
    - Station installs keys and acknowledges
  ]
]
