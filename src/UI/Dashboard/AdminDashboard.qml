import QtQuick
import QtQuick.Controls

Rectangle {
    signal openGroundControl()

    color: "#0A0E14"

    // Palette pulled from the Control Centre reference
    QtObject {
        id: palette
        property color bg: "#0A0E14"
        property color panel: "#0D1320"
        property color panelHover: "#101828"
        property color border: "#1C2738"
        property color borderHover: "#2A3A52"
        property color textPrimary: "#FFFFFF"
        property color textMuted: "#8FA3BD"
        property color textDim: "#5C7090"
        property color blue: "#4C8DFF"
        property color blueDim: "#1B2C4A"
        property color orange: "#E2A93B"
        property color orangeDim: "#3A2A12"
        property color accentGreen: "#2FE6B5"
    }

    // ===== Top header =====
    Column {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 40
        spacing: 10

        Row {
            width: parent.width

            Text {
                text: "NEXTLEAP AERONAUTICS"
                color: palette.textPrimary
                font.pixelSize: 36
                font.bold: true
                font.letterSpacing: 1
            }

            Item { width: parent.width - 600; height: 1 }

            Column {
                spacing: 6
                anchors.right: parent.right

                Text {
                    text: "MX-2026-417-C"
                    color: palette.blue
                    font.pixelSize: 12
                    anchors.right: parent.right
                }

                Row {
                    spacing: 6
                    anchors.right: parent.right

                    Rectangle {
                        width: 8; height: 8; radius: 4
                        color: palette.accentGreen
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Text {
                        text: "SESSION ACTIVE"
                        color: palette.accentGreen
                        font.pixelSize: 11
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }

        Text {
            text: "Select a module to proceed. Authenticated session required."
            color: palette.textMuted
            font.pixelSize: 14
        }

        Rectangle {
            width: parent.width
            height: 1
            color: palette.border
        }
    }

    // ===== Module selection divider =====
    Row {
        anchors.top: header.bottom
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 14

        Rectangle {
            width: 40; height: 1
            color: palette.textDim
            anchors.verticalCenter: parent.verticalCenter
        }
        Text {
            text: "MODULE SELECTION"
            color: palette.textDim
            font.pixelSize: 12
            font.letterSpacing: 2
        }
        Rectangle {
            width: 40; height: 1
            color: palette.textDim
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    // ===== Module cards =====
    Row {
        id: cardsRow
        anchors.top: header.bottom
        anchors.topMargin: 100
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 30

        // ---- User Management card ----
        Rectangle {
            id: userCard
            width: 460
            height: 430
            color: userMouse.containsMouse ? palette.panelHover : palette.panel
            border.color: userMouse.containsMouse ? palette.borderHover : palette.border
            border.width: 1
            radius: 4

            scale: userMouse.pressed ? 0.97 : (userMouse.containsMouse ? 1.015 : 1.0)

            Behavior on scale {
                NumberAnimation { duration: 120; easing.type: Easing.OutQuad }
            }
            Behavior on color {
                ColorAnimation { duration: 150 }
            }
            Behavior on border.color {
                ColorAnimation { duration: 150 }
            }

            Column {
                anchors.fill: parent
                anchors.margins: 36
                spacing: 22

                Rectangle {
                    width: 168; height: 32
                    color: "transparent"
                    border.color: palette.blue
                    border.width: 1
                    radius: 3

                    Row {
                        anchors.centerIn: parent
                        spacing: 6
                        Text {
                            text: "⚡"
                            color: palette.blue
                            font.pixelSize: 11
                        }
                        Text {
                            text: "ACCESS CONTROL"
                            color: palette.blue
                            font.pixelSize: 11
                            font.bold: true
                            font.letterSpacing: 1
                        }
                    }
                }

                Rectangle {
                    width: 64; height: 64
                    color: "transparent"
                    border.color: palette.border
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: "👥"
                        color: palette.blue
                        font.pixelSize: 26
                    }
                }

                Text {
                    text: "USER MANAGEMENT"
                    color: palette.textPrimary
                    font.pixelSize: 26
                    font.bold: true
                    font.letterSpacing: 1
                }

                Text {
                    width: parent.width
                    text: "Administer accounts, assign roles, and control access privileges across all operator tiers."
                    color: palette.textMuted
                    font.pixelSize: 14
                    wrapMode: Text.WordWrap
                    lineHeight: 1.3
                }

                Column {
                    spacing: 10
                    topPadding: 4

                    Row {
                        spacing: 10
                        Rectangle { width: 14; height: 1; color: palette.blue; anchors.verticalCenter: parent.verticalCenter }
                        Text { text: "OPERATOR ACCOUNTS"; color: palette.textMuted; font.pixelSize: 12; font.letterSpacing: 1 }
                    }
                    Row {
                        spacing: 10
                        Rectangle { width: 14; height: 1; color: palette.textDim; anchors.verticalCenter: parent.verticalCenter }
                        Text { text: "ROLE ASSIGNMENT"; color: palette.textMuted; font.pixelSize: 12; font.letterSpacing: 1 }
                    }
                }

                Item { width: 1; height: 6 }

                Row {
                    spacing: 8

                    Text {
                        text: "ENTER MODULE"
                        color: palette.blue
                        font.pixelSize: 13
                        font.bold: true
                        font.letterSpacing: 1
                    }
                    Text {
                        text: "›"
                        color: palette.blue
                        font.pixelSize: 15
                        x: userMouse.containsMouse ? 4 : 0
                        Behavior on x {
                            NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
                        }
                    }
                }
            }

            MouseArea {
                id: userMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    // ---- Original logic: unchanged ----
                    userLoader.source =
                            "../Users/UserManagementPage.qml"
                }
            }
        }

        // ---- Ground Controller card ----
        Rectangle {
            id: groundCard
            width: 460
            height: 430
            color: groundMouse.containsMouse ? palette.panelHover : palette.panel
            border.color: groundMouse.containsMouse ? palette.orange : palette.border
            border.width: 1
            radius: 4

            scale: groundMouse.pressed ? 0.97 : (groundMouse.containsMouse ? 1.015 : 1.0)

            Behavior on scale {
                NumberAnimation { duration: 120; easing.type: Easing.OutQuad }
            }
            Behavior on color {
                ColorAnimation { duration: 150 }
            }
            Behavior on border.color {
                ColorAnimation { duration: 150 }
            }

            Column {
                anchors.fill: parent
                anchors.margins: 36
                spacing: 22

                Rectangle {
                    width: 180; height: 32
                    color: "transparent"
                    border.color: palette.orange
                    border.width: 1
                    radius: 3

                    Row {
                        anchors.centerIn: parent
                        spacing: 6
                        Text {
                            text: "⚡"
                            color: palette.orange
                            font.pixelSize: 11
                        }
                        Text {
                            text: "FLIGHT OPERATIONS"
                            color: palette.orange
                            font.pixelSize: 11
                            font.bold: true
                            font.letterSpacing: 1
                        }
                    }
                }

                Rectangle {
                    width: 64; height: 64
                    color: "transparent"
                    border.color: palette.border
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: "((•))"
                        color: palette.orange
                        font.pixelSize: 20
                    }
                }

                Text {
                    text: "GROUND CONTROL"
                    color: palette.textPrimary
                    font.pixelSize: 26
                    font.bold: true
                    font.letterSpacing: 1
                }

                Text {
                    width: parent.width
                    text: "Access the primary flight operations interface for real-time drone telemetry and mission control."
                    color: palette.textMuted
                    font.pixelSize: 14
                    wrapMode: Text.WordWrap
                    lineHeight: 1.3
                }

                Column {
                    spacing: 10
                    topPadding: 4

                    Row {
                        spacing: 10
                        Rectangle { width: 14; height: 1; color: palette.orange; anchors.verticalCenter: parent.verticalCenter }
                        Text { text: "LIVE TELEMETRY FEED"; color: palette.textMuted; font.pixelSize: 12; font.letterSpacing: 1 }
                    }
                    Row {
                        spacing: 10
                        Rectangle { width: 14; height: 1; color: palette.textDim; anchors.verticalCenter: parent.verticalCenter }
                        Text { text: "MISSION PLANNING"; color: palette.textMuted; font.pixelSize: 12; font.letterSpacing: 1 }
                    }
                }

                Item { width: 1; height: 6 }

                Row {
                    spacing: 8

                    Text {
                        text: "ENTER MODULE"
                        color: palette.orange
                        font.pixelSize: 13
                        font.bold: true
                        font.letterSpacing: 1
                    }
                    Text {
                        text: "›"
                        color: palette.orange
                        font.pixelSize: 15
                        x: groundMouse.containsMouse ? 4 : 0
                        Behavior on x {
                            NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
                        }
                    }
                }
            }

            MouseArea {
                id: groundMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    // ---- Original logic: unchanged ----
                    openGroundControl()
                }
            }
        }
    }

    // ---- Original logic: unchanged ----
    Loader {
        id: userLoader
        anchors.fill: parent
        onLoaded: {
            if(item &&
               item.createUserRequested)
            {
                item.createUserRequested.connect(
                    function()
                    {
                        userLoader.source =
                            "../Users/CreateUserPage.qml"
                    }
                )
            }
            if(item && item.backToDashboard){
            item.backToDashboard.connect(
                function(){
                    userLoader.source= ""
                }
                )
            }
            if(item &&
               item.backRequested)
            {
                item.backRequested.connect(
                    function()
                    {
                        userLoader.source =
                            "../Users/UserManagementPage.qml"
                    }
                )
            }
        }
    }
}