import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QGC.Auth 1.0

Page {

    signal createUserRequested()
    signal backToDashboard()

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
        property color topbar: "#08131F"
        property color border: "#16263B"
        property color textPrimary: "#FFFFFF"
        property color textMuted: "#7FA8D8"
        property color textDim: "#5A7392"
        property color accent: "#2FE6B5"
        property color accentDim: "#1B4A3E"
        property color blue: "#4C8DFF"
        property color danger: "#FF5C5C"
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
                color: palette.topbar
                border.color: palette.border
                border.width: 1

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 20
                    anchors.rightMargin: 20
                    spacing: 14

                    Rectangle {
                        width: 32; height: 32; radius: 6
                        color: palette.panel
                        border.color: palette.border
                        border.width: 1

                        Label {
                            anchors.centerIn: parent
                            text: "←"
                            color: palette.textMuted
                            font.pixelSize: 16
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                backToDashboard()
                            }
                        }
                    }

                    Label {
                        text: "((•)) GCS — GROUND CONTROL STATION"
                        color: palette.textPrimary
                        font.pixelSize: 15
                        font.bold: true
                        font.letterSpacing: 1
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
                            text: "USER MANAGEMENT"
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
                            placeholderText: "🔍  Search users..."
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
                            text: "➕  CREATE USER"
                            color: palette.accent
                            font.pixelSize: 11
                            font.bold: true
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {

                                console.log("CREATE USER CLICKED")

                                createUserRequested()
                            }
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
                                spacing: 50

                                Label {
                                    text: "EMAIL"
                                    color: palette.textMuted
                                    font.pixelSize: 11
                                    width: 350
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                                Label {
                                    text: "ROLE"
                                    color: palette.textMuted
                                    font.pixelSize: 11
                                    width: 150
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

                                color:
                                    index % 2 === 0
                                    ? palette.rowEven
                                    : palette.rowOdd

                                visible:
                                    email.toLowerCase().includes(
                                        searchField.text.toLowerCase()
                                    )

                                Row {

                                    anchors.verticalCenter:
                                        parent.verticalCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 20

                                    spacing: 50

                                    Label {

                                        text: email

                                        color: palette.textPrimary

                                        width: 350
                                        font.pixelSize: 13
                                    }

                                    Label {

                                        text: role

                                        color: palette.textMuted

                                        width: 150
                                        font.pixelSize: 13
                                    }

                                    Rectangle {
                                        width: 100; height: 26; radius: 4
                                        color: "#3A0E0E"
                                        border.color: palette.danger
                                        border.width: 1
                                        anchors.verticalCenter: parent.verticalCenter

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

                Label {
                    text: "Showing " + listView.count + " of " + userModel.count + " records"
                    color: palette.textDim
                    font.pixelSize: 11
                }
            }
        }
    }
}