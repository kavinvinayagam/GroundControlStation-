#include "UserService.h"

#include <QJsonDocument>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QUrl>
#include <QDebug>
#include <QJsonObject>

UserService::UserService(QObject *parent)
    : QObject(parent)
{
}


void UserService::setToken(
    const QString &token
    )
{
    _token = token;
}

void UserService::loadUsers()
{
    QUrl url(
        "https://droneserver-6.onrender.com/users"
    );

    QNetworkRequest request(url);
    request.setRawHeader(
        "Authorization",
        QString(
            "Bearer %1"
            )
            .arg(_token)
            .toUtf8()
        );

    request.setHeader(
        QNetworkRequest::ContentTypeHeader,
        "application/json"
        );
    qDebug()
        << "JWT Token:"
        << _token;

    QNetworkReply *reply =
        _network.get(request);

    connect(
        reply,
        &QNetworkReply::finished,
        this,
        [this, reply]()
        {
            if(reply->error() ==
                QNetworkReply::NoError)
            {
                QByteArray response =
                    reply->readAll();

                qDebug()
                    << "USERS RESPONSE:"
                    << response;

                emit usersLoaded(
                    QString(response)
                    );
            }
            else
            {
                qDebug()
                << "NETWORK ERROR:"
                << reply->errorString();

                qDebug()
                    << "SERVER RESPONSE:"
                    << reply->readAll();
            }
            reply->deleteLater();
        }
        );
}


void UserService::createUser(
    const QString &email,
    const QString &password,
    const QString &role
    )
{
    QUrl url(
        "https://droneserver-6.onrender.com/users/create"
        );

    QNetworkRequest request(url);

    request.setHeader(
        QNetworkRequest::ContentTypeHeader,
        "application/json"
        );

    request.setRawHeader(
        "Authorization",
        QString(
            "Bearer %1"
            )
            .arg(_token)
            .toUtf8()
        );

    QJsonObject json;

    json["email"] = email;
    json["password"] = password;
    json["role"] = role;
    QNetworkReply *reply =
        _network.post(
            request,
            QJsonDocument(json).toJson()
            );

    connect(
        reply,
        &QNetworkReply::finished,
        this,
        [this, reply]()
        {
            if(reply->error() ==
                QNetworkReply::NoError)
            {
                qDebug()
                << "User created";

                loadUsers();
            }
            else
            {
                qDebug()
                << "Create failed:"
                << reply->readAll();
            }

            reply->deleteLater();
        }
        );

}

void UserService::deleteUser(
    int userId
    )
{
    QUrl url(
        QString(
            "https://droneserver-6.onrender.com/users/%1"
            ).arg(userId)
        );

    QNetworkRequest request(url);

    request.setHeader(
        QNetworkRequest::ContentTypeHeader,
        "application/json"
        );

    request.setRawHeader(
        "Authorization",
        QString(
            "Bearer %1"
            )
            .arg(_token)
            .toUtf8()
        );

    QNetworkReply *reply =
        _network.deleteResource(
            request
            );

    connect(
        reply,
        &QNetworkReply::finished,
        this,
        [this, reply]()
        {
            if(reply->error() ==
                QNetworkReply::NoError)
            {
                qDebug()
                << "User deleted";

                loadUsers();
            }
            else
            {
                qDebug()
                << "Delete failed:"
                << reply->readAll();
            }

            reply->deleteLater();
        }
        );
}