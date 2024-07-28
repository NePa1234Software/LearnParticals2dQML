import QtQuick

Item {
    id: control

    property list<EditableShape> shapes
    property bool editing: true
    property bool hidden: false

    function createShape(posX : real,
                         posY : real,
                         particleType : string,
                         shapeType : int) {
        var newShape = componentEditableShape.createObject(root.contentItem,
                                                           { particleType: particleType,
                                                               x: posX,
                                                               y: posY,
                                                               shapeType: shapeType
                                                           })
        if (!newShape) {
            console.error("creation failed: ", particleType)
        } else {
            control.shapes.push(newShape)
        }
    }

    function deleteShape(shapeItem : EditableShape) {
        var idx = control.shapes.indexOf(shapeItem)
        shapeItem.destroy();
        if (idx >= 0) {
            control.shapes.splice(idx,1);
        }
    }

    Component {
        id: componentEditableShape

        EditableShape {
            id: editableShape
            property string particleType: "emitter"
            editing: control.editing
            hidden: control.hidden
            onRequestShapeMove: (positionNew) => {
                                    editableShape.x = positionNew.x
                                    editableShape.y = positionNew.y
                                }
            onRequestShapeDelete: {
                control.deleteShape(this)
            }
        }
    }
}
