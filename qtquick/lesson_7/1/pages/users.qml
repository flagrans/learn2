import QtQuick 2.15
import Qt.labs.qmlmodels 1.0
import QtQuick.Controls 2.15
import QtQuick.LocalStorage 2.15
import QtQuick.Layouts

import "../funcs/UsersFunctions.js" as UsersFunctions

Item {

    TableModel {
        id: tableModel
        TableModelColumn { display: "id" }
        TableModelColumn { display: "first_name" }
        TableModelColumn { display: "last_name" }
        TableModelColumn { display: "email" }
        TableModelColumn { display: "phone" }
        TableModelColumn { display: "del" }
        rows: []
    }
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        HorizontalHeaderView {
            id: horizontalHeader
            syncView: table
            height: 30
            columnSpacing: 1
            rowSpacing: 1

            reuseItems: false
            Layout.fillWidth: true
            boundsBehavior:Flickable.StopAtBounds
            delegate: Rectangle {
                id: columnHeader
                color: "#efefef"
                border.color: "#bbb"
                border.width: 1
                implicitWidth: Math.max(100, cellHorizontalSpacing * 2 + headerText.width)
                implicitHeight: 30
                z: -1

                Text {
                    id: headerText
                    anchors.centerIn: parent
                    text: model.display
                }
            }
        }

        TableView {
            id: table
            columnSpacing: 1
            rowSpacing: 1
            model: tableModel
            interactive : false

            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            boundsBehavior:Flickable.StopAtBounds

            delegate: DelegateChooser {

                DelegateChoice {
                    column: 5
                    delegate: Rectangle {
                        implicitWidth: Math.max(100, cellHorizontalSpacing * 2 + delRow.width)
                        implicitHeight: 50
                        border.width: 0
                        z: -1
                        Button {
                            id: delRow
                            text: "Удалить"
                            anchors.centerIn: parent
                            onClicked: {
                                try {
                                    db.transaction((tx) => {
                                                       UsersFunctions.delContact(tx, tableModel.rows[model.row].id);
                                                   })
                                    tableModel.clear()
                                    db.transaction((tx) => { UsersFunctions.readContacts(tx, table.model) })
                                } catch (err) {
                                    console.log("Error creating or updating table in database: " + err)
                                }
                            }
                        }
                    }
                }
                DelegateChoice {
                    column: 0
                    delegate: Rectangle {
                        implicitWidth: Math.max(10, cellHorizontalSpacing * 2 + innerT.width)
                        implicitHeight: 50
                        border.width: 1
                        color: "#efefef"
                        z: -1
                        Text {
                            id: innerT
                            text: model.display
                            padding: 12
                        }
                    }
                }
                DelegateChoice {
                    id: ch
                    delegate: Rectangle {
                        id: tr
                        implicitWidth: Math.max(100, cellHorizontalSpacing * 2 + innerText.width)
                        implicitHeight: 50
                        border.width: 1
                        color: "#efefef"
                        z: -1

                        TextInput {
                            id: innerText
                            text: model.display
                            padding: 12
                            selectByMouse: true

                            onAccepted: {
                                model.display = text
                                var header = tableModel.columns[model.column].display
                                try {
                                    db.transaction((tx) => {
                                                       var resObj = UsersFunctions.updateContact(tx, tableModel.rows[model.row].id, innerText.text, header);
                                                   })
                                } catch (err) {
                                    console.log("Error creating or updating table in database: " + err)
                                }
                            }
                            onActiveFocusChanged: {
                                activeFocus ? tr.color = tr.color.darker() : tr.color = "#efefef"
                            }
                        }
                    }
                }
            }
        }
    }


    Dialog {
        id: dialog
        anchors.centerIn: parent
        title: "Add person"
        standardButtons: Dialog.Ok | Dialog.Cancel
        Column {
            anchors.fill: parent
            spacing: 5
            TextField {
                id: firstName
                placeholderText: "Имя"
            }
            TextField {
                id: lastName
                placeholderText: "Фамилия"
            }
            TextField {
                id: email
                placeholderText: "E-mail"
            }
            TextField {
                id: phone
                placeholderText: "Номер телефона"
            }
        }
        onAccepted: {
            try {
                db.transaction((tx) => {
                                   var resObj = UsersFunctions.addContact(tx, firstName.text, lastName.text, email.text, phone.text);
                                   if (resObj.rowsAffected !== 0) {
                                       tableModel.appendRow({id: resObj.insertId, first_name: firstName.text, last_name: lastName.text, email: email.text, phone: phone.text, del: ""})
                                   }
                               })
                tableModel.clear()
                db.transaction((tx) => { UsersFunctions.readContacts(tx, table.model) })
            } catch (err) {
                console.log("Error creating or updating table in database: " + err)
            }
            firstName.clear()
            lastName.clear()
            email.clear()
            phone.clear()
        }
    }

    Button {
        id: button
        text: "Добавить человека"
        width: parent.width
        height: 50
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: dialog.open()
    }

    Component.onCompleted: {
        var data_array = ListModel
        db = LocalStorage.openDatabaseSync("DBExample", "1.0", "Пример локальной базы данных", 1000)
        try {
            db.transaction(UsersFunctions.createTable);

//                                    db.transaction((tx) => {
//                                                       UsersFunctions.addContact(tx, "Makarov", "Иванi4", "ivanoviv2182@mail.ru",
//                                                                                 "+7(988)37333112")
//                                                       UsersFunctions.addContact(tx, "Заварнов", "Владимир", "zavlad@mail.ru",
//                                                                                 "+7(977)98373331")
//                                                       UsersFunctions.addContact(tx, "Говорун", "Максим", "landlord2000@mail.ru",
//                                                                                 "+7(977)3311111")
//                                                   })

            db.transaction((tx) => { UsersFunctions.readContacts(tx, table.model) })
        } catch (err) {
            console.log("Error creating or updating table in database: " + err)
        }
    }
}
