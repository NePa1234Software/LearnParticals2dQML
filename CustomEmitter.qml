import QtQuick
import QtQuick.Particles

Item {
    id: control

    objectName: "Emitter_" + control.editableShape.shapeIndex

    property EditableShape editableShape
    property ParticleSystem system

    readonly property Item item: emitterLoaderPath.item || emitterLoaderShape.item
    property var propertyValues: { "emitRate": 500 }

    Loader {
        id: emitterLoaderPath
        active: control.editableShape.shapeType === EditableShape.ShapeType.ShapeTypePath

        sourceComponent: CustomEmitterPath {
            editableShape: control.editableShape
            system: control.system
            propertyValues: control.propertyValues
        }
    }

    Loader {
        id: emitterLoaderShape
        active: control.editableShape.shapeType === EditableShape.ShapeType.ShapeTypeShape

        sourceComponent: CustomEmitterShape {
            editableShape: control.editableShape
            system: control.system
            propertyValues: control.propertyValues
        }
    }
}
