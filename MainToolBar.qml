import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Icons
// - https://specifications.freedesktop.org/icon-naming-spec/latest/
// - https://doc.qt.io/qt-6/qtquickcontrols-icons.html
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

    RowLayout {
        id: layoutToolBar
        anchors.fill: parent

        RowLayout {
            id: modeButtons
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter

            ToolButton {
                id: editButton
                checked: control.editMode
                text: "Edit"
                icon.name: "edit-cut"
                display: AbstractButton.TextUnderIcon
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
            display: AbstractButton.TextUnderIcon
            icon.name: "document-open"
            onClicked: {
                settingsId.load()
                control.loadRequest()
            }
        }
        ToolButton {
            id: saveButton
            text: "Save"
            display: AbstractButton.TextUnderIcon
            icon.name: "document-save"
            onClicked: {
                settingsId.save()
                control.saveRequest()
            }
        }
        Item { id: spacer; Layout.fillWidth: true }
        ToolButton {
            text: "Qt"
            onClicked: Qt.openUrlExternally("https://www.qt.io/qt-licensing")
        }

        // Put this inside the layout to ensure layouting of ToolBar works
        // Bundle the settings
        SettingHelper {
            id: settingsId
            target: control
            saveProperties: ["editMode", "showMode", "hideMode", "playMode"]
        }
    }

    Component.onCompleted: settingsId.load()
    Component.onDestruction: settingsId.save()

}
