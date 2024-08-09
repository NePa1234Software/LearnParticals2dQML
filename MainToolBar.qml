import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ToolBar {
    id: control
    objectName: "MainToolBar"

    property bool editMode: false
    property bool showMode: false
    property bool hideMode: false
    property bool playMode: false

    signal createEmitterRequest()
    signal createAttractorRequest()

    signal loadRequest()
    signal saveRequest()

    // Bundle the settings
    SettingHelper {
        id: settingsId
        target: control
        saveProperties: ["editMode", "showMode", "hideMode", "playMode"]
    }

    RowLayout {
        anchors.fill: parent

        RowLayout {
            id: modeButtons
            ToolButton {
                id: editButton
                checked: control.editMode
                text: "Edit"
                onClicked: {
                    control.editMode = true
                    control.showMode = false
                    control.hideMode = false
                }
            }
            ToolButton {
                id: showButton
                checked: control.showMode
                text: "Show"
                onClicked: {
                    control.editMode = false
                    control.showMode = true
                    control.hideMode = false
                }
            }
            ToolButton {
                id: hideButton
                checked: control.hideMode
                text: "Hide"
                onClicked: {
                    control.editMode = false
                    control.showMode = false
                    control.hideMode = true
                }
            }
        }

        ToolSeparator {}

        ToolButton {
            id: playButton
            checked: control.playMode
            text: "Play"
            onClicked: control.playMode = !control.playMode
        }
        ToolSeparator {}
        ToolButton {
            id: createButton
            text: "New Emitter"
            onClicked: control.createEmitterRequest()
        }
        ToolButton {
            id: createAttractorButton
            text: "New Attractor"
            onClicked: control.createAttractorRequest()
        }
        ToolSeparator {}
        ToolButton {
            id: loadButton
            text: "Load"
            onClicked: {
                settingsId.load()
                control.loadRequest()
            }
        }
        ToolButton {
            id: saveButton
            text: "Save"
            onClicked: {
                settingsId.save()
                control.saveRequest()
            }
        }
        Item { id: spacer; Layout.fillWidth: true }
        Label { text: "Qt" }
    }

    Component.onCompleted: settingsId.load()
    Component.onDestruction: settingsId.save()

}
