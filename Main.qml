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
// - Save and restore of setup (INI)
//
// TODOS and IDEAS
// - Creation of all types of Particle elements (Effectors, Particle Painter, Particle Groups)
// - Export the creation to QML files for use in other applications
// - Add an editor pane (like QmlDesigner does) for each element
// - any other idea that comes to mind while do this (-;

ApplicationWindow {
    id: root

    width: 1200
    height: 600
    visible: true
    title: qsTr("Partical Editor (v1.0) - by Neil Parker")

    header: MainToolBar {
        id: mainToolBar
        onCreateEmitterRequest: {
            shapeEditor.createShape(
                100 + 20 * shapeEditor.shapes.length,
                100 + 20 * shapeEditor.shapes.length,
                "emitter",
                EditableShape.ShapeType.ShapeTypePath)
        }
        onCreateAttractorRequest: {
            shapeEditor.createShape(
                100 + 20 * shapeEditor.shapes.length,
                100 + 20 * shapeEditor.shapes.length,
                "attractor",
                EditableShape.ShapeType.ShapeTypeSpot)
        }
        onLoadRequest: {
            shapeEditor.load()
            sys.load()
        }
        onSaveRequest: {
            shapeEditor.save()
            sys.save()
        }
    }

    ShapeEditor {
        id: shapeEditor
        editing: mainToolBar.editMode
        hidden: mainToolBar.hideMode
    }

    ShapeConfigurator {
        id: shapeConfigurator
        currentShape: shapeEditor.currentShape
        currentParticalItem: sys.currentParticalItem
        show: mainToolBar.configMode
        onRequestClose: mainToolBar.configMode = false
    }

    CustomParticleSystem {
        id: sys
        anchors.fill: parent
        shapeEditor: shapeEditor
        running: mainToolBar.playMode
        z: shapeEditor.z - 100
    }
}
