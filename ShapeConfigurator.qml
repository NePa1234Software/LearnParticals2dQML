import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import LearnParticles2dQML

Drawer {
    id: control

    property EditableShape currentShape: null
    property Item currentParticalItem: null
    property bool show: false
    objectName: "ShapeConfigurator"
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
        objectName: "ShapeConfiguratorLayout"
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

        // Example
        // property var propertyValues: { "emitRate": { "type": "Slider", "from": 1, "to": 10000, "value": 10} }
        // property binding on "value" does not work - https://doc.qt.io/qt-6/qml-var.html#change-notification-semantics
        Repeater {
            model: control.show && control.currentParticalItem ? Object.keys(control.currentParticalItem.propertyValues) : null
            delegate: ColumnLayout {
                id: configLayout
                Layout.fillWidth: true
                property real currentValue
                Label {
                    id: configLabel
                    Layout.fillWidth: true
                    text: "%1 : %2".arg(modelData).arg(configLayout.currentValue)
                }
                Slider {
                    id: configSlider
                    Layout.fillWidth: true
                    from: control.currentParticalItem.propertyValues[modelData].from ?? 0
                    to: control.currentParticalItem.propertyValues[modelData].to ?? 1000
                    value: configLayout.currentValue ?? 0
                    stepSize: control.currentParticalItem.propertyValues[modelData].stepSize ?? 0
                    onMoved: {
                        configLayout.currentValue = configSlider.value
                        PropertyIntrospection.writeProperty(control.currentParticalItem, modelData, configLayout.currentValue)
                    }
                }
                Component.onCompleted: configLayout.currentValue = PropertyIntrospection.readProperty(control.currentParticalItem, modelData)
            }
        }
    }
}
