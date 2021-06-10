#include "deviceregistry.h"

#include "flipperzero.h"
#include "usbdevice.h"

using namespace Flipper;

DeviceRegistry::DeviceRegistry(QObject *parent):
    QAbstractListModel(parent)
{
    connect(USBDeviceDetector::instance(), &USBDeviceDetector::devicePluggedIn, this, &DeviceRegistry::insertDevice);
    connect(USBDeviceDetector::instance(), &USBDeviceDetector::deviceUnplugged, this, &DeviceRegistry::removeDevice);

    USBDeviceDetector::instance()->setWantedDevices({
        // Flipper Zero in DFU mode
        USBDeviceInfo(0x0483, 0xdf11),
        // Flipper Zero in VCP mode
        USBDeviceInfo(0x483, 0x5740)
            .withManufacturer("Flipper Devices Inc.")
            .withProductDescription("Flipper Control Virtual ComPort")
    });
}

int DeviceRegistry::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_data.size();
}

QVariant DeviceRegistry::data(const QModelIndex &index, int role) const
{
    return (role == DeviceRole) ? QVariant::fromValue(m_data.at(index.row())) : QVariant();
}

QHash<int, QByteArray> DeviceRegistry::roleNames() const
{
    return { { DeviceRole, "device" } };
}

void DeviceRegistry::insertDevice(const USBDeviceInfo &info)
{
    auto *device = new Flipper::Zero(info, this);

    beginInsertRows(QModelIndex(), m_data.size(), m_data.size());
    m_data.append(device);
    endInsertRows();

    emit deviceConnected(device);
}

void DeviceRegistry::removeDevice(const USBDeviceInfo &info)
{
    const auto it = std::find_if(m_data.begin(), m_data.end(), [&](Flipper::Zero *dev) {
        return dev->info().backendData() == info.backendData();
    });

    if(it != m_data.end()) {
        const auto idx = std::distance(m_data.begin(), it);

        beginRemoveRows(QModelIndex(), idx, idx);
        m_data.takeAt(idx)->deleteLater();
        endRemoveRows();
    }
}
