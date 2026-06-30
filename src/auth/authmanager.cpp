#include "authmanager.h"

#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QUrl>
#include <QDebug>

AuthManager::AuthManager(QObject *parent)
    : QObject(parent)
{
}

bool AuthManager::loggedIn() const
{
    return _loggedIn;
}

QString AuthManager::token() const
{
    return _token;
}

QString AuthManager::role() const
{
    return _role;
}

void AuthManager::login(
    const QString &email,
    const QString &password)
{
    QUrl url("https://droneserver-6.onrender.com/login");

    QNetworkRequest request(url);

    request.setHeader(
        QNetworkRequest::ContentTypeHeader,
        "application/json"
        );

    QJsonObject json;
    json["email"] = email;
    json["password"] = password;

    QNetworkReply *reply =
        _networkManager.post(
            request,
            QJsonDocument(json).toJson()
            );

    connect(
        reply,
        &QNetworkReply::finished,
        this,
        [this, reply]()
        {
            if(reply->error() == QNetworkReply::NoError)
            {
                QByteArray response =
                    reply->readAll();

                QJsonDocument doc =
                    QJsonDocument::fromJson(response);

                QJsonObject obj =
                    doc.object();

                _token = obj["token"].toString();

                _role = obj["role"].toString();

                emit tokenChanged();
                emit roleChanged();

                _loggedIn = true;

                emit loggedInChanged();

                qDebug() << "Login Successful";
                qDebug() << "Role:" << _role;
                qDebug() << "Token:" << _token;
            }
            else
            {
                qDebug() << "Login Failed";
                qDebug() << reply->errorString();
            }

            reply->deleteLater();
        });
}