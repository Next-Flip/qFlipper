#pragma once

#include <QObject>

class AsciiEvent : public QObject {
    Q_OBJECT

public:
    enum Value {
        NUL = 0x00,
        BS = 0x08,
        CR = 0x0D,
        DC1 = 0x11,
        DC2 = 0x12,
        DC3 = 0x13,
        DC4 = 0x14,
        ECS = 0x1B,
    };

    Q_ENUM(Value)
};
