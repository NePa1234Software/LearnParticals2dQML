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
        settingsId.load();
        if (shapeTypeLoader.item) {
            shapeTypeLoader.item.load();
        } else {
            priv.loadRequested = true;
        }
    }
    function save() {
        settingsId.save();
        if (shapeTypeLoader.item) {
            shapeTypeLoader.item.save();
        }
    }

    QtObject {
        id: priv
        property bool loadRequested: false
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
        onLoaded: {
            if (priv.loadRequested) {
                priv.loadRequested = false;
                shapeTypeLoader.item.load();
            }
        }
    }

    Component {
        id: componentPath
        EditableShapePath {
            editing: control.editing
            hidden: control.hidden
            borderColor: control.borderColor
            editBorderColor: control.editBorderColor
            shapeIndex: control.shapeIndex
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
            shapeIndex: control.shapeIndex
            onRequestShapeMove: (pointNew) => {
                                    control.requestShapeMove(pointNew)
                                }
            onRequestShapeDelete: {
                control.requestShapeDelete()
            }
        }
    }
}
