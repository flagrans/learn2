import QtQuick 2.15
import QtCharts 2.15
import QtQuick.Controls 2.15

import ru.gb.Graphics 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Lesson #4_1")

    Graphics {
        id: graphicsData
        onTypeChanged: {
            lineSeries.name = graphicsData.getNameParam()
            lineSeries.color = graphicsData.getColor()
            for (var i = 0; i < graphicsData.getSizeVector(); i++)
            {
                lineSeries.replace(i, graphicsData.getX(i), graphicsData.getY(i));
            }
        }
    }

    ValueAxis{
        id: valueAxisX
        min: 0.0
        max: 5.0
    }
    ValueAxis{
        id: valueAxisY
        min: -2.5
        max: 25.0
    }
    ChartView {
        title: "Нажмите ЛКМ для смены графика"
        anchors.fill: parent
        antialiasing: true
        LineSeries {
            id: lineSeries
            name: graphicsData.getNameParam()
            color: graphicsData.getColor()
            axisX: valueAxisX
            axisY: valueAxisY

            Component.onCompleted: {
                for (var i = 0; i < graphicsData.getSizeVector(); i++)
                {
                    lineSeries.append(graphicsData.getX(i), graphicsData.getY(i));
                }
            }
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                graphicsData.setColor('#' + (0x1000000 + Math.random() * 0xFFFFFF).toString(16).substr(1,6))
                graphicsData.changeType()
            }
        }
    }
}
