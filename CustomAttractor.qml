import QtQuick
import QtQuick.Particles

Attractor {
    id: attractor

    property EditableShape editableShape
    property var propertyValues: { "A":0, "B":2 }

    objectName: "Attractor_" + attractor.editableShape.shapeIndex
    system: control
    x: attractor.editableShape.x
    y: attractor.editableShape.y
    width: attractor.editableShape.width
    height: attractor.editableShape.height
    affectedParameter: Attractor.Velocity
    strength: 1
}
