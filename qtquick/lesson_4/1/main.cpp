#include "graphics.h"
#include <QApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    //    Graphics graphics;

    //    QObject::connect(&graphics, &Graphics::typeChanged, &graphics,
    //                     &Graphics::onTypeChanged);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/1/main.qml"_qs);
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &app,
        [url](QObject *obj, const QUrl &objUrl)
        {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    qmlRegisterType<Graphics>("ru.gb.Graphics", 1, 0, "Graphics");

    engine.load(url);

    return app.exec();
}
