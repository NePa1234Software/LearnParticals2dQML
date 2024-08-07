import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Particle editor will allow you to create your particles interactively.
//
// This is a work in progress application purely for learning the Qt particle system
// and a few other things that I have been wanting to practice, like Shapes and user
// interaction with the UI controls.
//
// FEATURES (Progress)
// - Create any number of emitters and edit there shape (ShapePath) and position on the screen
// - Hide the editor function and shapes to see the final ShaderEffect
//
// TODOS and IDEAS
// - Creation of all types of Particle elements (Effectors, Particle Painter, Particle Groups)
// - Save and restore of setup (JSON?)
// - Export the creation to QML files for use in other applications
// - Add an editor pane (like QmlDesigner does) for each element
// - any other idea that comes to mind while do this (-;

ApplicationWindow {
    id: root

    width: 640
    height: 480
    visible: true
    title: qsTr("Partical Editor (v1.0) - by Neil Parker")

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            ButtonGroup {
                buttons: modeButtons.children
            }

            RowLayout {
                id: modeButtons
                ToolButton {
                    id: editButton
                    checked: true
                    checkable: true
                    text: "Edit"
                }
                ToolButton {
                    id: showButton
                    checkable: true
                    text: "Show"
                }
                ToolButton {
                    id: hideButton
                    checkable: true
                    text: "Hide"
                }
            }

            ToolSeparator {}

            ToolButton {
                id: playButton
                checkable: true
                text: "Play"
            }
            ToolSeparator {}
            ToolButton {
                id: createButton
                text: "New Emitter"
                onClicked: shapeEditor.createShape(
                               100 + 20 * shapeEditor.shapes.length,
                               100 + 20 * shapeEditor.shapes.length,
                               "emitter",
                               EditableShape.ShapeType.ShapeTypePath)
            }
            ToolButton {
                id: createAttractorButton
                text: "New Attractor"
                onClicked: shapeEditor.createShape(
                               100 + 20 * shapeEditor.shapes.length,
                               100 + 20 * shapeEditor.shapes.length,
                               "attractor",
                               EditableShape.ShapeType.ShapeTypeSpot)
            }
            ToolSeparator {}
            ToolButton {
                id: loadButton
                text: "Load"
                onClicked: shapeEditor.load()
            }
            ToolButton {
                id: saveButton
                text: "Save"
                onClicked: shapeEditor.save()
            }
            Item { Layout.fillWidth: true }
            Label { text: "Qt" }
        }
    }

    ShapeEditor {
        id: shapeEditor
        editing: editButton.checked
        hidden: hideButton.checked
    }

    CustomParticleSystem {
        id: sys
        anchors.fill: parent
        shapes: shapeEditor.shapes
        running: playButton.checked
    }
}
