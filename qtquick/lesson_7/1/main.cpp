#include <QDebug>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/1/main.qml"));
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &app,
        [url](QObject *obj, const QUrl &objUrl)
        {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    //    qDebug() << "Путь к папке с локальным хранилищем: "
    //             << engine.offlineStoragePath();
    //    qDebug() << "Полный путь к бд: "
    //             << engine.offlineStorageDatabaseFilePath("DBExample");
    engine.load(url);
    return app.exec();
}

//#include <QGuiApplication>
//#include <QQmlApplicationEngine>

// int main(int argc, char *argv[])
//{
//     QGuiApplication app(argc, argv);

//    QQmlApplicationEngine engine;
//    const QUrl url(u"qrc:/1/main.qml"_qs);
//    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
//                     &app, [url](QObject *obj, const QUrl &objUrl) {
//        if (!obj && url == objUrl)
//            QCoreApplication::exit(-1);
//    }, Qt::QueuedConnection);
//    engine.load(url);

//    return app.exec();
//}
