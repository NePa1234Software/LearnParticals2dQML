#pragma once
#include <QMetaObject>
#include <QObject>
#include <QQmlProperty>

class PropertyIntrospection : public QObject {
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:

    // Provide the value type information of the property name
    Q_INVOKABLE QString typeName(QObject* object, const QString& property) const
    {
        QQmlProperty qmlProperty(object, property);
        QMetaProperty metaProperty = qmlProperty.property();
        return metaProperty.typeName();
    }

    // Provide the readonly information of the property name
    Q_INVOKABLE bool isReadonly(QObject* object, const QString& property) const
    {
        QQmlProperty qmlProperty(object, property);
        QMetaProperty metaProperty = qmlProperty.property();
        return !metaProperty.isWritable();
    }

    // write to the property name
    Q_INVOKABLE void writeProperty(QObject* object, const QString& property, const QVariant & value)
    {
        QQmlProperty::write(object, property, value);
    }

    // read from the property name
    Q_INVOKABLE QVariant readProperty(QObject* object, const QString& property) const
    {
        return QQmlProperty::read(object, property);
    }
};
