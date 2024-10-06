import QtQuick
import QtQuick.Particles

Item {
    id: control

    objectName: "Emitter_" + control.editableShape.shapeIndex

    property EditableShape editableShape
    property ParticleSystem system

    readonly property bool isFactory: true
    readonly property Item item: emitterLoaderPath.item || emitterLoaderShape.item
    property var propertyValues: {
        "emitRate": { "type": "Slider", "from": 1, "to": 1000, "stepSize": 0.1},
        "lifeSpan": { "type": "Slider", "from": 0, "to": 600000, "stepSize": 10}
    }
    property list<string> saveProperties: [ "emitRate", "lifeSpan" ]

    function save() {
        control.item?.save()
    }
    function load() {
        control.item?.load()
    }

    Loader {
        id: emitterLoaderPath
        active: control.editableShape.shapeType === EditableShape.ShapeType.ShapeTypePath

        sourceComponent: CustomEmitterPath {
            editableShape: control.editableShape
            system: control.system
            propertyValues: control.propertyValues
            saveProperties: control.saveProperties
        }
    }

    Loader {
        id: emitterLoaderShape
        active: control.editableShape.shapeType === EditableShape.ShapeType.ShapeTypeShape

        sourceComponent: CustomEmitterShape {
            editableShape: control.editableShape
            system: control.system
            propertyValues: control.propertyValues
            saveProperties: control.saveProperties
        }
    }
}
