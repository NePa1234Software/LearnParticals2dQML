import QtQuick

ListModel {
    id: model

    property list<string> saveProperties: [ "strength" ]

    // property must match the property name in the documentation (case sensitive)
    ListElement { group: "Attractor"; type: "Slider"; property: "strength"; from: 1; to: 200; stepSize: 0.1 }
}
