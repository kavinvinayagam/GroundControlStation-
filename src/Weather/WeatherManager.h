#pragma once

#include <QObject>

class QNetworkAccessManager;
class QNetworkReply;

class WeatherManager : public QObject
{
    Q_OBJECT

    Q_PROPERTY(double temperature READ temperature NOTIFY weatherUpdated)
    Q_PROPERTY(double humidity READ humidity NOTIFY weatherUpdated)
    Q_PROPERTY(double windSpeed READ windSpeed NOTIFY weatherUpdated)
    Q_PROPERTY(double windDirection READ windDirection NOTIFY weatherUpdated)

   public:
    explicit WeatherManager(QObject *parent = nullptr);

    double temperature() const { return _temperature; }
    double humidity() const { return _humidity; }
    double windSpeed() const { return _windSpeed; }
    double windDirection() const { return _windDirection; }

    Q_INVOKABLE void fetchWeather(double latitude,
                                  double longitude);

   signals:
    void weatherUpdated();

   private slots:
    void _handleReply(QNetworkReply* reply);

   private:
    QNetworkAccessManager* _networkManager;

    double _temperature = 0;
    double _humidity = 0;
    double _windSpeed = 0;
    double _windDirection = 0;
};