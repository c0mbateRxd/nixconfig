import QtQuick

// Clock — "Fri 20 May  11:45 PM"
// Date in Faded Rune, time in Pale Ash. Matches original waybar format.
Row {
    spacing: 6

    property var _now: new Date()

    Text {
        anchors.verticalCenter: parent.verticalCenter
        text:  Qt.formatDate(parent._now, "ddd dd MMM")
        color: Theme.dimText
        font { family: Theme.ui; pixelSize: Theme.sm }
    }

    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        width: 1; height: 12
        color: Theme.border
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        text:  Qt.formatTime(parent._now, "hh:mm AP")
        color: Theme.text
        font { family: Theme.ui; pixelSize: Theme.md; bold: true }
    }

    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: parent._now = new Date()
    }
}
