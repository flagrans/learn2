function getData() {
    var xmlhttp = new XMLHttpRequest();
    var url = "https://api.openweathermap.org/data/2.5/weather?lat=53.347402&lon=83.7784496&appid=" + apiToken;
    xmlhttp.open('GET', url);
    xmlhttp.responseType = 'json';

    print(`Запрос: ` + url);

    xmlhttp.send();

    xmlhttp.onload = function() {
      if (xmlhttp.status != 200) {
        print(`Ошибка ${xmlhttp.status}: ${xmlhttp.statusText}`);
      } else {
          print(`Готово, получили: ${xmlhttp.responseText}`);
          parseRequest(xmlhttp.responseText);
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

function parseRequest(response) {
    var jsonObj = JSON.parse(response);
    city.text = jsonObj.name; // Город
    curTemp.text = (jsonObj.main.temp - 273.15).toFixed(0); // Текущая температура
    feelsLike.text = (jsonObj.main.feels_like - 273.15).toFixed(0); // Ощущается как
    pressure.text = (jsonObj.main.pressure * 0.75).toFixed(0); // Давление * 0,75
    humidity.text = jsonObj.main.humidity; // Влажность
    visibility.text = jsonObj.visibility; // Видимость
    speed.text = jsonObj.wind.speed; // Скорость ветра
    clouds.text = jsonObj.clouds.all; // Облачность
}
