import QtQuick
import QtQuick.Particles
import QtCore

Emitter {
    id: control

    property EditableShape editableShape

    property real pathPosPercent: 0.0
    property point pathPosition: control.editableShape.pointAtPercent(control.pathPosPercent)
    NumberAnimation on pathPosPercent { from: 0; to: 1.0; duration: 210; loops: Animation.Infinite; running: true }

    property var propertyValues: { "emitRate": 500 }
    onPropertyValuesChanged: updateProperties()

    group: "stars"
    emitRate: 1
    lifeSpan: 2000
    size: 50
    sizeVariation: 20
    // system: sys
    x: control.editableShape.x + control.pathPosition.x
    y: control.editableShape.y + control.pathPosition.y

    function updateProperties() {
        control.emitRate = control.propertyValues.emitRate ?? 500
    }

    Settings {
        id: settingsId
        category: "Emitter_" + control.editableShape.shapeIndex
        Component.onCompleted: {
            console.log("Emitter: Settings location: ", settingsId.location)
        }
    }

    Component.onCompleted: {
        if (!control.editableShape) {
            console.error("no shape set")
        }
        control.updateProperties()
    }
}
