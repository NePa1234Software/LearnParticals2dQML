import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Drawer {
    id: control

    property EditableShape currentShape: null
    property Item currentParticalItem: null
    property bool show: false
    width: parent.width * 0.3
    height: parent.height
    edge: Qt.RightEdge
    interactive: false
    dim: false
    closePolicy: Popup.NoAutoClose
    modal: false

    signal requestClose()

    onShowChanged: {
        if (control.show)
            control.open()
        else
            control.close()
    }

    background: Rectangle {
        color: "lightblue"
        topLeftRadius: 10
        bottomLeftRadius: 10
    }

    ColumnLayout {
        CustomButton {
            text: ">"
            onClicked: control.requestClose()
        }

        Label {
            id: configItemLabel
            text: control.currentShape ? control.currentShape.objectName : "Select..."
        }
        Label {
            id: configParticalItemLabel
            text: control.currentParticalItem ? control.currentParticalItem.objectName : "Select..."
        }
        Label {
            id: editableValues
            text: control.currentParticalItem ? Object.keys(control.currentParticalItem.propertyValues).length ?? "No properties..." : "Select..."
        }
    }
}
