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
        anchors.margins: 5
        CustomButton {
            text: ">"
            onClicked: control.requestClose()
        }

        LabelConfigSection {
            id: sectionId
            text: "Property configuration"
            Layout.fillWidth: true
            Layout.preferredHeight: sectionId.implicitHeight
        }

        Label {
            id: configItemLabel
            text: control.currentShape ? control.currentShape.objectName : "non selected..."
        }
        Label {
            id: configParticalItemLabel
            text: control.currentParticalItem ? control.currentParticalItem.objectName : ""
        }

        // propertyValues is a ListModel
        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: control.show && control.currentParticalItem ? control.currentParticalItem.propertyValues : null
            section.property: "group"
            section.criteria: ViewSection.FullString
            section.delegate: LabelConfigSection {
                id: sectionId
                required property string section
                width: ListView.view.width
                height: sectionId.implicitHeight
                text: sectionId.section
            }
            delegate: DelegateChooser {
                role: "type"
                DelegateChoice {
                    roleValue: "Slider";
                    ConfigSlider {
                        currentParticalItem: control.currentParticalItem;
                        width: ListView.view.width
                    }
                }
                DelegateChoice {
                    roleValue: "TextDouble";
                    ConfigDouble {
                        currentParticalItem: control.currentParticalItem;
                        width: ListView.view.width
                    }
                }
            }
        }
    }
}
