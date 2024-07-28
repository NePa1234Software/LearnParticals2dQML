import QtQuick
import QtQuick.Particles

Emitter {
    id: control

    property EditableShape editableShape

    property real pathPosPercent: 0.0
    property point pathPosition: control.editableShape.pointAtPercent(control.pathPosPercent)
    NumberAnimation on pathPosPercent { from: 0; to: 1.0; duration: 210; loops: Animation.Infinite; running: true }

    group: "stars"
    emitRate: 200
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
