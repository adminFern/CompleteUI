#include <QGuiApplication>
#include <QQmlApplicationEngine>
//#include "Administrative.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // 注册Administrative类到QML
    //qmlRegisterType<Administrative>("CompleteUI", 1, 0, "Administrative");
    const QUrl url(QStringLiteral("qrc:/qml/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    //  engine.loadFromModule("CompleteUI", "Main");
    engine.load(url);
    return QCoreApplication::exec();
}
