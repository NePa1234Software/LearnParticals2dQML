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
        return strokePath.pointAtPercent(t)
    }

    QtObject {
        id: priv
        property int strokeWidth: 2
        property list<point> pathPoints: [
            Qt.point(0.0, 0.0),
            Qt.point(100, 100.0)
        ]
    }

    Rectangle {
        visible: control.editing
        border.color: "yellow"
        border.width: 2
        color: "transparent"
        x: boundingRect.x
        y: boundingRect.y
        width: boundingRect.width
        height: boundingRect.height
    }

    Rectangle {
        visible: control.editing
        border.color: "orange"
        border.width: 1
        color: "transparent"
        anchors.fill: parent
    }

    ShapePath {
        id: strokePath

        strokeColor: control.borderColor
        strokeStyle: ShapePath.SolidLine
        strokeWidth: priv.strokeWidth
        fillColor: "transparent"

        NumberAnimation on dashOffset { from: 0; to: 6; duration: 2000; loops: Animation.Infinite }
        startX: priv.pathPoints[0].x
        startY: priv.pathPoints[0].y
        pathElements : [
            PathPolyline {
                path: priv.pathPoints
            }
        ]
    }

    Repeater {
        model: control.editing ? priv.pathPoints.length - 1 : 0
        delegate: DragPoint {
            id: dragPoint
            visible: control.editing && !control.hidden
            toolTipText: qsTr("Right click to add point.\n" +
                              "CTRL-Right click to delete.\n" +
                              "Drag the point to desired position.")
            x: priv.pathPoints[index + 1].x
            y: priv.pathPoints[index + 1].y
            border.color: control.editBorderColor
            border.width: priv.strokeWidth
            onRequestPointMove: (pointNew) => {
                priv.pathPoints[index + 1] = pointNew
            }
            onRequestPointAdd : {
                console.log("add one point to index:", index + 1)
                priv.pathPoints[index + 1].x += 10
                priv.pathPoints[index + 1].y += 10
                priv.pathPoints.splice(index + 2, 0, Qt.point(priv.pathPoints[index + 1].x - 20, priv.pathPoints[index + 1].y - 20))
            }
            onRequestPointDelete: {
                console.log("remove one point at index:", index + 1)
                priv.pathPoints.splice(index + 1, 1)
            }
        }
    }

    DragPoint {
        id: movePoint
        visible: control.editing && !control.hidden
        toolTipText: qsTr("Right click to add point.\n" +
                          "CTRL-Right click to delete.\n" +
                          "Drag the shape to desired position.")
        x: priv.pathPoints[0].x
        y: priv.pathPoints[0].y
        color: control.editBorderColor
        border.color: control.editBorderColor
        border.width: priv.strokeWidth
        cursorShape: Qt.DragMoveCursor
        onRequestPointMove: (pointNew) => {
            control.requestShapeMove(pointNew)
        }
        onRequestPointAdd : {
            console.log("add one point to index:", 0)
            priv.pathPoints.splice(1, 0, Qt.point(priv.pathPoints[0].x + 20, priv.pathPoints[0].y + 20))
        }
        onRequestPointDelete: {
            control.requestShapeDelete()
        }
    }

    states: [
        State {
            name: "hidden"
            when: control.hidden
            PropertyChanges {
                target: strokePath
                strokeColor: "transparent"
                strokeStyle: ShapePath.SolidLine
                dashOffset: 0
            }
        },
        State {
            name: "editing"
            when: control.editing
            PropertyChanges {
                target: strokePath
                strokeColor: control.editBorderColor
                strokeStyle: ShapePath.DashLine
            }
        },
        State {
            name: "normal"
            // when:   ELSE
            PropertyChanges {
                target: strokePath
                strokeColor: control.borderColor
                strokeStyle: ShapePath.SolidLine
                dashOffset: 0
            }
        }
    ]
    // onStateChanged: console.log("state changed to : ", control.state)
}
