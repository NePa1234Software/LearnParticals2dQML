import QtQuick
import QtQuick.Particles

Attractor {
    id: control

    property EditableShape editableShape
    property ListModel propertyValues: ConfigListModelAttractor {}
    property list<string> saveProperties: propertyValues.saveProperties

    objectName: "Attractor_" + control.editableShape.shapeIndex
    system: control
    x: control.editableShape.x
    y: control.editableShape.y
    width: control.editableShape.width
    height: control.editableShape.height
    affectedParameter: Attractor.Velocity
    strength: 1

    function load() {
        settingsId.load()
    }
    function save() {
        settingsId.save()
    }

    SettingHelper {
        id: settingsId
        saveProperties: control.saveProperties
    }

    Component.onCompleted: {
        if (!control.editableShape) {
            console.error("no shape set")
        }
    }
}
