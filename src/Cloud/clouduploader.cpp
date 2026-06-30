#include "clouduploader.h"

#include <QProcess>
#include <QDebug>

void CloudUploader::upload(const QString &filePath)
{
    QString python = "python";

    QString script =
        "C:/Projects/test/upload_bucket.py";

    QStringList args;

    args << script
         << filePath;

    qDebug() << "Starting upload...";
    qDebug() << "Python:" << python;
    qDebug() << "Script:" << script;
    qDebug() << "File:" << filePath;

    QProcess process;

    process.start(python, args);

    if (!process.waitForStarted()) {
        qDebug() << "Python failed to start.";
        return;
    }

    process.waitForFinished(-1);

    qDebug() << "Exit Code:"
             << process.exitCode();

    qDebug() << process.readAllStandardOutput();

    qDebug() << process.readAllStandardError();
}