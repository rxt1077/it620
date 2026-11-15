#import "@preview/typstage:0.2.0": *
#import "@preview/chronos:0.3.0"

#show link: it => underline(text(fill: blue, it))

#show: presentation.with(
  theme: themes.default,
  palette: (accent: rgb(233, 40, 45), strong: rgb(0, 0, 51)),
  title: [WPA2/3-Enterprise with 802.1X and RADIUS],
  author: [
    Ryan Tolboom \
    IT 620 \
    #link("https://creativecommons.org/licenses/by-nc/4.0/deed.en")[CC BY-NC 4.0]
  ],
  transition: "slide",
)

#let cite(
  title: [Title],
  author: [Author],
  author-url: "https://example.com",
  source-url: "https://example.com",
  license: [License],
  license-url: "https://example.com",
  body
) = {
  grid(
    align: center,
    gutter: 2pt,
    rows: 2,
    body,
    text(size: 10pt, ["#link(source-url, title)" by #link(author-url, author) is licensed under #link(license-url, license)]),
  )
}

= What is involved?

== 802.1X

#side-by-side(
  anim(at: 5, cite(
    title: [802.1X wired protocols],
    author: [Arran Cudbard-Bell],
    author-url: "https://www.linkedin.com/in/arrancudbardbell/",
    source-url: "https://commons.wikimedia.org/wiki/File:802.1X_wired_protocols.png",
    license: [GFDL-1.2],
    license-url: "https://www.gnu.org/licenses/old-licenses/fdl-1.2.html",
    image("/images/8021x.png"),
  )),
  stagger(start: 1)[
    - Port-based Network Access Control
    - *Supplicant*: client device that wants to connect and will provide credentials
    - *Authenticator*: devices that provides data link between client and network (AP, switch)
    - *Authentication Server*: that can tell the authenticator if the client is allowed
  ],
)

== Extensible Authentication Protocol (EAP)

#side-by-side(
  stagger[
    - *EAPOL*: over LAN (WiFi networks? I know!)
    - Authentication _framework_
    - Provides common methods
    - Wrapped in a cryptographic method (EAP-TLS)
  ],
  anim(at: 6, chronos.diagram({
    import chronos: *
    _par("Supplicant")
    _par("Authenticator")

    _seq("Supplicant", "Authenticator", comment: "EAPOL-start")
    _gap()
    _seq("Authenticator", "Supplicant", comment: "EAP-Request/identity")
    _gap()
    _seq("Supplicant", "Authenticator", comment: "EAP-Response/identity")
    _gap()
    _seq("Authenticator", "Supplicant", comment: "EAP-Request/auth")
    _gap()
    _seq("Supplicant", "Authenticator", comment: "EAP-Response/auth")
    _gap()
    _seq("Authenticator", "Supplicant", comment: "EAP-success/failure")
  })),
)

== Remote Authentication Dial-In User Service (RADIUS)

#align(center, cite(
  title: [Drawing Roaming RADIUS],
  author: [Kgrr],
  author-url: "https://commons.wikimedia.org/wiki/User:Kgrr",
  source-url: "https://commons.wikimedia.org/wiki/File:Drawing_Roaming_RADIUS.png",
  license: [CC BY-SA 3.0],
  license-url: "https://creativecommons.org/licenses/by-sa/3.0/deed.en",
  image("/images/roaming.png", height: 66%),
))

#stagger[
  - Authentication, Authorization, and Accounting (AAA)
  - Also allows for _roaming_ (eduroam)
  - Typically integrated with a directory service (Active Directory)
]

= Security Considerations

== WPA2-Enterprise vs WPA3-Enterprise

#side-by-side(
  cite(
    title: [Cybersecurity illustration with padlock, wifi, globe and world map],
    author: [kreatikar],
    author-url: "https://pixabay.com/users/kreatikar-8562930/",
    source-url: "https://pixabay.com/illustrations/security-protection-ssl-password-3406723/",
    license: [Pixabay Content License],
    license-url: "https://pixabay.com/service/license-summary/",
    image("/images/wifi-security.jpg"),
  ),
  stagger[
    - Stricter server certificate enforcement
    - Mandatory Protected Management Frames (PMF)
    - Forward secrecy
  ]
)

== Why don't people use it?

#side-by-side(
  stagger[
    - Not supported by existing infrastructure (RADIUS server, directory server)
    - Not supported by older client devices
    - Not supported by older APs
  ],
  cite(
    title: [Cryptic Wifi Networks],
    author: [Randall Munroe],
    author-url: "https://xkcd.com",
    source-url: "https://xkcd.com/2199/",
    license: [CC BY-NC 2.5],
    license-url: "https://creativecommons.org/licenses/by-nc/2.5/",
    image("/images/cryptic_wifi_networks.png"),
  ),
)

