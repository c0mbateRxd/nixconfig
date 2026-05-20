import QtQuick
import Quickshell.Services.Mpris

// MPRIS media widget — shows playing track + artist.
// Priority: most recently active playing player.
// Collapses (width=0, visible=false) when nothing is playing.
// Cider (Apple Music) takes priority over Vesktop voice.
Row {
    spacing: 5

    // Select the active player — prefer Playing state, then most recent
    readonly property var player: {
        const players = Mpris.players
        if (!players || players.length === 0) return null
        // First pass: find a Playing player (prefer Cider by checking desktopEntry)
        for (let i = 0; i < players.length; i++) {
            const p = players[i]
            if (p.playbackState === MprisPlaybackState.Playing) {
                return p
            }
        }
        // No one is playing — return null (widget collapses)
        return null
    }

    visible: player !== null
    // Implicit width collapses to 0 when invisible, shrinking the center pill
    implicitWidth: visible ? (icon.implicitWidth + trackText.implicitWidth + spacing) : 0

    // ── Play/pause icon ───────────────────────────────────────
    Text {
        id: icon
        anchors.verticalCenter: parent.verticalCenter
        text:  parent.player
                 ? (parent.player.playbackState === MprisPlaybackState.Playing ? "󰐊" : "󰏤")
                 : ""
        color: Theme.violet
        font { family: Theme.mono; pixelSize: Theme.md }

        MouseArea {
            anchors.fill: parent
            cursorShape:  Qt.PointingHandCursor
            onClicked: {
                if (parent.parent.player) parent.parent.player.togglePlaying()
            }
        }
    }

    // ── Track — Artist ────────────────────────────────────────
    Text {
        id: trackText
        anchors.verticalCenter: parent.verticalCenter
        readonly property string title:  parent.parent.player?.trackTitle  || ""
        readonly property string artist: parent.parent.player?.trackArtist || ""
        text: artist.length > 0 ? (title + " — " + artist) : title
        color: Theme.text
        font { family: Theme.ui; pixelSize: Theme.sm }
        // Hard cap so very long titles don't explode the pill width
        width: Math.min(implicitWidth, 220)
        elide: Text.ElideRight

        MouseArea {
            anchors.fill: parent
            cursorShape:  Qt.PointingHandCursor
            onClicked: {
                // Next track on click
                const p = parent.parent.parent.player
                if (p && p.canGoNext) p.next()
            }
        }
    }
}
