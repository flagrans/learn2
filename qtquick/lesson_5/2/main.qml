import QtQuick 2.15
import QtQuick.Controls 2.15

Window {
    width: 600
    height: 600
    visible: true
    title: qsTr("Lesson #5_2")
    id: mainWin

    property string login: "login"
    property string password: "password"

    Loader {
        id: loader
        anchors.fill: parent
        onSourceChanged: animation.running = true

        NumberAnimation {
            id: animation
            target: loader.item
            property: "opacity"
            from: 0
            to: 1
            duration: 500
        }
    }

    Component.onCompleted: loader.source = "loginpage.qml"
}




//    Component {
//        id: loginpage
//        Rectangle {
//            color: "#b38982"
//            Text {
//                anchors.top: parent.top
//                anchors.topMargin: 20
//                anchors.horizontalCenter: parent.horizontalCenter
//                text: "Страница авторизации:"
//            }
//            Button {
//                anchors.bottom: parent.bottom
//                anchors.bottomMargin: 20
//                anchors.horizontalCenter: parent.horizontalCenter
//                text: "Войти"
//                onClicked: loader.sourceComponent = page_1
//            }
//        }
//    }


//    Component {
//        id: page_1
//        Rectangle {
//            color: "#82b3b1"
//            Text {
//                anchors.top: parent.top
//                anchors.topMargin: 20
//                anchors.horizontalCenter: parent.horizontalCenter
//                text: "Страница №1"
//            }
//            Button {
//                anchors.top: parent.top
//                anchors.topMargin: 20
//                anchors.right: parent.right
//                anchors.rightMargin: 20
//                text: "Вперед"
//                onClicked: {
//                    loader.sourceComponent = page_2
//                }
//            }
//            Button {
//                anchors.bottom: parent.bottom
//                anchors.bottomMargin: 20
//                anchors.horizontalCenter: parent.horizontalCenter
//                text: "Выход"
//                onClicked: loader.sourceComponent = loginpage
//            }
//        }
//    }

//    Component {
//        id: page_2
//        Rectangle {
//            color: "#86b382"
//            Text {
//                anchors.top: parent.top
//                anchors.topMargin: 20
//                anchors.horizontalCenter: parent.horizontalCenter
//                text: "Страница №2"
//            }
//            Button {
//                anchors.top: parent.top
//                anchors.topMargin: 20
//                anchors.left: parent.left
//                anchors.leftMargin: 20
//                text: "Назад"
//                onClicked: loader.sourceComponent = page_1
//            }
//            Button {
//                anchors.bottom: parent.bottom
//                anchors.bottomMargin: 20
//                anchors.horizontalCenter: parent.horizontalCenter
//                text: "Выход"
//                onClicked: loader.sourceComponent = loginpage
//            }
//        }
//    }
