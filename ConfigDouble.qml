import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: control

    property Item currentParticalItem: null

    implicitWidth: configLayout.implicitWidth
    implicitHeight: configLayout.implicitHeight
    objectName: "ConfigDouble"

    ColumnLayout {
        id: configLayout
        property real currentValue
        anchors.fill: parent
        anchors.margins: 5
        Label {
            id: configLabel
            Layout.fillWidth: true
            text: "%1 : %2".arg(model.property).arg(configLayout.currentValue)
        }
        TextField {
            id: configField
            Layout.fillWidth: true
            validator: DoubleValidator{bottom: model.from; top: model.to;}
            text: "%1".arg(configLayout.currentValue ?? "")
            color: configField.acceptableInput ? "black" : "red"
            background: null
            onAccepted: {
                configLayout.currentValue = configField.text
                PropertyIntrospection.writeProperty(control.currentParticalItem, model.property, configLayout.currentValue)
            }
        }
        Component.onCompleted: configLayout.currentValue = PropertyIntrospection.readProperty(control.currentParticalItem, model.property)
    }
    Rectangle {
        anchors.fill: parent
        border.color: "navy"
        color: "transparent"
    }
}
