#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSettings>
#include <QStandardPaths>
#include <QQuickStyle>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setOrganizationName("LearnQML");
    app.setOrganizationDomain("LearnQML_Particles");
    app.setApplicationName("LearnQML_Particles");

    QQuickStyle::setStyle("Material");

    // Global settings for QML Settings Item
    QSettings::setDefaultFormat(QSettings::IniFormat);
    QSettings::setPath(QSettings::IniFormat, QSettings::UserScope, QStandardPaths::writableLocation(QStandardPaths::TempLocation));
    QSettings tmpSettings;
    qInfo() << "Main: setting: appname:" << tmpSettings.applicationName();
    qInfo() << "Main: setting:    path:" << tmpSettings.fileName();
    qInfo() << "Main: setting:  format:" << tmpSettings.format();
    qInfo() << "Main: setting:   scope:" << tmpSettings.scope();

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("LearnParticals2dQML", "Main");

    return app.exec();
}
