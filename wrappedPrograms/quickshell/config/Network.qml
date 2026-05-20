import QtQuick
import Quickshell.Io

// Network — shows Wi-Fi SSID or Ethernet interface.
// Uses nmcli Process polling (universally reliable).
// ─────────────────────────────────────────────────────────────────────
// NOTE: Quickshell 0.3 ships a native Quickshell.Networking module.
// If your build includes it, replace this entire file with:
//
//   import QtQuick
//   import Quickshell.Networking
//
//   Row {
//       spacing: 4
//       readonly property var conn: Networking.primaryConnection
//       Text {
//           text: conn ? (conn.type === NetworkingConnectionType.Wireless
//                         ? "󰤨 " + (conn.ssid ?? "Wi-Fi")
//                         : "󰈀 " + (conn.interfaceName ?? "eth"))
//                      : "󰤭"
//           color: conn ? Theme.frost : Theme.ember
//           font { family: Theme.mono; pixelSize: Theme.md }
//       }
//   }
// ─────────────────────────────────────────────────────────────────────

Row {
    spacing: 4

    // Wi-Fi indicator
    Text {
        id: wifiText
        anchors.verticalCenter: parent.verticalCenter
        property string ssid: ""
        visible: ssid.length > 0
        text:  "󰤨 " + ssid
        color: Theme.frost
        font { family: Theme.mono; pixelSize: Theme.md }
    }

    // Ethernet indicator
    Text {
        id: ethText
        anchors.verticalCenter: parent.verticalCenter
        property bool connected: false
        visible: connected && wifiText.ssid.length === 0
        text:  "󰈀 eth"
        color: Theme.moss
        font { family: Theme.mono; pixelSize: Theme.md }
    }

    // Offline fallback
    Text {
        anchors.verticalCenter: parent.verticalCenter
        visible: wifiText.ssid.length === 0 && !ethText.connected
        text:  "󰤭"
        color: Theme.ember
        font { family: Theme.mono; pixelSize: Theme.md }
    }

    // ── nmcli poll every 5 seconds ───────────────────────────
    Process {
        id: wifiProc
        // -t terse, -f fields, dev wifi — find the active Wi-Fi connection
        command: ["sh", "-c",
            "nmcli -t -f ACTIVE,SSID dev wifi 2>/dev/null | awk -F: '/^yes/{print $2; exit}'"]
        stdout: StdioCollector {
            onStreamFinished: wifiText.ssid = this.text.trim()
        }
    }

    Process {
        id: ethProc
        command: ["sh", "-c",
            "nmcli -t -f TYPE,STATE dev 2>/dev/null | grep -c 'ethernet:connected' || echo 0"]
        stdout: StdioCollector {
            onStreamFinished: ethText.connected = parseInt(this.text.trim()) > 0
        }
    }

    Timer {
        interval: 5000; running: true; repeat: true
        onTriggered: {
            if (!wifiProc.running) wifiProc.running = true
            if (!ethProc.running)  ethProc.running  = true
        }
    }

    // Click opens nmtui in kitty for network management
    MouseArea {
        anchors.fill: parent
        cursorShape:  Qt.PointingHandCursor
        onClicked: Quickshell.execDetached(["kitty", "--title", "nmtui", "-e", "nmtui"])
    }

    Component.onCompleted: {
        wifiProc.running = true
        ethProc.running  = true
    }
}
