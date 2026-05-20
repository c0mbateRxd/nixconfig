pragma Singleton
import QtQuick
import Quickshell.Io

// Hardware monitor — CPU usage, RAM usage, CPU temperature.
// One sh process every 2 seconds. No external daemons.
// k10temp auto-detected by scanning /sys/class/hwmon/*/name.
QtObject {
    id: root

    property int cpuPct: 0   // 0–100
    property int ramPct: 0   // 0–100
    property int tempC:  0   // degrees Celsius

    // CPU delta state — need two samples to compute usage
    property real _prevTotal: 0
    property real _prevIdle:  0

    // Single shell command outputs one JSON line:
    // {"total":N,"idle":N,"mt":N,"ma":N,"t":N}
    // total/idle = cumulative CPU jiffies, mt/ma = mem kB, t = temp millicelsius
    readonly property string _hwCmd: '
read cpu u n s i iw irq soft steal < /proc/stat
total=$((u+n+s+i+iw+irq+soft+steal))
idle=$((i+iw))
mt=$(awk "/MemTotal:/{print \\$2}" /proc/meminfo)
ma=$(awk "/MemAvailable:/{print \\$2}" /proc/meminfo)
t=0
for h in /sys/class/hwmon/hwmon*; do
  if [ "$(cat "$h/name" 2>/dev/null)" = "k10temp" ]; then
    t=$(cat "$h/temp1_input" 2>/dev/null || echo 0)
    break
  fi
done
printf "{\"total\":%d,\"idle\":%d,\"mt\":%d,\"ma\":%d,\"t\":%d}\\n" $total $idle $mt $ma $t
'

    Process {
        id: hwProc
        command: ["sh", "-c", root._hwCmd]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const d = JSON.parse(this.text.trim())

                    // CPU delta (two-sample method)
                    if (root._prevTotal > 0) {
                        const dt = d.total - root._prevTotal
                        const di = d.idle  - root._prevIdle
                        root.cpuPct = dt > 0 ? Math.max(0, Math.round(100 * (1 - di / dt))) : 0
                    }
                    root._prevTotal = d.total
                    root._prevIdle  = d.idle

                    // RAM
                    root.ramPct = d.mt > 0 ? Math.round(100 * (d.mt - d.ma) / d.mt) : 0

                    // Temperature (millicelsius → celsius)
                    root.tempC = Math.round(d.t / 1000)
                } catch (_) {}
            }
        }
    }

    Timer {
        interval: 2000
        running:  true
        repeat:   true
        onTriggered: { if (!hwProc.running) hwProc.running = true }
    }

    // First sample immediately on startup
    Component.onCompleted: hwProc.running = true
}
