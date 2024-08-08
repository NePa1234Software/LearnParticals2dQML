#pragma once
#include <QMetaObject>
#include <QObject>
#include <QQmlProperty>
#include <QQmlListProperty>

class PropertyIntrospection : public QObject {
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:

    // Provide the value type information of the property name
    Q_INVOKABLE int type(QObject* object, const QString& property) const
    {
        QQmlProperty qmlProperty(object, property);
        return qmlProperty.propertyType();
    }

    // Provide the value type information of the property name
    Q_INVOKABLE QQmlProperty::PropertyTypeCategory typeCategory(QObject* object, const QString& property) const
    {
        QQmlProperty qmlProperty(object, property);
        return qmlProperty.propertyTypeCategory();
    }

    // Provide the value type information of the property name
    Q_INVOKABLE QString typeName(QObject* object, const QString& property) const
    {
        QQmlProperty qmlProperty(object, property);
        return qmlProperty.propertyTypeName();
    }

    // Provide the readonly information of the property name
    Q_INVOKABLE bool isReadonly(QObject* object, const QString& property) const
    {
        QQmlProperty qmlProperty(object, property);
        return !qmlProperty.isWritable();
    }

    // write to the property name
    Q_INVOKABLE void writeProperty(QObject* object, const QString& property, const QVariant & value)
    {
        if (!object->setProperty(property.toLatin1(), value)) {
            qWarning() << "write property failed:" << property << value;
        }
    }

    // read from the property name
    Q_INVOKABLE QVariant readProperty(QObject* object, const QString& property) const
    {
        ////////////////
        // THIS CRASHES when used on list properties
        // auto retVal = QQmlProperty::read(object, property);
        // qWarning() << "you cannot read a list property:" << property;
        // return {};
        ////////////////
        auto retVal = object->property(property.toLatin1());
        return retVal;
    }
};
