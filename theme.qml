import QtQuick 2.15
import "components"

FocusScope {
    id: root
    focus: true

    readonly property color clrBackground: "#111113"

    Rectangle {
        anchors.fill: parent
        color: root.clrBackground
    }

    Background {
        anchors.fill: parent
        currentIndex: gameList.currentIndex
    }

    HeroImg {
        id: heroImg
        currentIndex: gameList.currentIndex
        anchors {
            left: parent.left
            leftMargin: parent.width * 0.20
            top: parent.top
            topMargin: parent.height * 0.17
        }
    }

    HeroText {
        currentIndex: gameList.currentIndex
        anchors {
            left: heroImg.right
            leftMargin: 40
            right: parent.right
            rightMargin: parent.width * 0.08
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: heroImg.height * -0.10
        }
    }

    GameRow {
        id: gameList
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right

            bottomMargin: 20
            leftMargin: 40
            rightMargin: 40
        }
    }

    Text {
        text: api.allGames.count + " games"
        color: Qt.rgba(1, 1, 1, 0.8)
        font.pixelSize: 16
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 30
    }
}
