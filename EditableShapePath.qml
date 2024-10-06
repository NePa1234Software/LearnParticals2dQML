import QtQuick
import QtQuick.Shapes
import QtQuick.Particles

Shape {
    id: control
    objectName: "EditableShapePath_" + control.shapeIndex

    property color borderColor: "blue"
    property color editBorderColor: "red"
    property bool editing: true
    property bool hidden: false
    property int shapeIndex: -1

    property list<point> pathPoints: [
        Qt.point(0.0, 0.0),
        Qt.point(100, 100.0)
    ]

    signal requestShapeMove(positionNew : point)
    signal requestShapeDelete()
    signal requestShapeSelect()

    function pointAtPercent(t: real) : point {
        return strokePath.pointAtPercent(t)
    }

    function load() {
        settingsId.load()
    }
    function save() {
        settingsId.save()
    }

    SettingHelper {
        id: settingsId
        saveProperties: ["pathPoints"]
    }

    QtObject {
        id: priv
        property int dotWidth: 2
        property int strokeWidth: 4
    }

    ShapePath {
        id: strokePath
        strokeColor: control.borderColor
        strokeStyle: ShapePath.DashLine
        strokeWidth: priv.strokeWidth
        fillColor: "transparent"
        miterLimit: 200

        NumberAnimation on dashOffset { from: 0; to: 6; duration: 2000; loops: Animation.Infinite }
        startX: control.pathPoints[0].x
        startY: control.pathPoints[0].y
        pathElements : [
            PathPolyline {
                path: control.pathPoints
            }
        ]
    }

    Repeater {
        model: control.editing ? control.pathPoints.length - 1 : 0
        delegate: DragPoint {
            id: dragPoint
            visible: control.editing && !control.hidden
            toolTipText: qsTr("Right click to add point.\n" +
                              "CTRL-Right click to delete.\n" +
                              "Drag the point to desired position.")
            x: control.pathPoints[index + 1].x
            y: control.pathPoints[index + 1].y
            border.color: control.editBorderColor
            border.width: priv.dotWidth
            onRequestPointMove: (pointNew) => {
                control.pathPoints[index + 1] = pointNew
            }
            onRequestPointAdd : {
                console.log("add one point to index:", index + 1)
                control.pathPoints.splice(index + 2, 0,
                    Qt.point(control.pathPoints[index + 1].x + 20,
                             control.pathPoints[index + 1].y + 20))
            }
            onRequestPointDelete: {
                console.log("remove one point at index:", index + 1)
                control.pathPoints.splice(index + 1, 1)
            }
            onRequestPointSelect: {
                control.requestShapeSelect()
            }
        }
    }

    DragPoint {
        id: movePoint
        visible: control.editing && !control.hidden
        toolTipText: qsTr("Right click to add point.\n" +
                          "CTRL-Right click to delete.\n" +
                          "Drag the shape to desired position.")
        x: control.pathPoints[0].x
        y: control.pathPoints[0].y
        color: control.editBorderColor
        border.color: control.editBorderColor
        border.width: priv.dotWidth
        cursorShape: Qt.DragMoveCursor
        onRequestPointMove: (pointNew) => {
            control.requestShapeMove(pointNew)
        }
        onRequestPointAdd : {
            console.log("add one point to index:", 0)
            control.pathPoints.splice(1, 0, Qt.point(control.pathPoints[0].x + 20, control.pathPoints[0].y + 20))
        }
        onRequestPointDelete: {
            control.requestShapeDelete()
        }
        onRequestPointSelect: {
            control.requestShapeSelect()
        }
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
        z: strokePath.z - 10
    }

    Rectangle {
        visible: control.editing
        border.color: "orange"
        border.width: 1
        color: "transparent"
        anchors.fill: parent
        z: strokePath.z - 11
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
