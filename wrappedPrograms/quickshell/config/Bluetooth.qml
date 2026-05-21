import QtQuick
import Quickshell.Services.Bluetooth

// Bluetooth — native Quickshell.Bluetooth service.
// Connected: Lothric Blue + device count.
// Idle: Grave Iron.
// Click → blueman-manager.
Text {
    readonly property int n: {
        let count = 0
        for (let i = 0; i < Bluetooth.devices.length; i++) {
            if (Bluetooth.devices[i].connected) count++
        }
        return count
    }

    text:  n > 0       ? "󰂱 " + n    :
           Bluetooth.enabled ? "󰂯"       :
                               "󰂲"

    color: n > 0       ? Theme.lothric :
           Bluetooth.enabled ? Theme.border  :
                               Theme.border

    font { family: Theme.mono; pixelSize: Theme.md }

    MouseArea {
        anchors.fill: parent
        cursorShape:  Qt.PointingHandCursor
        onClicked: Quickshell.execDetached(["blueman-manager"])
    }
}
