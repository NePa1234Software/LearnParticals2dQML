import QtQuick
import QtQuick.Controls

Button {
    id: control
    text: qsTr("!")
    background: Rectangle {
        border.color: "navy"
        radius: Globals.cornerRadius
    }
}
