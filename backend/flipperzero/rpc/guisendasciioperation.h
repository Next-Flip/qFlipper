#pragma once

#include "abstractprotobufoperation.h"

namespace Flipper {
namespace Zero {

class GuiSendAsciiOperation : public AbstractProtobufOperation
{
    Q_OBJECT

public:
    GuiSendAsciiOperation(uint32_t id, int value, QObject *parent = nullptr);
    const QString description() const override;
    const QByteArray encodeRequest(ProtobufPluginInterface *encoder) override;

private:
    int m_value;
};

}
}

