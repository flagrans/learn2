#pragma once

#include <QColor>
#include <QObject>

enum typeGraphics
{
    SINUSX,
    YX,
    YX25,
    YXX,
    YLOG2X
};

class Graphics : public QObject
{
    Q_OBJECT

    Q_PROPERTY(typeGraphics m_type WRITE setType NOTIFY typeChanged)

    void setType(typeGraphics);
    void nameParamChanged();

  public:
    explicit Graphics(QObject *parent = nullptr);

    Q_INVOKABLE QColor getColor() const;
    Q_INVOKABLE void setColor(const QColor &);

    Q_INVOKABLE QString getNameParam() const;

    Q_INVOKABLE void changeType();

    Q_INVOKABLE int getSizeVector() const;
    Q_INVOKABLE qreal getX(int) const;
    Q_INVOKABLE qreal getY(int) const;

  signals:
    void typeChanged();

  private:
    QColor m_color;
    QString m_nameParam;
    typeGraphics m_type;
    QVector<qreal> _xValueVector;
    QVector<qreal> _yValueVector;
};
