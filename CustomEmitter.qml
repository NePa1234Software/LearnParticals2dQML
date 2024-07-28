import QtQuick
import QtQuick.Particles

Item {
    id: control

    property EditableShape editableShape
    property ParticleSystem system

    Loader {
        id: emitterLoaderPath
        active: control.editableShape.shapeType === EditableShape.ShapeType.ShapeTypePath

        sourceComponent: CustomEmitterPath {
            editableShape: control.editableShape
            system: control.system
        }
    }

    Loader {
        id: emitterLoaderShape
        active: control.editableShape.shapeType === EditableShape.ShapeType.ShapeTypeShape

        sourceComponent: CustomEmitterShape {
            editableShape: control.editableShape
            system: control.system
        }
    }
}
