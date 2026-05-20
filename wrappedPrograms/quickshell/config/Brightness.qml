import QtQuick
import Quickshell.Io

// Brightness — reads brightnessctl on startup + after each change.
// No polling timer. Scroll to adjust ±5%.
Text {
    id: root
    property int pct: 100

    text:  pct > 66 ? "󰃠 " + pct + "%" :
           pct > 33 ? "󰃟 " + pct + "%" :
                      "󰃞 " + pct + "%"

    color: Theme.dimText
    font { family: Theme.mono; pixelSize: Theme.md }

    // Read current brightness once
    Process {
        id: readProc
        command: ["sh", "-c",
            "echo $(( $(brightnessctl get) * 100 / $(brightnessctl max) ))"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.pct = parseInt(this.text.trim()) || 100
        }
    }

    // Adjust brightness on scroll, then re-read
    Process {
        id: setProc
        stdout: StdioCollector {
            onStreamFinished: { if (!readProc.running) readProc.running = true }
        }
    }

    MouseArea {
        anchors.fill: parent
        onWheel: wheel => {
            const dir = wheel.angleDelta.y > 0 ? "+5%" : "5%-"
            setProc.command = ["brightnessctl", "--class=backlight", "set", dir]
            if (!setProc.running) setProc.running = true
        }
    }
}
