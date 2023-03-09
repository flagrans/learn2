import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    color: "#86b382"
    Text {
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Страница №2"
    }
    Button {
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        text: "Назад"
        onClicked: loader.source = "page1.qml"
    }
    Button {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Выход"
        onClicked: loader.source = "loginpage.qml"
    }
}
