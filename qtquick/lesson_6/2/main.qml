import QtQuick 2.15
import QtQuick.Controls 2.15

Window {
    width: 600
    height: 200
    visible: true
    title: qsTr("Lesson #6_2")
    id: mainwin

    property string apiToken: "eb9e587bee520cb76ad005a3a1ca01e5"

    Text {
        id: text
        anchors.horizontalCenter: parent.horizontalCenter
        text: "В связи с ограниченным числом запросов к API. Расчет производится по кнопке а не динамически."
    }

    Row {
        id: row1
        anchors.top: text.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        topPadding: 10
        spacing: 5
        Text {
            text: "Отдам:"
            font.pointSize: 20
        }
        TextField {
            id: r1tf
            font.pointSize: 20
            width: 220
            selectByMouse: true
            placeholderText: "Введите сумму"

        }
        ComboBox {
            id: r1cb
            font.pointSize: 20
            model: ["RUB", "USD", "EUR", "KZT"]
            height: 45
        }
    }

    Row {
        id: row2
        anchors.top: row1.bottom
        anchors.right: row1.right
        topPadding: 10
        spacing: 5
        Text {
            font.pointSize: 20
            text: "Получу:"
        }
        TextField {
            id: r2tf
            font.pointSize: 20
            readOnly: true
            width: 220
            selectByMouse: true

        }
        ComboBox {
            id: r2cb
            font.pointSize: 20
            model: ["RUB", "USD", "EUR", "KZT"]
            height: 45
        }
    }

    Button {
        id: but
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: row2.bottom
        anchors.topMargin: 20
        text: "Посчитать"
        onClicked: {
            getData(r1cb.currentText, r2cb.currentText)
    }
}

    function getData(v1, v2) {
        if (isNaN(Number(r1tf.text))) {
            r1tf.clear();
            return
        } else if(v1 === v2) {
            r2tf.text = r1tf.text;
            return
        }
        var xmlhttp = new XMLHttpRequest();
        var url = "https://currate.ru/api/?get=rates&key=" + apiToken + "&pairs=" + v1 + v2;
        xmlhttp.open('GET', url);
        xmlhttp.responseType = 'json';

        print(`Запрос: ` + url);

        xmlhttp.send();

        xmlhttp.onload = function() {
          if (xmlhttp.status != 200) {
            print(`Ошибка ${xmlhttp.status}: ${xmlhttp.statusText}`);
          } else {
              print(`Готово, получили: ${xmlhttp.responseText}`);
              r2tf.text = (parseRequest(xmlhttp.responseText, v1 + v2) * r1tf.text).toFixed(2);
          }
        };

        xmlhttp.onprogress = function(event) {
          if (event.lengthComputable) {
            print(`Получено ${event.loaded} из ${event.total} байт`);
          } else {
            print(`Получено ${event.loaded} байт`);
          }

        };

        xmlhttp.onerror = function() {
          print("Запрос не удался");
        };
    }

    function parseRequest(response, key) {
        var jsonObj = JSON.parse(response);
        return jsonObj.data[key];
    }
}
