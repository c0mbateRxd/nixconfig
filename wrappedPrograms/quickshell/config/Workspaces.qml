import QtQuick
import QtQuick.Layouts

// Workspace pills — Roman numerals sourced from NiriService.
// Active workspace: Bonfire Gold text + Dark Ash bg + left accent bar.
// Inactive: Grave Iron text, transparent bg.
Row {
    spacing: 2

    Repeater {
        // We always show 5 workspaces (named I–V in niri config).
        // Map idx 0–4 to Roman numerals.
        model: ["I", "II", "III", "IV", "V"]

        Rectangle {
            required property string modelData  // "I", "II", etc.
            required property int    index

            // Match against NiriService workspace list by name
            readonly property bool isActive: {
                for (let i = 0; i < NiriService.workspaces.length; i++) {
                    if (NiriService.workspaces[i].name === modelData
                        && NiriService.workspaces[i].is_focused)
                        return true
                }
                return false
            }

            property bool hovered: false

            implicitWidth:  label.implicitWidth + 14
            implicitHeight: 20
            radius: 4
            color: isActive  ? Theme.elevated :
                   hovered   ? "#0dffffff"    :
                               "transparent"

            // Left accent bar on active workspace
            Rectangle {
                visible: parent.isActive
                anchors { left: parent.left; top: parent.top; bottom: parent.bottom }
                width: 2; radius: 1
                color: Theme.bonfire
            }

            Text {
                id: label
                anchors.centerIn: parent
                text:  parent.modelData
                color: parent.isActive  ? Theme.bonfire :
                       parent.hovered   ? Theme.text    :
                                          Theme.border
                font {
                    family:    Theme.title   // Cinzel
                    pixelSize: Theme.sm
                    bold:      parent.isActive
                    letterSpacing: 0.5
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape:  Qt.PointingHandCursor
                onEntered:    parent.hovered = true
                onExited:     parent.hovered = false
                onClicked:    NiriService.focusWorkspace(parent.modelData)
            }
        }
    }
}
