import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QGC.Auth 1.0

Page {
    id: root
    signal createUserRequested()

    // ---- Original logic: unchanged ----
    Component.onCompleted: {
        UserService.setToken(
            AuthManager.token
        )
        UserService.loadUsers()
    }

    ListModel {
        id: userModel
    }

    Connections {
        target: UserService
        function onUsersLoaded(jsonData)
        {
            userModel.clear()
            let users = JSON.parse(jsonData)
            for(let i = 0; i < users.length; i++)
            {
                userModel.append({
                    userId: users[i].id,
                    email: users[i].email,
                    role: users[i].role
                })
            }
        }
    }
    // ---- End original logic ----

    // Palette pulled from the admin console mock
    QtObject {
        id: palette
        property color bg: "#07111E"
        property color panel: "#0A1626"
        property color panelAlt: "#0C1A2D"
        property color rowEven: "#091524"
        property color rowOdd: "#0C1A2D"
        property color sidebar: "#08131F"
        property color border: "#16263B"
        property color textPrimary: "#FFFFFF"
        property color textMuted: "#7FA8D8"
        property color textDim: "#5A7392"
        property color accent: "#2FE6B5"
        property color accentDim: "#1B4A3E"
        property color blue: "#4C8DFF"
        property color danger: "#FF5C5C"
        property color warnBg: "#3A2A12"
        property color warnBorder: "#7A5A1E"
        property color warnText: "#E2A93B"
    }

    Rectangle {
        anchors.fill: parent
        color: palette.bg

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            // ===== Top bar =====
            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 56
                color: palette.sidebar
                border.color: palette.border
                border.width: 1

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 20
                    anchors.rightMargin: 20
                    spacing: 14

                    Label {
                        text: "((•)) GCS — GROUND CONTROL STATION"
                        color: palette.textPrimary
                        font.pixelSize: 15
                        font.bold: true
                        font.letterSpacing: 1
                    }
                    Label {
                        text: "ADMIN CONSOLE v2.4.1"
                        color: palette.textDim
                        font.pixelSize: 12
                    }

                    Item { Layout.fillWidth: true }

                    Rectangle {
                        width: 8; height: 8; radius: 4
                        color: palette.accent
                    }
                    Label {
                        text: "SYSTEM NOMINAL"
                        color: palette.accent
                        font.pixelSize: 12
                    }

                    Rectangle {
                        width: 34; height: 26; radius: 4
                        color: "transparent"
                        border.color: palette.accent
                        border.width: 1
                        Label {
                            anchors.centerIn: parent
                            text: "50"
                            color: palette.accent
                            font.pixelSize: 12
                            font.bold: true
                        }
                    }
                    Label {
                        text: "Maj. Okafor  ⌄"
                        color: palette.textPrimary
                        font.pixelSize: 13
                    }
                    Label {
                        text: "⎋"
                        color: palette.textMuted
                        font.pixelSize: 16
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 0

                // ===== Sidebar =====
                Rectangle {
                    Layout.preferredWidth: 225
                    Layout.fillHeight: true
                    color: palette.sidebar
                    border.color: palette.border
                    border.width: 1

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.topMargin: 20
                        anchors.leftMargin: 0
                        anchors.rightMargin: 0
                        spacing: 4

                        Label {
                            text: "  ⛨  USER MANAGEMENT"
                            color: palette.textDim
                            font.pixelSize: 11
                            font.letterSpacing: 1
                            Layout.leftMargin: 18
                            Layout.bottomMargin: 6
                        }

                        // View Users (active)
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 38
                            color: palette.accentDim

                            Rectangle {
                                width: 3
                                height: parent.height
                                color: palette.accent
                            }

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 18
                                anchors.rightMargin: 14
                                Label {
                                    text: "👤  View Users"
                                    color: palette.accent
                                    font.pixelSize: 13
                                }
                                Item { Layout.fillWidth: true }
                                Rectangle {
                                    radius: 8
                                    color: palette.accent
                                    implicitWidth: countLabel.implicitWidth + 14
                                    implicitHeight: 18
                                    Label {
                                        id: countLabel
                                        anchors.centerIn: parent
                                        text: userModel.count
                                        color: palette.bg
                                        font.pixelSize: 11
                                        font.bold: true
                                    }
                                }
                            }
                        }

                        // Create User
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 38
                            color: "transparent"

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 18
                                anchors.rightMargin: 14
                                Label {
                                    text: "➕  Create User"
                                    color: palette.textMuted
                                    font.pixelSize: 13
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: createUserRequested()
                            }
                        }

                        // Delete User
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 38
                            color: "transparent"

                            RowLayout {
                                anchors.fill: parent
                                anchors.leftMargin: 18
                                anchors.rightMargin: 14
                                Label {
                                    text: "🗑  Delete User"
                                    color: palette.textMuted
                                    font.pixelSize: 13
                                }
                            }
                        }

                        Item { Layout.fillHeight: true }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 1
                            color: palette.border
                        }

                        ColumnLayout {
                            Layout.leftMargin: 18
                            Layout.bottomMargin: 16
                            Layout.topMargin: 10
                            spacing: 3
                            Label {
                                text: "SESSION: 2026-06-17"
                                color: palette.textDim
                                font.pixelSize: 10
                            }
                            Label {
                                text: "CLEARANCE: LEVEL 4"
                                color: palette.textDim
                                font.pixelSize: 10
                            }
                            Label {
                                text: "ENCRYPTED ✓"
                                color: palette.textDim
                                font.pixelSize: 10
                            }
                        }
                    }
                }

                // ===== Main content =====
                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.margins: 30
                    spacing: 18

                    RowLayout {
                        Layout.fillWidth: true
                        ColumnLayout {
                            spacing: 4
                            Label {
                                text: "OPERATOR REGISTRY"
                                color: palette.textPrimary
                                font.pixelSize: 24
                                font.bold: true
                            }
                            Label {
                                text: userModel.count + " total"
                                color: palette.textDim
                                font.pixelSize: 12
                            }
                        }

                        Item { Layout.fillWidth: true }

                        Rectangle {
                            Layout.preferredWidth: 220
                            Layout.preferredHeight: 36
                            radius: 6
                            color: palette.panel
                            border.color: palette.border
                            border.width: 1

                            TextField {
                                id: searchField
                                anchors.fill: parent
                                anchors.margins: 1
                                placeholderText: "🔍  Search operators..."
                                placeholderTextColor: palette.textDim
                                color: palette.textPrimary
                                background: Rectangle { color: "transparent" }
                                font.pixelSize: 12
                            }
                        }

                        Rectangle {
                            Layout.preferredWidth: 140
                            Layout.preferredHeight: 36
                            radius: 6
                            color: palette.accentDim
                            border.color: palette.accent
                            border.width: 1

                            Label {
                                anchors.centerIn: parent
                                text: "➕  NEW OPERATOR"
                                color: palette.accent
                                font.pixelSize: 11
                                font.bold: true
                            }

                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: createUserRequested()
                            }
                        }
                    }

                    // ===== Table =====
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: palette.panel
                        border.color: palette.border
                        border.width: 1
                        radius: 6

                        ColumnLayout {
                            anchors.fill: parent
                            anchors.margins: 1
                            spacing: 0

                            // Header row
                            Rectangle {
                                Layout.fillWidth: true
                                Layout.preferredHeight: 38
                                color: palette.panelAlt

                                Row {
                                    anchors.fill: parent
                                    anchors.leftMargin: 20
                                    anchors.rightMargin: 20
                                    spacing: 30

                                    Label {
                                        text: "OPERATOR"
                                        color: palette.textMuted
                                        font.pixelSize: 11
                                        width: 250
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                    Label {
                                        text: "EMAIL"
                                        color: palette.textMuted
                                        font.pixelSize: 11
                                        width: 220
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                    Label {
                                        text: "ROLE"
                                        color: palette.textMuted
                                        font.pixelSize: 11
                                        width: 180
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                    Label {
                                        text: "ACTION"
                                        color: palette.textMuted
                                        font.pixelSize: 11
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                            }

                            ListView {
                                id: listView
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                clip: true
                                model: userModel

                                delegate: Rectangle {
                                    width: ListView.view.width
                                    height: visible ? 58 : 0
                                    color: index % 2 === 0 ? palette.rowEven : palette.rowOdd

                                    visible: email.toLowerCase().includes(
                                        searchField.text.toLowerCase()
                                    )

                                    Row {
                                        anchors.fill: parent
                                        anchors.leftMargin: 20
                                        anchors.rightMargin: 20
                                        spacing: 30

                                        Column {
                                            width: 250
                                            anchors.verticalCenter: parent.verticalCenter
                                            spacing: 2
                                            Label {
                                                text: email.split("@")[0]
                                                color: palette.textPrimary
                                                font.pixelSize: 13
                                                font.bold: true
                                            }
                                            Label {
                                                text: "USR-" + String(userId).padStart(3, "0")
                                                color: palette.textDim
                                                font.pixelSize: 11
                                            }
                                        }

                                        Label {
                                            text: email
                                            color: palette.textMuted
                                            width: 220
                                            font.pixelSize: 12
                                            anchors.verticalCenter: parent.verticalCenter
                                        }

                                        Label {
                                            text: role
                                            color: palette.textMuted
                                            width: 180
                                            font.pixelSize: 12
                                            anchors.verticalCenter: parent.verticalCenter
                                        }

                                        Row {
                                            spacing: 8
                                            anchors.verticalCenter: parent.verticalCenter

                                            Rectangle {
                                                width: 78; height: 26; radius: 4
                                                color: "transparent"
                                                border.color: palette.blue
                                                border.width: 1
                                                Label {
                                                    anchors.centerIn: parent
                                                    text: "👁 VIEW"
                                                    color: palette.blue
                                                    font.pixelSize: 10
                                                }
                                            }

                                            Rectangle {
                                                width: 100; height: 26; radius: 4
                                                color: "#3A0E0E"
                                                border.color: palette.danger
                                                border.width: 1

                                                Label {
                                                    anchors.centerIn: parent
                                                    text: "🗑 DELETE"
                                                    color: palette.danger
                                                    font.pixelSize: 10
                                                }

                                                MouseArea {
                                                    anchors.fill: parent
                                                    cursorShape: Qt.PointingHandCursor
                                                    onClicked: {
                                                        UserService.deleteUser(
                                                            userId
                                                        )
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Label {
                        text: "Showing " + listView.count + " of " + userModel.count + " records"
                        color: palette.textDim
                        font.pixelSize: 11
                    }
                }
            }
        }
    }
}