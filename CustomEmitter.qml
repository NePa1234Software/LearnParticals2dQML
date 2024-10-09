import QtQuick
import QtQuick.Particles

Item {
    id: control

    objectName: "Emitter_" + control.editableShape.shapeIndex

    property EditableShape editableShape
    property ParticleSystem system

    readonly property bool isFactory: true
    readonly property Item item: emitterLoaderPath.item || emitterLoaderShape.item

    property ListModel propertyValues: ConfigListModelEmitter {}
    property list<string> saveProperties: propertyValues.saveProperties

    function load() {
        settingsId.load()
    }
    function save() {
        settingsId.save()
    }
    SettingHelper {
        id: settingsId
        target: item
        saveProperties: control.saveProperties
    }

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
