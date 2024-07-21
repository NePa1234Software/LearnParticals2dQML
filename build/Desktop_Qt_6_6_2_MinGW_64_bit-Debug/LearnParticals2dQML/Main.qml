import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Particles

// Particle editor will allow you to create your particles interactively.
//
// This is a work in progress application purely for learning the Qt particle system
// and a few other things that I have been wanting to practive, like Shapes and user
// interaction with the UI controls.
//
// FEATURES (Progress)
// - Create any number of emitters and edit there shape (ShapePath) and position on the screen
// - Hide the editor function and shapes to see the final ShaderEffect
//
// TODOS
// - Creation of all types of Particle elements (Effectors, Particle Painter, Particle Groups)
// - Save and restore of setup (JSON?)
// - Export the creation to QML files for use in other applications
// - Add an editor pane (like QmlDesigner does) for each element
// - any other idea that comes to mind while do this (-;

Window {
    id: root

    width: 640
    height: 480
    visible: true
    title: qsTr("Partical Editor (v1.0) - by Neil Parker")

    QtObject {
        id: priv

        property list<EditableShape> shapes

        function createEmitterShape(posX : real, posY : real ) {
            var newShape = componentEditableShape.createObject(root, { x: posX, y: posY })
            if (!newShape) {
                console.error("creation failed")
            } else {
                priv.shapes.push(newShape)
            }
        }
    }

    Component {
        id: componentEditableShape

        EditableShape {
            id: editabelShape
            editing: editButton.checked
            hidden: hideButton.checked
            onRequestShapeMove: (positionNew) => {
                editabelShape.x = positionNew.x
                editabelShape.y = positionNew.y
            }
        }
    }

    RowLayout {
        Button {
            id: editButton
            checkable: true
            text: checked ? "Normal mode" : "Edit mode"
        }
        Button {
            id: createButton
            text: "Create Emitter"
            onClicked: priv.createEmitterShape(
                           100 + 20 * priv.shapes.length,
                           100 + 20 * priv.shapes.length)
        }
        Button {
            id: hideButton
            text: !checked ? "Hide Emitter" : "Show Emitter"
            checkable: true
        }
    }

    ParticleSystem {
        id: sys
        anchors.fill: parent
    }

    Repeater {
        model: priv.shapes.length
        delegate: Emitter {
            id: emitter
            property real pathPosPercent: 0.0
            property point pathPosition: priv.shapes[index].pointAtPercent(emitter.pathPosPercent)
            NumberAnimation on pathPosPercent { from: 0; to: 1.0; duration: 210; loops: Animation.Infinite; running: true }

            group: "stars"
            emitRate: 20
            lifeSpan: 1000
            size: 50
            sizeVariation: 5
            system: sys
            x: priv.shapes[index].x + emitter.pathPosition.x
            y: priv.shapes[index].y + emitter.pathPosition.y
        }
    }

    ImageParticle {
        groups: ["stars"]
        source: "qrc:///particleresources/star.png"
        system: sys
        anchors.fill: parent
        color: "orange"
    }
}
