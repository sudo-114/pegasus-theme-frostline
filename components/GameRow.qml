import QtQuick 2.15
import QtGraphicalEffects 1.15

ListView {
    id: gameList
    width: parent.width
    height: 320
    focus: true
    spacing: 20
    orientation: ListView.Horizontal
    snapMode: ListView.SnapToItem
    model: api.allGames

    highlightRangeMode: ListView.StrictlyEnforceRange
    preferredHighlightBegin: 40
    preferredHighlightEnd: width - 240
    highlightMoveDuration: 100
    highlightMoveVelocity: -1

    delegate: Item {
        id: delegateRoot
        width: 200
        height: gameList.height

        Keys.onReturnPressed: modelData.launch()

        readonly property bool isSelected: ListView.isCurrentItem

        Rectangle {
            id: card
            anchors.centerIn: parent
            width: 200
            height: 280
            radius: 12
            color: "transparent"

            Behavior on scale {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutQuad
                }
            }
            Behavior on border.width {
                NumberAnimation {
                    duration: 100
                }
            }

            scale: delegateRoot.isSelected ? 1.08 : 1.0
            opacity: delegateRoot.isSelected ? 1.0 : 0.5

            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Rectangle {
                    width: card.width
                    height: card.height
                    radius: card.radius
                }
            }

            Image {
                anchors.fill: parent
                anchors.margins: delegateRoot.isSelected ? 4 : 0
                fillMode: Image.PreserveAspectCrop
                source: modelData.assets.boxFront || ""
                cache: true
                smooth: true
                asynchronous: true
            }

            Rectangle {
                anchors.fill: parent
                radius: card.radius
                color: "transparent"

                border.color: delegateRoot.isSelected ? "#f6f3f4" : "transparent"
                border.width: delegateRoot.isSelected ? 4 : 0

                Behavior on border.width {
                    NumberAnimation {
                        duration: 100
                    }
                }
            }
        }
    }
}
