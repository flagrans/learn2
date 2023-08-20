import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    width: 600
    height: 600
    visible: true
    title: qsTr("Lesson_7_2")

    function getFriendsText(friends) {
        var resString = ""
        for (const friend of friends) {
            resString += friend + ", "
        }
        return resString.slice(0, -2);
    }

    ListView {
        anchors.fill:parent
        model: mdl
        spacing: 2
        interactive: false
        delegate: SwipeView {
            width: parent.width
            height: 40
            Item {
                Row {
                    anchors.fill: parent
                    spacing: 2
                    Rectangle {
                        id: rid
                        width: 70
                        height: parent.height
                        border.width: 1
                        Text {
                            anchors.centerIn: parent
                            text: rowId
                        }
                    }
                    Rectangle {
                        width: (parent.width - rid.width) / 2
                        height: parent.height
                        border.width: 1
                        Text {
                            anchors.centerIn: parent
                            text: name
                        }
                    }

                    Rectangle {
                        width: (parent.width - rid.width) / 2
                        height: parent.height
                        border.width: 1
                        Text {
                            anchors.centerIn: parent
                            text: surname
                        }
                    }
                }
            }
            Item {
                Row {
                    anchors.fill: parent
                    spacing: 2
                    Rectangle {
                        id: rtextid
                        width: 70
                        height: parent.height
                        border.width: 1
                        Text {
                            anchors.centerIn: parent
                            text: rowId
                        }
                    }
                    Rectangle {
                        id: rtext
                        width: innerText.width + 30
                        height: parent.height
                        border.width: 1
                        Text {
                            id: innerText
                            anchors.centerIn: parent
                            text: "Друзья " + name + " " + surname + ":"
                        }
                    }
                    Rectangle {
                        width: parent.width - rtextid.width - rtext.width
                        height: parent.height
                        border.width: 1
                        Text {
                            anchors.fill: parent
                            text: getFriendsText(friends)
                            wrapMode: Text.WordWrap
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
        }

        header: Row {
            width: parent.width
            height: 40
            spacing: 2
            Rectangle {
                id: hidd
                width: 70
                height: parent.height
                border.width: 1
                Text {
                    anchors.centerIn: parent
                    text: "ID"
                }
            }

            Rectangle {
                width: (parent.width - hidd.width) / 2
                height: parent.height
                border.width: 1
                Text {
                    anchors.centerIn: parent
                    text: "Имя"
                }
            }

            Rectangle {
                width: (parent.width - hidd.width) / 2
                height: parent.height
                border.width: 1
                Text {
                    anchors.centerIn: parent
                    text: "Фамилия"
                }
            }
        }
    }
}
