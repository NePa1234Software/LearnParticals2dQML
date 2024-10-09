import QtQuick

ListModel {
    id: model

    property list<string> saveProperties: [ "emitRate", "lifeSpan" ]

    // property must match the property name in the documentation (case sensitive)
    ListElement { type: "Slider"; property: "emitRate"; from: 1; to: 1000; stepSize: 0.1 }
    ListElement { type: "Slider"; property: "lifeSpan"; from: 0; to: 600000; stepSize: 10 }
}
