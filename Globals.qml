pragma Singleton
import QtQuick

Item {
    id: control

    // The current shape/particle object selected
    property int currentSelection: -1
    onCurrentSelectionChanged: console.log("currentSelection: ", control.currentSelection)
}
