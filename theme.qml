import QtQuick 2.15
import "components"

FocusScope {
    id: root
    focus: true

    readonly property color clrBackground: "#111113"
    readonly property color clrText: "#ffffff"

    readonly property real coverTilt: -4

    Rectangle {
        anchors.fill: parent
        color: root.clrBackground
    }

    Background {
        anchors.fill: parent
    }
}
