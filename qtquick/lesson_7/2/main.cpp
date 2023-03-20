#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QVariant>
#include <qmltablemodel.h>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/2/Main.qml"_qs);
    QObject::connect(
        &engine, &QQmlApplicationEngine::objectCreated, &app,
        [url](QObject *obj, const QUrl &objUrl)
        {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    QMLTableModel model;
    model.appendRowElement(QMLTableModel::RowElement{
        1, "Ivan", "Ivanov", {"Sergey Stepanov", "Egor Potapov"}});
    model.appendRowElement(QMLTableModel::RowElement{
        2,
        "Egor",
        "Svistov",
        {"Oleg Zarelua", "Alexander Zotov", "Elena Ivanova"}});
    model.appendRowElement(QMLTableModel::RowElement{
        3,
        "Stepan",
        "Tok",
        {"Ivan Ivanov", "Alexander Zotov", "Elena Ivanova"}});

    engine.rootContext()->setContextProperty("mdl", &model);

    //    QStringList dataList = {"Item 1", "Item 2", "Item 3", "Item 4"};
    //    engine.rootContext()->setContextProperty("dataList",
    //                                             QVariant::fromValue(dataList));

    engine.load(url);

    return app.exec();
}
