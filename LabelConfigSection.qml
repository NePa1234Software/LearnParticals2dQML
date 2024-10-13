import QtQuick
import QtQuick.Controls

Rectangle {
    id: control
    property alias text : label.text
    implicitWidth: label.contentWidth + 10
    implicitHeight: label.contentHeight + 10
    border.color: "navy"
    color: Qt.darker("lightblue")
    Label {
        id: label
        anchors.centerIn: parent
        text: control.section
    }
}
