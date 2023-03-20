import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id:mainWin
    width: 600
    height: 600
    visible: true
    title: qsTr("Lesson_7_3")

    Item {
        id:i1
        width: parent.width
        height: 50
        CTextField {
            id: cft
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            placeholderText: "Custom TextField"
        }
        TextField {
            anchors.left: cft.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            placeholderText: "Standart TextField"
        }
    }

    Item {
        id: i2
        width: parent.width
        height: bt1.height
        anchors.top: i1.bottom
        anchors.topMargin: 20
        Button {
            id: bt1
            anchors.left: parent.left
            anchors.leftMargin: 10
            text: "Open standart popup"
            onClicked: popup.open()
        }
        Button {
            anchors.left: bt1.right
            anchors.leftMargin: 10
            text: "Open custom popup"
            onClicked: popup2.open()
        }
    }

    Item {
        id: i3
        width: parent.width
        anchors.top: i2.bottom
        anchors.topMargin: 20
        ComboBox {
            id:cb1
            anchors.left: parent.left
            anchors.leftMargin: 10
            model: ["First", "Second", "Third"]
        }
        CComboBox {
            anchors.left: cb1.right
            anchors.leftMargin: 10
            model: ["First", "Second", "Third"]
        }
    }

    Popup {
        id: popup
        x: (mainWin.width - width) /2
        y: (mainWin.height - height) /2
        width: 200
        height: 300
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        Text {
            text: "Standart popup\nclose press \"Esc\""
        }
    }

    CPopup {
        id: popup2
        x: (mainWin.width - width) /2
        y: (mainWin.height - height) /2
        width: 200
        height: 300
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        Text {
            text: "Custom popup\nclose press \"Esc\""
        }
    }
}
