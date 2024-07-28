import QtQuick
import QtQuick.Particles

Emitter {
    id: control
    property EditableShape editableShape

    group: "stars"
    emitRate: 200
    lifeSpan: 2000
    size: 50
    sizeVariation: 5
    // system: sys
    x: control.editableShape.x
    y: control.editableShape.y

    Component.onCompleted: {
        if (!control.editableShape) {
            console.error("no shape set")
        }
    }

}
