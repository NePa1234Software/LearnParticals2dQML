import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.qmlmodels

import LearnParticles2dQML

Drawer {
    id: control

    property EditableShape currentShape: null
    property Item currentParticalItem: null
    property bool show: false
    objectName: "ShapeConfigurator"
    width: Math.min(parent.width * 0.3, 200)
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
        objectName: "ShapeConfiguratorLayout"
        anchors.fill: parent
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

        // propertyValues is a ListModel
        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: control.show && control.currentParticalItem ? control.currentParticalItem.propertyValues : null
            delegate: DelegateChooser {
                role: "type"
                DelegateChoice { roleValue: "Slider"; ConfigSlider { currentParticalItem: control.currentParticalItem; width: ListView.view.width } }
            }
        }
    }
}
