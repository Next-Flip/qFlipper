import QtQuick 2.15

Item {
    id: control

    signal pressed
    signal released
    signal shortPress
    signal longPress
    signal repeat
    signal ascii

    property int padding: 0
    property alias icon: button.icon
    property alias iconPath: button.iconPath
    property alias iconName: button.iconName
    property bool triggeredByKeyboard: false

    width: button.implicitWidth + padding * 2
    height: button.implicitHeight + padding * 2

    function setPressed() {
        button.down = true;
        onButtonPressed();
        control.triggeredByKeyboard = true;
    }

    function setReleased() {
        button.down = false;
        onButtonReleased();
    }

    function onButtonPressed() {
        control.triggeredByKeyboard = false;

        if(!longTimer.running) {
            longTimer.start();
        }

        if(releaseTimer.running) {
           releaseTimer.stop();
        }
    }

    function onButtonReleased() {
        if(longTimer.running) {
            longTimer.stop();
            if(control.triggeredByKeyboard) {
                control.ascii();
            } else {
                control.pressed();
                control.shortPress();
                releaseTimer.start();
            }
        } else {
            releaseTimer.start();
        }

        if(repeatTimer.running) {
            repeatTimer.stop();
        }
    }

    function onLongPress() {
        control.pressed();
        control.longPress()
        if(!repeatTimer.running) {
            repeatTimer.start();
        }
    }

    ImageButton {
        id: button
        anchors.centerIn: parent

        onPressed: onButtonPressed()
        onReleased: onButtonReleased()
    }

    Timer {
        id: releaseTimer
        repeat: false
        interval: 1
        onTriggered: control.released()
    }

    Timer {
        id: longTimer
        repeat: false
        interval: 350
        onTriggered: onLongPress()
    }

    Timer {
        id: repeatTimer
        repeat: true
        interval: 150
        onTriggered: control.repeat()
    }
}
