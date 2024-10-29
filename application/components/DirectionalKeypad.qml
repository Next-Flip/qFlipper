import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import Theme 1.0
import QFlipper 1.0

Item {
    id: control

    signal inputEvent(var key, var type)
    signal asciiEvent(var value)

    property int spacing: 15

    width: 186
    height: 224

    Rectangle {
        width: 168
        height: width
        radius: width / 2
        color: Theme.color.darkorange1
        border.color: Theme.color.lightorange1
        border.width: 2

        GridLayout {
            anchors.centerIn: parent
            rowSpacing: columnSpacing
            columnSpacing: 0
            columns: 3

            KeypadButton {
                id: buttonUp
                Layout.columnSpan: 3
                Layout.alignment: Qt.AlignHCenter

                iconName: "triangle"
                iconPath: "qrc:/assets/gfx/controls/dpad"

                icon.width: 32
                icon.height: 28

                rotation: 180
                padding: control.spacing

                onPressed: inputEvent(InputEvent.Up, InputEvent.Press)
                onReleased: inputEvent(InputEvent.Up, InputEvent.Release)
                onShortPress: inputEvent(InputEvent.Up, InputEvent.Short)
                onLongPress: inputEvent(InputEvent.Up, InputEvent.Long)
                onRepeat: inputEvent(InputEvent.Up, InputEvent.Repeat)
                onAscii: asciiEvent(AsciiEvent.DC1)
            }

            KeypadButton {
                id: buttonLeft
                iconName: "triangle"
                iconPath: "qrc:/assets/gfx/controls/dpad"

                icon.width: 32
                icon.height: 28

                rotation: 90
                padding: control.spacing

                onPressed: inputEvent(InputEvent.Left, InputEvent.Press)
                onReleased: inputEvent(InputEvent.Left, InputEvent.Release)
                onShortPress: inputEvent(InputEvent.Left, InputEvent.Short)
                onLongPress: inputEvent(InputEvent.Left, InputEvent.Long)
                onRepeat: inputEvent(InputEvent.Left, InputEvent.Repeat)
                onAscii: asciiEvent(AsciiEvent.DC4)
            }

            KeypadButton {
                id: buttonOk
                iconName: "circle"
                iconPath: "qrc:/assets/gfx/controls/dpad"

                icon.width: 52
                icon.height: 52

                onPressed: inputEvent(InputEvent.Ok, InputEvent.Press)
                onReleased: inputEvent(InputEvent.Ok, InputEvent.Release)
                onShortPress: inputEvent(InputEvent.Ok, InputEvent.Short)
                onLongPress: inputEvent(InputEvent.Ok, InputEvent.Long)
                onRepeat: inputEvent(InputEvent.Ok, InputEvent.Repeat)
                onAscii: asciiEvent(AsciiEvent.CR)
            }

            KeypadButton {
                id: buttonRight
                iconName: "triangle"
                iconPath: "qrc:/assets/gfx/controls/dpad"

                icon.width: 32
                icon.height: 28

                rotation: -90
                padding: control.spacing

                onPressed: inputEvent(InputEvent.Right, InputEvent.Press)
                onReleased: inputEvent(InputEvent.Right, InputEvent.Release)
                onShortPress: inputEvent(InputEvent.Right, InputEvent.Short)
                onLongPress: inputEvent(InputEvent.Right, InputEvent.Long)
                onRepeat: inputEvent(InputEvent.Right, InputEvent.Repeat)
                onAscii: asciiEvent(AsciiEvent.DC3)
            }

            KeypadButton {
                id: buttonDown
                Layout.columnSpan: 3
                Layout.alignment: Qt.AlignHCenter

                iconName: "triangle"
                iconPath: "qrc:/assets/gfx/controls/dpad"

                icon.width: 32
                icon.height: 28
                padding: control.spacing

                onPressed: inputEvent(InputEvent.Down, InputEvent.Press)
                onReleased: inputEvent(InputEvent.Down, InputEvent.Release)
                onShortPress: inputEvent(InputEvent.Down, InputEvent.Short)
                onLongPress: inputEvent(InputEvent.Down, InputEvent.Long)
                onRepeat: inputEvent(InputEvent.Down, InputEvent.Repeat)
                onAscii: asciiEvent(AsciiEvent.DC2)
            }
        }
    }

    KeypadButton {
        id: buttonBack
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        iconName: "back"
        iconPath: "qrc:/assets/gfx/controls/dpad"

        icon.width: 52
        icon.height: 52

        onPressed: inputEvent(InputEvent.Back, InputEvent.Press)
        onReleased: inputEvent(InputEvent.Back, InputEvent.Release)
        onShortPress: inputEvent(InputEvent.Back, InputEvent.Short)
        onLongPress: inputEvent(InputEvent.Back, InputEvent.Long)
        onRepeat: inputEvent(InputEvent.Back, InputEvent.Repeat)
        onAscii: asciiEvent(AsciiEvent.BS)
    }

    Keys.onPressed: function(event) {
        const button = findButton(event.key);

        if(button === null) {
            const ascii = findAscii(event);
            if(ascii !== null) asciiEvent(ascii);
            return;
        }

        if(event.isAutoRepeat)
            return;

        button.setPressed();
        event.accepted = true;
    }

    Keys.onReleased: function(event) {
        if(event.isAutoRepeat)
            return;

        const button = findButton(event.key);

        if(button === null)
            return;

        button.setReleased();
        event.accepted = true;
    }

    function findButton(key) {
        switch(key) {
        case Qt.Key_Left:
            return buttonLeft;
        case Qt.Key_Right:
            return buttonRight;
        case Qt.Key_Up:
            return buttonUp;
        case Qt.Key_Down:
            return buttonDown;
        case Qt.Key_Enter:
        case Qt.Key_Return:
            return buttonOk;
        case Qt.Key_Backspace:
            return buttonBack;
        default:
            return null;
        }
    }

    function findAscii(event) {
        const charCode = event.text.charCodeAt(0);
        switch(event.key) {
        default:
            if(event.count && charCode) {
                return charCode;
            } else {
                return null;
            }
        }
    }

}
