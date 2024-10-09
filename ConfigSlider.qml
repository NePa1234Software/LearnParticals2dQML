import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: control

    property Item currentParticalItem: null

    implicitWidth: configLayout.implicitWidth
    implicitHeight: configLayout.implicitHeight

    ColumnLayout {
        id: configLayout
        anchors.fill: parent
        property real currentValue
        Label {
            id: configLabel
            Layout.fillWidth: true
            text: "%1 : %2".arg(model.property).arg(configLayout.currentValue)
        }
        Slider {
            id: configSlider
            Layout.fillWidth: true
            from: model.from ?? 0
            to: model.to ?? 1000
            value: configLayout.currentValue ?? 0
            stepSize: model.stepSize ?? 0
            onMoved: {
                configLayout.currentValue = configSlider.value
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
