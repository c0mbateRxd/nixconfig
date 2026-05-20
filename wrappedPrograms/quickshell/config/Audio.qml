import QtQuick
import Quickshell.Services.Pipewire

// Volume — PipeWire default sink via native Quickshell.Services.Pipewire.
// Click to mute/unmute. Scroll to adjust ±5%.
Text {
    id: root

    readonly property var   sink:  Pipewire.defaultAudioSink
    readonly property var   audio: sink?.audio ?? null
    readonly property int   vol:   audio ? Math.round(audio.volume * 100) : 0
    readonly property bool  muted: audio?.muted ?? false

    text: muted ? "󰝟" :
          vol > 65 ? "󰕾 " + vol + "%" :
          vol > 30 ? "󰖀 " + vol + "%" :
                     "󰕿 " + vol + "%"

    color: muted ? Theme.border : Theme.violet
    font { family: Theme.mono; pixelSize: Theme.md }

    MouseArea {
        anchors.fill: parent
        cursorShape:  Qt.PointingHandCursor

        onClicked: {
            if (root.audio) root.audio.muted = !root.audio.muted
        }

        onWheel: wheel => {
            if (!root.audio) return
            const delta = wheel.angleDelta.y > 0 ? 0.05 : -0.05
            root.audio.volume = Math.max(0, Math.min(1.0, root.audio.volume + delta))
        }
    }
}
