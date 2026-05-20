import QtQuick

// Hardware stats — reads from HardwareService singleton.
// Format: "CPU 23% · RAM 54% · 48°C"
// Color shifts on high load: normal → Bonfire Gold → Blood Ember
Row {
    spacing: 4

    // CPU
    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: "CPU " + HardwareService.cpuPct + "%"
        color: HardwareService.cpuPct > 80 ? Theme.ember  :
               HardwareService.cpuPct > 50 ? Theme.bonfire :
                                             Theme.dimText
        font { family: Theme.mono; pixelSize: Theme.sm }
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: "·"; color: Theme.border
        font { family: Theme.mono; pixelSize: Theme.sm }
    }

    // RAM
    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: "RAM " + HardwareService.ramPct + "%"
        color: HardwareService.ramPct > 85 ? Theme.ember  :
               HardwareService.ramPct > 60 ? Theme.bonfire :
                                             Theme.dimText
        font { family: Theme.mono; pixelSize: Theme.sm }
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: "·"; color: Theme.border
        font { family: Theme.mono; pixelSize: Theme.sm }
    }

    // Temperature
    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: HardwareService.tempC + "°C"
        color: HardwareService.tempC > 85 ? Theme.ember   :
               HardwareService.tempC > 70 ? Theme.bonfire :
                                            Theme.dimText
        font { family: Theme.mono; pixelSize: Theme.sm }
    }
}
