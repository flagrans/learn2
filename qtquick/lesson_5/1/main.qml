/*
так как методы отрисовки фигур отличаются, то нет смысла сохранять данные сначала в массив,
а затем вызывать функцию отрисовки фигур из массива точек, поэтому было принято решение
реализовать все сразу в функции, которая вызывается при смене вида фигуры.
*/
import QtQuick 2.15
import QtQuick.Controls 2.15

import "JavaScriptLibrary.js" as LibraryTest

Window {
    width: 600
    height: 600
    visible: true
    title: qsTr("Lesson #5_1")

    ComboBox {
        id: cb
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.topMargin: 10

        model: ["Звезда", "Кольцо", "Дом", "Песочные часы"]

        onActivated: {
            myCanvas.requestPaint()
        }
    }

    Canvas {
        id: myCanvas
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.setTransform(1, 0, 0, -1, myCanvas.width/2, myCanvas.height/2);
            ctx.clearRect(-1 * width/2, -1 * height/2, width, height);
            ctx.lineWidth = 3;
            ctx.beginPath();
            LibraryTest.paintFigure(cb.currentIndex, ctx);
            ctx.closePath();
            ctx.stroke();
        }
    }

    Component.onCompleted: {
        myCanvas.requestPaint()
    }
}
