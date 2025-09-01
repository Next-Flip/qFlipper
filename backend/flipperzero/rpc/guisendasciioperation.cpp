#include "guisendasciioperation.h"

#include "protobufplugininterface.h"

using namespace Flipper;
using namespace Zero;

GuiSendAsciiOperation::GuiSendAsciiOperation(uint32_t id, int value, QObject *parent):
    AbstractProtobufOperation(id, parent),
    m_value(value)
{}

const QString GuiSendAsciiOperation::description() const
{
    return QStringLiteral("Gui Send Ascii");
}

const QByteArray GuiSendAsciiOperation::encodeRequest(ProtobufPluginInterface *encoder)
{
    return encoder->guiSendAscii(id(), m_value);
}
