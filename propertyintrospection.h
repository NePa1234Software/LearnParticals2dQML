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
        Q_ASSERT(object);
        if (!object) {
            qWarning() << "write property failed (null object):" << property << value;
            return;
        }
        if (!object->setProperty(property.toLatin1(), value)) {
            int index = object->metaObject()->indexOfProperty(property.toLatin1());
            if (index == -1) {
                qWarning() << "write property failed (doesnt exist):" << property << value << object->objectName();
            } else {
                QMetaProperty meta = object->metaObject()->property(index);
                if (!meta.isWritable()) {
                    qWarning() << "write property failed (not writable):" << property << value << object->objectName();
                } else {
                    qWarning() << "write property failed:" << property << value << object->objectName();
                }
            }
            return;
        }
        qInfo() << "write property:" << property << value << object->objectName();
    }

    // read from the property name
    Q_INVOKABLE QVariant readProperty(QObject* object, const QString& property) const
    {
        Q_ASSERT(object);
        if (!object) {
            qWarning() << "read property failed (null object):" << property;
            return {};
        }

        int index = object->metaObject()->indexOfProperty(property.toLatin1());
        if (index == -1) {
            qWarning() << "read property failed (doesnt exist):" << property << object->objectName();
            return {};
        }

        QMetaProperty meta = object->metaObject()->property(index);
        if (!meta.isReadable()) {
            qWarning() << "read property failed (not readable):" << property << object->objectName();
            return {};
        }

        ////////////////
        // THIS CRASHES when used on list properties
        // auto retVal = QQmlProperty::read(object, property);
        // qWarning() << "you cannot read a list property:" << property;
        // return {};
        ////////////////
        auto retVal = object->property(property.toLatin1());
        qInfo() << "read property:" << property << retVal << object->objectName();
        return retVal;
    }
};
