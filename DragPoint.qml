import QtQuick
import QtQuick.Controls

// Create a small circle that can be moved around.
// Rectangel features can be customised, e.g. Border and Fill colors
Rectangle {
    id: control

    property alias cursorShape: mousePoint.cursorShape
    property alias toolTipText: toolTip.text

    signal requestPointMove(positionNew : point)
    signal requestPointAdd()
    signal requestPointDelete()

    width: 16
    height: control.width
    radius: control.width / 2
    border.color: "black"
    border.width: 2
    color: "transparent"
    transform: Translate { x: -control.width / 2; y: -control.height / 2 }

    MouseArea {
        id: mousePoint

        property point lastPressed
        property point lastPosition
        anchors.fill: parent
        anchors.margins: -20
        cursorShape: Qt.ClosedHandCursor
        acceptedButtons: Qt.AllButtons
        onPressed: (mouseEvent) => {
                       mousePoint.lastPressed.x = mouseEvent.x
                       mousePoint.lastPressed.y = mouseEvent.y
                       mousePoint.lastPosition = Qt.point(control.x, control.y)
                       // console.log("pressed:",
                       //             mouseEvent.x, mouseEvent.y,
                       //             mousePoint.lastPosition.x, mousePoint.lastPosition.y,
                       //             mousePoint.lastPosition.x, mousePoint.lastPosition.y)
                   }
        onPositionChanged: (mouseEvent) => {
                               var pointNew = mousePoint.lastPosition
                               pointNew.x = pointNew.x + mouseEvent.x - mousePoint.lastPressed.x;
                               pointNew.y = pointNew.y + mouseEvent.y - mousePoint.lastPressed.y;
                               control.requestPointMove(pointNew);
                               // console.log("position changed:",
                               //             mouseEvent.x, mouseEvent.y,
                               //             mousePoint.lastPressed.x, mousePoint.lastPressed.y,
                               //             mousePoint.lastPosition.x, mousePoint.lastPosition.y,
                               //             pointNew.x, pointNew.y);
                           }
        onClicked: (mouseEvent) => {
                       if (mouseEvent.button == Qt.RightButton) {
                           if (mouseEvent.modifiers == Qt.ControlModifier) {
                               control.requestPointDelete();
                           } else {
                               control.requestPointAdd();
                           }
                           return;
                       }
                       if (mouseEvent.button == Qt.RightButton) {
                           control.requestPointAdd();
                           return;
                       }
                   }
    }

    ToolTip {
        id: toolTip
        visible: mousePoint.containsPress && toolTip.text != ""
        delay: 1000
        timeout: 5000
        text: ""
    }
}
