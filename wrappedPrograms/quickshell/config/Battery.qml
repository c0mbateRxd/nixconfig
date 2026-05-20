import QtQuick
import Quickshell.Services.UPower

// Battery — UPower display device.
// Moss on Ruins (good) → Bonfire Gold (medium) → Blood Ember (low)
Text {
    readonly property var bat: UPower.displayDevice
    readonly property int pct: bat ? Math.round(bat.percentage) : 0

    readonly property string icon: {
        if (!bat) return "󰂑"
        if (bat.state === UPowerDeviceState.Charging ||
            bat.state === UPowerDeviceState.FullyCharged) return "󰂄"
        if (pct > 90) return "󰁹"
        if (pct > 70) return "󰂂"
        if (pct > 50) return "󰂀"
        if (pct > 30) return "󰁾"
        if (pct > 15) return "󰁻"
        return "󰁺"
    }

    text:  icon + " " + pct + "%"
    color: bat?.state === UPowerDeviceState.Charging ? Theme.moss  :
           pct > 50                                  ? Theme.moss   :
           pct > 25                                  ? Theme.bonfire:
                                                       Theme.ember

    font { family: Theme.mono; pixelSize: Theme.md }
}
