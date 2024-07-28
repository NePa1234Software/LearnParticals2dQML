import QtQuick
import QtQuick.Shapes
import QtQuick.Particles

Shape {
    id: control

    property color borderColor: "blue"
    property color editBorderColor: "red"
    property bool editing: true
    property bool hidden: false

    signal requestShapeMove(positionNew : point)
    signal requestShapeDelete()

    function pointAtPercent(t: real) : point {
        return Qt.point(x,y);
    }

    QtObject {
        id: priv
        property int strokeWidth: 2
    }

    Rectangle {
        visible: control.editing
        border.color: "orange"
        border.width: 1
        color: "transparent"
        anchors.fill: parent
    }

    DragPoint {
        id: movePoint
        visible: control.editing && !control.hidden
        toolTipText: qsTr("CTRL-Right click to delete.\n" +
                          "Drag the shape to desired position.")
        x: control.x
        y: control.y
        color: control.editBorderColor
        border.color: control.editBorderColor
        border.width: priv.strokeWidth
        cursorShape: Qt.DragMoveCursor
        onRequestPointMove: (pointNew) => {
            control.requestShapeMove(pointNew)
        }
        onRequestPointDelete: {
            control.requestShapeDelete()
        }
    }
}
