import QtQuick
import QtQuick.Particles
import Qt.labs.qmlmodels

ParticleSystem {
    id: control

    property list<EditableShape> shapes

    Repeater {
        id: repeater
        model: control.shapes
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
                delegate: attractorDelegate
            }
        }
    }

    Component {
        id: attractorDelegate

        Attractor {
            id: attractor
            system: control
            x: control.shapes[index].x
            y: control.shapes[index].y
            width: control.shapes[index].width
            height: control.shapes[index].height
            affectedParameter: Attractor.Velocity
            strength: 1
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
