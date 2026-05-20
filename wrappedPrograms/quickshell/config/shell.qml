import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Mpris

ShellRoot {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData

            anchors { top: true; left: true; right: true }
            implicitHeight: 36
            exclusiveZone:  36
            color: "transparent"  // outer window is fully transparent

            // ── Left pill: NixOS logo + workspace numerals ─────
            Rectangle {
                id: leftPill
                anchors {
                    left:           parent.left
                    leftMargin:     8
                    verticalCenter: parent.verticalCenter
                }
                height: 26
                width:  leftRow.implicitWidth + 20
                color:  Theme.surface
                radius: 8

                // Subtle Bonfire Gold top hairline
                Rectangle {
                    anchors { top: parent.top; left: parent.left; right: parent.right }
                    height: 1; radius: 8
                    color: "#22c49a30"
                }

                Row {
                    id: leftRow
                    anchors.centerIn: parent
                    spacing: 6

                    // NixOS snowflake logo
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text:  ""                  // nf-linux-nixos
                        color: Theme.frost
                        font { family: Theme.mono; pixelSize: Theme.md }
                    }

                    // Divider
                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 1; height: 14
                        color: Theme.border
                    }

                    Workspaces { anchors.verticalCenter: parent.verticalCenter }
                }
            }

            // ── Center pill: MPRIS media + clock ──────────────
            Rectangle {
                id: centerPill
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter:   parent.verticalCenter
                }
                height: 26
                width:  centerRow.implicitWidth + 20
                color:  Theme.surface
                radius: 8

                Rectangle {
                    anchors { top: parent.top; left: parent.left; right: parent.right }
                    height: 1; radius: 8
                    color: "#22c49a30"
                }

                Row {
                    id: centerRow
                    anchors.centerIn: parent
                    spacing: 8

                    // Media widget (hidden when nothing plays)
                    Media { anchors.verticalCenter: parent.verticalCenter }

                    // Divider — only visible when media is playing
                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width:   1
                        height:  14
                        color:   Theme.border
                        visible: Mpris.players.length > 0
                    }

                    Clock { anchors.verticalCenter: parent.verticalCenter }
                }
            }

            // ── Right pill: hardware stats + system tray ───────
            Rectangle {
                id: rightPill
                anchors {
                    right:          parent.right
                    rightMargin:    8
                    verticalCenter: parent.verticalCenter
                }
                height: 26
                width:  rightRow.implicitWidth + 20
                color:  Theme.surface
                radius: 8

                Rectangle {
                    anchors { top: parent.top; left: parent.left; right: parent.right }
                    height: 1; radius: 8
                    color: "#22c49a30"
                }

                Row {
                    id: rightRow
                    anchors.centerIn: parent
                    spacing: 8

                    Hardware { anchors.verticalCenter: parent.verticalCenter }

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 1; height: 14; color: Theme.border
                    }

                    Audio      { anchors.verticalCenter: parent.verticalCenter }
                    Network    { anchors.verticalCenter: parent.verticalCenter }
                    Bluetooth  { anchors.verticalCenter: parent.verticalCenter }
                    Brightness { anchors.verticalCenter: parent.verticalCenter }
                    Battery    { anchors.verticalCenter: parent.verticalCenter }

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: 1; height: 14; color: Theme.border
                    }

                    PowerMenu  { anchors.verticalCenter: parent.verticalCenter }
                }
            }
        }
    }
}
