pragma Singleton
import QtQuick

// Ashen Keep — Dark Souls / gothic steampunk palette
// Every widget imports this. Change here → changes everywhere.
QtObject {
    // ── Backgrounds ───────────────────────────────────────────
    readonly property color bg:       "#0a0b0e"  // Abyss         (deepest)
    readonly property color surface:  "#12141a"  // Cinder        (pill bg)
    readonly property color elevated: "#1c1f28"  // Dark Ash      (hover, selection)
    readonly property color border:   "#2c3040"  // Grave Iron    (separators)

    // ── Text ──────────────────────────────────────────────────
    readonly property color dimText:  "#6a7088"  // Faded Rune    (inactive, hints)
    readonly property color text:     "#b0b8c8"  // Pale Ash      (default)
    readonly property color bright:   "#c8d0e0"  // Moonstone     (titles)

    // ── Accents ───────────────────────────────────────────────
    readonly property color bonfire:  "#c49a30"  // Bonfire Gold  (active, hero)
    readonly property color ember:    "#a83a3a"  // Blood Ember   (errors, power)
    readonly property color moss:     "#5a8a58"  // Moss on Ruins (success, good)
    readonly property color frost:    "#4a7e96"  // Frigid Steel  (NixOS, Wi-Fi)
    readonly property color lothric:  "#6070a8"  // Lothric Blue  (BT, links)
    readonly property color violet:   "#7a5090"  // Phantom Violet (media, audio)

    // ── Typography ────────────────────────────────────────────
    readonly property string mono:  "JetBrainsMono Nerd Font"
    readonly property string ui:    "Inter"
    readonly property string title: "Cinzel"   // Roman numerals

    readonly property int sm: 11
    readonly property int md: 12
    readonly property int lg: 13
}
