#include "graphics.h"
#include <QDebug>

Graphics::Graphics(QObject *parent)
    : QObject{parent}
{
    for (auto i = 0; i <= 50; i++)
    {
        _xValueVector.append(i * 0.1);
        _yValueVector.append(qSin(_xValueVector.last()));
    }
    m_type = typeGraphics::SINUSX;
    m_color = QColor::fromRgb(255, 0, 0);
    m_nameParam = "График функции: y = sin(x)";
}

QColor Graphics::getColor() const { return m_color; }

void Graphics::setColor(const QColor &color) { m_color = color; }

QString Graphics::getNameParam() const { return m_nameParam; }

void Graphics::setType(typeGraphics type)
{
    m_type = type;

    _yValueVector.clear();
    for (auto i : _xValueVector)
    {
        switch (m_type)
        {
        case (typeGraphics::SINUSX):
        {
            _yValueVector.append(qSin(i));
            break;
        }
        case (typeGraphics::YX):
        {
            _yValueVector.append(i);
            break;
        }
        case (typeGraphics::YX25):
        {
            _yValueVector.append(qFabs(i - 2.5));
            break;
        }
        case (typeGraphics::YXX):
        {
            _yValueVector.append(i * i);
            break;
        }
        case (typeGraphics::YLOG2X):
        {
            _yValueVector.append(qLn(i));
            break;
        }
        default:
            _yValueVector.append(qSin(i));
        }
    }

    nameParamChanged();

    emit typeChanged();
}

void Graphics::nameParamChanged()
{
    switch (m_type)
    {
    case (typeGraphics::SINUSX):
    {
        m_nameParam = "График функции: y = sin(x)";
        break;
    }
    case (typeGraphics::YX):
    {
        m_nameParam = "График функции: y = x";
        break;
    }
    case (typeGraphics::YX25):
    {
        m_nameParam = "График функции: y = |x - 2.5|";
        break;
    }
    case (typeGraphics::YXX):
    {
        m_nameParam = "График функции: y = x^2";
        break;
    }
    case (typeGraphics::YLOG2X):
    {
        m_nameParam = "График функции: y = log2(x)";
        break;
    }
    default:
        m_nameParam = "График функции: y = sin(x)";
    }
}

int Graphics::getSizeVector() const { return _xValueVector.size(); }

qreal Graphics::getX(int i) const { return _xValueVector.value(i); }

qreal Graphics::getY(int i) const { return _yValueVector.value(i); }

void Graphics::changeType()
{
    int currentType = static_cast<int>(m_type);

    currentType++;
    if (currentType > 4)
        currentType = 0;

    typeGraphics newType = static_cast<typeGraphics>(currentType);
    setType(newType);
}
