import QtQuick 2.15
import "components"

FocusScope {
    id: root
    focus: true

    readonly property color clrBackground: "#111113"

    readonly property real coverTilt: -4

    Rectangle {
        anchors.fill: parent
        color: root.clrBackground
    }

    Background {
        anchors.fill: parent
        currentIndex: gameList.currentIndex
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
}
