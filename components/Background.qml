import QtQuick 2.15
import QtGraphicalEffects 1.15

Item {
    id: root

    readonly property color gradient0: Qt.rgba(0, 0, 0, 0.3)
    readonly property color gradient1: Qt.rgba(0, 0, 0, 0.85)
    readonly property real blurRadius: 55

    property int currentIndex: 0
    property var currentGame: api.allGames.get(currentIndex)

    Image {
        id: bgImg
        anchors.fill: parent
        source: currentGame.assets.background || currentGame.assets.banner || currentGame.assets.screenshot || ""
        fillMode: Image.PreserveAspectCrop
        layer.enabled: true
        layer.effect: FastBlur {
            radius: root.blurRadius
        }

        Behavior on source {
            SequentialAnimation {
                NumberAnimation {
                    target: bgImg
                    property: "opacity"
                    to: 0.8
                    duration: 200
                    easing.type: Easing.InOutQuad
                }

                PropertyAction {
                    target: bgImg
                    property: "source"
                }

                NumberAnimation {
                    target: bgImg
                    property: "opacity"
                    to: 1
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }

        Behavior on opacity { 
            NumberAnimation { duration: 250; easing.type: Easing.InOutQuad } 
        }
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: root.gradient0
            }
            GradientStop {
                position: 1.0
                color: root.gradient1
            }
        }
    }
}
