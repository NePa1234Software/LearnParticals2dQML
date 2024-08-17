import QtQuick
import QtCore
import LearnParticles2dQML

Item {
    id: control
    property QtObject target: parent
    property string category: parent.objectName
    property list<string> saveProperties: []
    property alias settings: settingsId

    function load() {
        if (!control.target) return;

        control.saveProperties.forEach((element) => {
            console.log("loading property category %1:".arg(settingsId.category), element)
            var loadValue = settingsId.value(element);
            if (loadValue) {
                PropertyIntrospection.writeProperty(control.target, element, loadValue);
                console.log("loaded  property category %1:".arg(settingsId.category), element, "=", loadValue);
            }
        })
    }

    function save() {
        if (!control.target) return;

        control.saveProperties.forEach((element) => {
            var saveValue = PropertyIntrospection.readProperty(control.target, element);
            console.log("save property category %1:".arg(settingsId.category), element, "=", saveValue)
            if (saveValue !== undefined) {
                settingsId.setValue(element, saveValue);
            }
        })
    }

    Settings {
        id: settingsId
        category: control.category
    }
}
