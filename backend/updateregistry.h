﻿#ifndef UPDATESLISTMODEL_H
#define UPDATESLISTMODEL_H

#include <QMap>
#include <QStringList>
#include <QAbstractListModel>

#include "flipperupdates.h"

namespace Flipper {

class UpdateRegistry : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList channelNames READ channelNames NOTIFY channelsChanged)

public:
    UpdateRegistry(QObject *parent = nullptr);
    ~UpdateRegistry();

    bool fillFromJson(const QByteArray &text);

    const QStringList channelNames() const;

    Q_INVOKABLE Flipper::Updates::ChannelInfo channel(const QString &channelName) const;

signals:
    void channelsChanged();

private:
    QMap<QString, Updates::ChannelInfo> m_channels;
};

}

#endif // UPDATESLISTMODEL_H
