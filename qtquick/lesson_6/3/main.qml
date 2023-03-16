import QtQuick 2.15
import QtQuick.Controls 2.15
import "Funcs.js" as Fn

Window {
    width: 600
    height: 450
    visible: true
    title: qsTr("Lesson #6_3")
    id: mainwin

    property string apiToken: "d08a40c4ed97f842102830cf5be2405e"

    Text {
        id: text
        anchors.horizontalCenter: parent.horizontalCenter
        text: "В связи с ограниченным числом запросов к API, запрос производится по кнопке."
    }

    Row {
        id: row1
        anchors.top: text.bottom
        anchors.left: parent.left
        anchors.leftMargin: 20
        topPadding: 10
        spacing: 5
        Text {
            text: "Город:"
            font.pointSize: 20
        }
        Text {
            id: city
            font.pointSize: 20
            color: "dark green"
        }
    }

    Row {
        id: row2
        anchors.top: row1.bottom
        anchors.left: row1.left
        topPadding: 10
        spacing: 5
        Text {
            text: "Текущая температура:"
            font.pointSize: 20
        }
        Text {
            id: curTemp
            font.pointSize: 20
            color: "dark green"
        }
    }

    Row {
        id: row3
        anchors.top: row2.bottom
        topPadding: 10
        anchors.left: row2.left
        spacing: 5
        Text {
            text: "Ощущается как:"
            font.pointSize: 20
        }
        Text {
            id: feelsLike
            font.pointSize: 20
            color: "dark green"
        }
    }

    Row {
        id: row4
        anchors.top: row3.bottom
        topPadding: 10
        anchors.left: row3.left
        spacing: 5
        Text {
            text: "Давление, мм рт.с.:"
            font.pointSize: 20
        }
        Text {
            id: pressure
            font.pointSize: 20
            color: "dark green"
        }
    }

    Row {
        id: row5
        anchors.top: row4.bottom
        topPadding: 10
        anchors.left: row4.left
        spacing: 5
        Text {
            text: "Влажность, %:"
            font.pointSize: 20
        }
        Text {
            id: humidity
            font.pointSize: 20
            color: "dark green"
        }
    }

    Row {
        id: row6
        anchors.top: row5.bottom
        topPadding: 10
        anchors.left: row5.left
        spacing: 5
        Text {
            text: "Видимость, м:"
            font.pointSize: 20
        }
        Text {
            id: visibility
            font.pointSize: 20
            color: "dark green"
        }
    }

    Row {
        id: row7
        anchors.top: row6.bottom
        topPadding: 10
        anchors.left: row6.left
        spacing: 5
        Text {
            text: "Скорость ветра, м/сек:"
            font.pointSize: 20
        }
        Text {
            id: speed
            font.pointSize: 20
            color: "dark green"
        }
    }

    Row {
        id: row8
        anchors.top: row7.bottom
        topPadding: 10
        anchors.left: row7.left
        spacing: 5
        Text {
            text: "Облачность, %:"
            font.pointSize: 20
        }
        Text {
            id: clouds
            font.pointSize: 20
            color: "dark green"
        }
    }

    Button {
        id: but
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: row8.bottom
        anchors.topMargin: 20
        text: "Получить текущую погоду для г.Барнаул"
        onClicked: Fn.getData()
    }
}
