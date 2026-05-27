import QtQuick 2.15

Item {
    id: root
    height: parent.height * 0.50

    property int currentIndex: 0
    property var currentGame: api.allGames.get(currentIndex)
    readonly property color bodyTxt: Qt.rgba(1, 1, 1, 0.65)
    property color dimColor: Qt.rgba(1, 1, 1, 0.55)
    property real fontSize: 14

    function formatPlayTime(seconds) {
        var h = Math.floor(seconds / 3600);
        var m = Math.floor((seconds % 3600) / 60);
        if (h > 0)
            return h + "h " + m + "m";
        if (m > 0)
            return m + "m";
        return seconds < 60 && seconds + "s";
    }

    function formatLastPlayed(date) {
        if (!date || isNaN(date.getTime()))
            return "Never played";
        return Qt.formatDate(date, "MMM d, yyyy");
    }

    Column {
        width: parent.width
        spacing: 0

        Text {
            id: titleText
            width: parent.width * 0.9
            text: currentGame.title || ""
            color: "#ffffff"
            font.pixelSize: Math.max(30, root.height * 0.09)
            font.bold: true
            wrapMode: Text.WordWrap
            maximumLineCount: 2
            elide: Text.ElideRight
            lineHeight: 1.1
            bottomPadding: root.height * 0.022
        }

        Text {
            id: descText
            width: parent.width * 0.7
            text: currentGame.description || "No description available..."
            color: root.bodyTxt
            font.pixelSize: Math.max(17, root.height * 0.022)
            wrapMode: Text.WordWrap
            maximumLineCount: 10
            elide: Text.ElideRight
            lineHeight: 1.2
            visible: text !== ""
            bottomPadding: root.height * 0.03
        }

        Row {
            spacing: 4

            Text {
                text: "Playtime: " + formatPlayTime(currentGame.playTime)
                visible: currentGame.playTime > 0
                color: root.dimColor
                font.pixelSize: root.fontSize
            }

            Text {
                text: "  ·  "
                visible: currentGame.playTime > 0
                color: root.dimColor
                font.pixelSize: root.fontSize
                font.bold: true
            }

            Text {
                text: "Last played: " + formatLastPlayed(currentGame.lastPlayed)
                color: root.dimColor
                font.pixelSize: root.fontSize
            }
        }
    }
}
