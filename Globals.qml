pragma Singleton
import QtQuick

Item {
    id: control

    property real cornerRadius: 10

    // The current shape/particle object selected
    property int currentSelection: -1
    onCurrentSelectionChanged: console.log("currentSelection: ", control.currentSelection)
}
