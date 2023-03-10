import QtQuick 2.15
import QtQuick.Controls 2.15

    Rectangle {
        color: "#82b3b1"
        Text {
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Страница №1"
        }
        Button {
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20
            text: "Вперед"
            onClicked: loader.source = "page2.qml"
        }
        Button {
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Выход"
            onClicked: loader.source = "loginpage.qml"
        }
    }
