pragma Singleton
import QtQuick
import Quickshell.Io

// Niri IPC — polls workspace state every 500ms.
// Pure-QML approach: no C++ plugin needed.
QtObject {
    id: root

    // Reactive workspace list — bind to these from Workspaces.qml
    property var workspaces: []   // [{id, idx, name, is_focused, ...}]
    property int activeId:   -1   // focused workspace id

    // Send a focus action by workspace name ("I", "II", etc.)
    function focusWorkspace(name) {
        actionProc.command = ["niri", "msg", "action", "focus-workspace", name]
        actionProc.running = true
    }

    // ── Poll every 500ms ─────────────────────────────────────
    Process {
        id: pollProc
        command: ["niri", "msg", "--json", "workspaces"]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const ws = JSON.parse(this.text)
                    root.workspaces = ws
                    for (let i = 0; i < ws.length; i++) {
                        if (ws[i].is_focused) {
                            root.activeId = ws[i].id
                            break
                        }
                    }
                } catch (_) {}
            }
        }
    }

    // One-shot action process (focus workspace on click)
    Process { id: actionProc }

    Timer {
        interval: 500
        running:  true
        repeat:   true
        onTriggered: { if (!pollProc.running) pollProc.running = true }
    }
}
