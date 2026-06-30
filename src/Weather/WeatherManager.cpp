#include "WeatherManager.h"

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>

#include <QJsonDocument>
#include <QJsonObject>

#include <QDebug>

WeatherManager::WeatherManager(QObject *parent)
    : QObject(parent)
{
    _networkManager = new QNetworkAccessManager(this);

    connect(_networkManager,
            &QNetworkAccessManager::finished,
            this,
            &WeatherManager::_handleReply);
}

void WeatherManager::fetchWeather(double latitude,
                                  double longitude)
{
    QString url =
        QString(
            "https://api.open-meteo.com/v1/forecast?"
            "latitude=%1"
            "&longitude=%2"
            "&current="
            "temperature_2m,"
            "relative_humidity_2m,"
            "wind_speed_10m,"
            "wind_direction_10m"
            )
            .arg(latitude)
            .arg(longitude);

    qDebug() << url;

    _networkManager->get(
        QNetworkRequest(QUrl(url)));
}

void WeatherManager::_handleReply(QNetworkReply* reply)
{
    QByteArray data = reply->readAll();

    QJsonDocument doc =
        QJsonDocument::fromJson(data);

    QJsonObject current =
        doc.object()["current"].toObject();

    _temperature =
        current["temperature_2m"].toDouble();

    _humidity =
        current["relative_humidity_2m"].toDouble();

    _windSpeed =
        current["wind_speed_10m"].toDouble();

    _windDirection =
        current["wind_direction_10m"].toDouble();

    emit weatherUpdated();

    qDebug() << "Temp:" << _temperature;
    qDebug() << "Humidity:" << _humidity;
    qDebug() << "Wind:" << _windSpeed;

    reply->deleteLater();
}