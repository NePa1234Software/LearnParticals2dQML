import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Icons
// - https://specifications.freedesktop.org/icon-naming-spec/latest/
// - https://doc.qt.io/qt-6/qtquickcontrols-icons.html
// - http://flying-sheep.github.io/freedesktop-icons/
// - https://openapplibrary.org/dev-tutorials/qt-icon-themes
ToolBar {
    id: control
    objectName: "MainToolBar"

    property bool editMode: false
    property bool showMode: false
    property bool hideMode: false
    property bool playMode: false
    property bool configMode: false

    signal createEmitterRequest()
    signal createAttractorRequest()

    signal loadRequest()
    signal saveRequest()

    RowLayout {
        id: layoutToolBar
        anchors.fill: parent

        property int display: AbstractButton.TextUnderIcon


        RowLayout {
            id: modeButtons
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignVCenter

            ToolButton {
                id: editButton
                checked: control.editMode
                text: "Edit"
                icon.name: "edit-cut"
                display: layoutToolBar.display
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
                display: layoutToolBar.display
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
                display: layoutToolBar.display
                onClicked: {
                    control.editMode = false
                    control.showMode = false
                    control.hideMode = true
                }
            }
        }

        /////////////////////////////////////

        ToolSeparator {}

        ToolButton {
            id: playButton
            checked: control.playMode
            text: "Play"
            icon.name: "media-playback-start"
            display: layoutToolBar.display
            onClicked: control.playMode = !control.playMode
        }
        ToolSeparator {}
        ToolButton {
            id: createButton
            text: "New Emitter"
            icon.name: "list-add"
            display: layoutToolBar.display
            onClicked: control.createEmitterRequest()
        }
        ToolButton {
            id: createAttractorButton
            text: "New Attractor"            
            icon.name: "list-add"
            display: layoutToolBar.display
            onClicked: control.createAttractorRequest()
        }

        /////////////////////////////////////

        ToolSeparator {}
        ToolButton {
            id: configButton
            text: "Properties"
            checked: control.configMode
            icon.name: "document-properties"
            display: layoutToolBar.display
            onClicked: control.configMode = !control.configMode
        }

        /////////////////////////////////////

        ToolSeparator {}
        ToolButton {
            id: loadButton
            text: "Load"
            icon.name: "document-open"
            display: layoutToolBar.display
            onClicked: {
                settingsId.load()
                control.loadRequest()
            }
        }
        ToolButton {
            id: saveButton
            text: "Save"
            icon.name: "document-save"
            display: layoutToolBar.display
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
