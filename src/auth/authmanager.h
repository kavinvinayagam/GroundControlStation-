#pragma once

#include <QObject>
#include <QNetworkAccessManager>

class AuthManager : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool loggedIn READ loggedIn NOTIFY loggedInChanged)
    Q_PROPERTY(QString token READ token NOTIFY tokenChanged)
    Q_PROPERTY(QString role READ role NOTIFY roleChanged)

   public:
    explicit AuthManager(QObject *parent = nullptr);

    bool loggedIn() const;

    QString token() const;

    QString role() const;

    Q_INVOKABLE void login(
        const QString &email,
        const QString &password
        );

   signals:
    void loggedInChanged();

    void tokenChanged();

    void roleChanged();

   private:
    bool _loggedIn = false;

    QString _token;

    QString _role;

    QNetworkAccessManager _networkManager;
};