#pragma once

#include <QObject>
#include <QNetworkAccessManager>

class UserService : public QObject
{
    Q_OBJECT

   public:
    explicit UserService(QObject *parent = nullptr);

    Q_INVOKABLE void setToken(const QString &token);
    Q_INVOKABLE void loadUsers();
    Q_INVOKABLE void createUser(
        const QString &email,
        const QString &password,
        const QString &role
        );

    Q_INVOKABLE void deleteUser(
        int userId
        );

   signals:
    void usersLoaded(QString json);

   private:
    QNetworkAccessManager _network;
    QString _token;



};