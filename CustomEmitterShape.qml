import QtQuick
import QtQuick.Particles

Emitter {
    id: control
    objectName: "Emitter_" + control.editableShape.shapeIndex
    property EditableShape editableShape
    property ListModel propertyValues: ConfigListModelEmitter {}
    property list<string> saveProperties: propertyValues.saveProperties

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
