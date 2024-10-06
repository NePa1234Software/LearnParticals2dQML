import QtQuick
import QtQuick.Particles

Attractor {
    id: control

    property EditableShape editableShape
    property var propertyValues: { "strength": { "type": "Slider", "from": 1, "to": 20, "stepSize": 0.1} }
    property list<string> saveProperties: [ "strength" ]

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
