import QtQuick 2.15
import QtGraphicalEffects 1.15

Item {
    id: root
    width: parent.width * 0.20
    height: parent.height * 0.50

    property int currentIndex: 0
    property var currentGame: api.allGames.get(currentIndex)

    Rectangle {
        id: card
        anchors.fill: parent
        radius: 12
        color: "transparent"

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Rectangle {
                width: card.width
                height: card.height
                radius: card.radius
            }
        }

        transform: Rotation {
            origin.x: card.width / 2
            origin.y: card.height / 2

            axis.x: 0
            axis.y: 1
            axis.z: 0
            angle: 20
        }

        Image {
            id: heroImg
            anchors.fill: parent
            source: currentGame.assets.boxFront || ""
            fillMode: Image.PreserveAspectCrop
            layer.enabled: true
            layer.effect: FastBlur {
                radius: root.blurRadius
            }

            Behavior on source {
                SequentialAnimation {
                    NumberAnimation {
                        target: heroImg
                        property: "opacity"
                        to: 0.8
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }

                    PropertyAction {
                        target: heroImg
                        property: "source"
                    }

                    NumberAnimation {
                        target: heroImg
                        property: "opacity"
                        to: 1
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            Behavior on opacity {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
