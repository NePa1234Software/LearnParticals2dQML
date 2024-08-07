import QtQml
import QtQuick
import QtQuick.Shapes
import QtQuick.Particles

Shape {
    id: control
    objectName: "EditableShape_" + control.shapeIndex

    property color borderColor: "blue"
    property color editBorderColor: "red"
    property bool editing: true
    property bool hidden: false
    property int shapeType: EditableShape.ShapeType.ShapeTypePath
    property int shapeIndex: -1
    property string particleType: ""

    enum ShapeType {
        ShapeTypeSpot,
        ShapeTypePath
        // ShapeTypeRectangle
    }

    signal requestShapeMove(positionNew : point)
    signal requestShapeDelete()

    function pointAtPercent(t: real) : point {
        return shapeTypeLoader.item.pointAtPercent(t)
    }

    function load() {
        settingsId.load()
        //shapeTypeLoader.item.save()
    }
    function save() {
        settingsId.save()
        //shapeTypeLoader.item.save()
    }

    SettingHelper {
        id: settingsId
        saveProperties: ["x", "y", "shapeIndex", "shapeType", "particleType"]
    }

    Loader {
        id: shapeTypeLoader
        active: true
        sourceComponent: if (control.shapeType == EditableShape.ShapeType.ShapeTypePath) {
                             return componentPath
                         } else { return componentSpot }
    }

    Component {
        id: componentPath
        EditableShapePath {
            editing: control.editing
            hidden: control.hidden
            borderColor: control.borderColor
            editBorderColor: control.editBorderColor
            onRequestShapeMove: (pointNew) => {
                                    control.requestShapeMove(pointNew)
                                }
            onRequestShapeDelete: {
                control.requestShapeDelete()
            }
        }
    }

    Component {
        id: componentSpot
        EditableShapeSpot {
            editing: control.editing
            hidden: control.hidden
            borderColor: control.borderColor
            editBorderColor: control.editBorderColor
            onRequestShapeMove: (pointNew) => {
                                    control.requestShapeMove(pointNew)
                                }
            onRequestShapeDelete: {
                control.requestShapeDelete()
            }
        }
    }
}
