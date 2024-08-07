import QtQuick

Item {
    id: control
    objectName: "ShapeEditor"

    property list<EditableShape> shapes
    property bool editing: true
    property bool hidden: false
    property int creationIndex: 1

    function createShape(posX : real,
                         posY : real,
                         particleType : string,
                         shapeType : int) {
        var newShape = componentEditableShape.createObject(root.contentItem,
                                                           { particleType: particleType,
                                                               x: posX,
                                                               y: posY,
                                                               shapeType: shapeType,
                                                               shapeIndex: control.creationIndex
                                                           })
        if (!newShape) {
            console.error("creation failed: ", particleType)
        } else {
            control.shapes.push(newShape)
            control.creationIndex++
        }
    }

    function deleteShape(shapeItem : EditableShape) {
        var idx = control.shapes.indexOf(shapeItem)
        shapeItem.destroy();
        if (idx >= 0) {
            control.shapes.splice(idx,1);
        }

        // Reindex the shapes so that load and save work as expected
        control.creationIndex = 1
        control.shapes.forEach((element) => {
            element.shapeIndex = control.creationIndex;
            control.creationIndex++
        });
    }

    function deleteAllShapes() {
        control.shapes.forEach((element) => element.destroy() );
        control.shapes = [];
        control.creationIndex = 1;
    }

    function save() {
        settingsId.settings.setValue("shapeCount", control.shapes.length);
        control.shapes.forEach((element) => element.save() );
    }
    function load() {
        deleteAllShapes();
        var shapesCount = settingsId.settings.value("shapeCount", 0)
        for (let ii = 0; ii < shapesCount; ii++) {
            settingsSectionId.category = "EditableShape_" + (ii + 1)
            var shapeType = settingsSectionId.settings.value("shapeType", -1)
            var particleType = settingsSectionId.settings.value("particleType", "")
            if (shapeType >= 0 && particleType != "") {
                control.createShape(0, 0,particleType, shapeType);
            } else {
                console.error("shape creation not possilbe", shapeType, particleType)
            }
        }
        control.shapes.forEach((element) => element.load() )
    }

    SettingHelper {
        id: settingsId
    }
    SettingHelper {
        id: settingsSectionId
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
