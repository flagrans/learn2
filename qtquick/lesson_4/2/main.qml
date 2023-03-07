import QtQuick 2.15
import QtCharts 2.15
import QtQuick.Controls 2.15

Window {
    property double a: 0
    property double b: 0
    property variant pointsX: [7, 31, 61, 99, 129, 178, 209]
    property variant pointsY: [13, 10, 9, 10, 12, 20, 26]

    width: 640
    height: 480
    visible: true
    title: qsTr("Lesson#4_2")

    ValueAxis{
        id: valueAxisX
        min: 0
        max: 220
    }
    ValueAxis{
        id: valueAxisY
        min: 5
        max: 31
    }

    ChartView {
        title: "Scatters и Метод Наименьших Квадратов"
        anchors.fill: parent
        antialiasing: true
        id: chartA

        ScatterSeries {
            id: scatter1
            name: "Точки X и Y"
            color: "#FF0000"
            axisX: valueAxisX
            axisY: valueAxisY
        }
        LineSeries {
            id: line1
            name: "Линия по МНК"
            color: "#00FF00"
            width: 3
        }
    }
    Component.onCompleted: {
        mnk();
        for (let i = 0; i < pointsX.length; i++) {
            scatter1.append(pointsX[i], pointsY[i]);
            line1.append(pointsX[i], (a * pointsX[i] + b));
        }

    }

    function mnk() {
        var sumX = 0;
        var sumY = 0;
        var sumX2 = 0;
        var sumXY = 0;
        var sizeArray = pointsX.length;
        for (let i = 0; i < sizeArray; i++) {
            sumX = sumX + pointsX[i];
            sumY = sumY + pointsY[i];
            sumX2 = sumX2 + pointsX[i] * pointsX[i];
            sumXY = sumXY + pointsX[i] * pointsY[i];
        }
        b = (sumXY * sumX - sumY * sumX2) / (sumX * sumX - sizeArray * sumX2);
        a = (sumY - b * sizeArray) / sumX;
    }
}

