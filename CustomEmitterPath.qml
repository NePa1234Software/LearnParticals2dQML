import QtQuick
import QtQuick.Particles
import QtCore

Emitter {
    id: control
    objectName: "Emitter_" + control.editableShape.shapeIndex

    property EditableShape editableShape
    property ListModel propertyValues: ConfigListModelEmitter {}
    property list<string> saveProperties: propertyValues.saveProperties

    property real pathPosPercent: 0.0
    property point pathPosition: control.editableShape.pointAtPercent(control.pathPosPercent)
    NumberAnimation on pathPosPercent { from: 0; to: 1.0; duration: 210; loops: Animation.Infinite; running: true }

    group: "stars"
    emitRate: 1
    lifeSpan: 2000
    size: 50
    sizeVariation: 20
    // system: sys
    x: control.editableShape.x + control.pathPosition.x
    y: control.editableShape.y + control.pathPosition.y

    Component.onCompleted: {
        if (!control.editableShape) {
            console.error("no shape set")
        }
    }
}
