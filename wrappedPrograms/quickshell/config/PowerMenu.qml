import QtQuick

// Power button — launches wlogout (shutdown/reboot/logout/hibernate)
Text {
    text:  "⏻"
    color: Theme.ember
    font { family: Theme.mono; pixelSize: Theme.lg }

    MouseArea {
        anchors.fill: parent
        cursorShape:  Qt.PointingHandCursor
        onClicked: Quickshell.execDetached(["wlogout", "-b", "2"])
    }
}
