import QtQuick 2.15
import QtQuick.Controls 2.15

Window {
    width: 600
    height: 600
    visible: true
    title: qsTr("Lesson #6_1")
    id: mainwin

    property string apiToken: "T3nkni16v3QSqtqKNzDxFwKr7bdae7V2nhGxgjKi"
    property string image: ""

    Item {
        z:1
        anchors.fill: parent
        anchors.topMargin: 20
        Button {
            id: but1
            anchors.left: parent.left
            anchors.leftMargin: (mainwin.width - (3 * but1.width + 80)) / 2
            text: "Запрос №1"
            onClicked: {
                getData("https://api.nasa.gov/planetary/apod?", 1);
            }
        }
        Button {
            id: but2
            anchors.left: but1.right
            anchors.leftMargin: 20
            text: "Запрос №2"
            onClicked: {
                getData("https://api.nasa.gov/planetary/earth/assets?lon=-0.006866&lat=51.543346&date=" + getRandomDate(2000) + "&&dim=0.1&", 1);
            }
        }
        Button {
            id: but3
            anchors.left: but2.right
            anchors.leftMargin: 20
            text: "Запрос №3"
            onClicked: {
                getData("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=" + getRandomDate(2015) + "&", 2);
            }
        }
    }
    Image {
        z: 0
        anchors.fill: parent
        source: image
    }
    function getData(url, numreq) {
        var xmlhttp = new XMLHttpRequest();
        url = url + "api_key=" + apiToken;
        xmlhttp.open('GET', url);
        xmlhttp.responseType = 'json';

        print(`Запрос: ` + url);

        xmlhttp.send();

        xmlhttp.onload = function() {
          if (xmlhttp.status != 200) {
            print(`Ошибка ${xmlhttp.status}: ${xmlhttp.statusText}`);
          } else {
              print(`Готово, получили: ${xmlhttp.responseText}`);
              if(numreq === 1) {
              image =  parseRequest1(xmlhttp.responseText, "url");
              }
              if(numreq === 2) {
              image =  parseRequest2(xmlhttp.responseText);
              }

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

    function parseRequest1(response, key) {
        var jsonObj = JSON.parse(response);
        return jsonObj[key];
    }

    function parseRequest2(response) {
        var jsonObj = JSON.parse(response);
        return jsonObj["photos"][0]["img_src"];
    }

    function getRandomDate(minYear) {
        const maxDate = Date.now();
        var timestamp = Math.floor(Math.random() * maxDate);
        var retDate =  new Date(timestamp);
        while (retDate.getFullYear() < minYear) {
            timestamp = Math.floor(Math.random() * maxDate);
            retDate =  new Date(timestamp);
        }
        return retDate.toISOString().slice(0, 10);
    }
}
