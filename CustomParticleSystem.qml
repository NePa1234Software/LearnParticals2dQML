import QtQuick
import QtQuick.Particles
import Qt.labs.qmlmodels

ParticleSystem {
    id: control

    required property ShapeEditor shapeEditor
    property Item currentParticalItem: null

    Connections {
        target: shapeEditor
        function onCurrentIndexChanged() {
            for (var ii = 0; ii < repeater.count; ii++ )
            {
                var tmpItem = repeater.itemAt(ii)
                if (tmpItem.editableShape?.shapeIndex === control.shapeEditor.currentIndex)
                {
                    control.currentParticalItem = tmpItem
                    console.log("Selected partical item: ", control.currentParticalItem, (control.currentParticalItem?.objectName ?? "-?-"))
                }
            }
        }
    }

    Repeater {
        id: repeater
        model: control.shapeEditor.shapes
        delegate: DelegateChooser {
            role: "particleType"
            DelegateChoice {
                roleValue: "emitter"
                delegate: CustomEmitter {
                    editableShape: modelData
                    system: control
                }
            }
            DelegateChoice {
                roleValue: "attractor"
                delegate: CustomAttractor {
                    editableShape: modelData
                    system: control
                }
            }
        }
    }

    ImageParticle {
        groups: ["stars"]
        source: "qrc:///particleresources/star.png"
        system: sys
        anchors.fill: parent
        color: "orange"
    }
}
