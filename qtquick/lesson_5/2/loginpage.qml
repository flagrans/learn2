 import QtQuick 2.15
 import QtQuick.Controls 2.15

Rectangle {
    color: "#b38982"
    Text {
        id: textpage
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Страница авторизации:"
    }
    TextField {
        id: loginField
        width: 200
        height: 34
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: textpage.bottom
        anchors.topMargin: 30
        font.pointSize: 14
        placeholderText: "login"
    }
    TextField {
        id: passField
        width: 200
        height: 34
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: loginField.bottom
        anchors.topMargin: 30
        font.pointSize: 14
        placeholderText: "password"
        echoMode: TextInput.Password
    }

    Text {
        id: warning
        color: "red"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: passField.bottom
        anchors.topMargin: 20
        font.pointSize: 12
        text: "Неверное имя пользователя или пароль."
        visible: false
    }

    Button {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Войти"
        onClicked: {
            if (passField.text === password && loginField.text === login) {
                loader.source = "page1.qml"
                warning.visible = false
            } else {
                passField.text = ""
                loginField.text = ""
                warning.visible = true
            }
        }
    }
}
