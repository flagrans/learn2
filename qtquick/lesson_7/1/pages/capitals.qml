import QtQuick 2.15
import Qt.labs.qmlmodels 1.0
import QtQuick.Controls 2.15
import QtQuick.LocalStorage 2.15

import "../funcs/CapitalsFunctions.js" as CapitalsFunctions

Item {

    TableModel {
        id: tableModel
        TableModelColumn { display: "id" }
        TableModelColumn { display: "country" }
        TableModelColumn { display: "capital" }
        TableModelColumn { display: "del" }
        rows: []
    }

    TableView {
        id: table
        anchors.fill: parent
        columnSpacing: 1
        rowSpacing: 1
        model: tableModel
        interactive : false
        delegate: DelegateChooser {

            DelegateChoice {
                column: 3
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
                                                   CapitalsFunctions.delCapital(tx, tableModel.rows[model.row].id);
                                               })
                                tableModel.clear()
                                db.transaction((tx) => { CapitalsFunctions.readCapitals(tx, table.model) })
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
                                                   var resObj = CapitalsFunctions.updateCapital(tx, tableModel.rows[model.row].id, innerText.text, header);
                                               })
                            } catch (err) {
                                console.log("Error creating or updating table in database: " + err)
                            }
                        }
                        onEditingFinished: { }
                        onActiveFocusChanged: {
                            activeFocus ? tr.color = tr.color.darker() : tr.color = "#efefef"
                        }
                    }
                }
            }
        }
    }

    Dialog {
        id: dialog
        anchors.centerIn: parent
        title: "Добавить строку"
        standardButtons: Dialog.Ok | Dialog.Cancel
        Column {
            anchors.fill: parent
            spacing: 5
            TextField {
                id: country
                placeholderText: "Страна"
            }
            TextField {
                id: capital
                placeholderText: "Столица"
            }
        }
        onAccepted: {
            try {
                db.transaction((tx) => {
                                   var resObj = CapitalsFunctions.addCapital(tx, country.text, capital.text);
                                   if (resObj.rowsAffected !== 0) {
                                       tableModel.appendRow({id: resObj.insertId, country: country.text, capital: capital.text, del: ""})
                                   }
                               })
                tableModel.clear()
                db.transaction((tx) => { CapitalsFunctions.readCapitals(tx, table.model) })
            } catch (err) {
                console.log("Error creating or updating table in database: " + err)
            }
            country.clear()
            capital.clear()
        }
    }

    Button {
        id: button
        text: "Добавить столицу"
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
            db.transaction(CapitalsFunctions.createTable);

            //            db.transaction((tx) => {
            //                               CapitalsFunctions.addCapital(tx, "Россия", "Москва")
            //                               CapitalsFunctions.addCapital(tx, "Великобритания", "Лондон")
            //                               CapitalsFunctions.addCapital(tx, "Франция", "Париж")
            //                           })

            db.transaction((tx) => { CapitalsFunctions.readCapitals(tx, table.model) })
        } catch (err) {
            console.log("Error creating or updating table in database: " + err)
        }
    }
}
