import QtQuick 2.15
import QtQuick.Controls 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Lesson_7_1")
    id: mainWin

    property int cellHorizontalSpacing: 3
    property var db: undefined

    ComboBox {
        id: cb
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 3
        anchors.topMargin: 3
        model: ["users", "capitals", "price"]
        onCurrentIndexChanged: {
            loader.source = "./pages/" + model[cb.currentIndex] + ".qml"
        }
    }

    Loader {
        id: loader
        width: parent.width
        height: parent.height - cb.height - 13
        anchors.top: cb.bottom
        anchors.topMargin: 10
        onSourceChanged: animation.running = true

        NumberAnimation {
            id: animation
            target: loader.item
            property: "opacity"
            from: 0
            to: 1
            duration: 500
        }
    }
}
