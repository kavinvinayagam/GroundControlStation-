import QtQuick 2.15
import QtQuick.Controls 2.15
import QGC.Auth 1.0

Rectangle {
    id: windowRoot
    width: 1024
    height: 768
    color: "#0B0E11"

    // ==========================================
    // TOP HEADER BAR
    // ==========================================
    Item {
        id: topHeader
        height: 90
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 30

        Image {
            id: companyLogo
            source: "file:///C:/QGC/src/UI/Login/NextLeaplogo.png"
            width: 60
            height: 60
            fillMode: Image.PreserveAspectFit
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            Rectangle {
                anchors.fill: parent
                color: "#161A1F"
                border.color: "#2C353F"
                border.width: 1
                visible: companyLogo.status !== Image.Ready
                Text {
                    anchors.centerIn: parent
                    text: "LOGO"
                    color: "#4A5568"
                    font.pixelSize: 9
                    font.bold: true
                }
            }
        }

        Column {
            anchors.left: companyLogo.right
            anchors.leftMargin: 14
            anchors.verticalCenter: parent.verticalCenter
            spacing: 4

            Text {
                text: "NEXTLEAP AERONAUTICS"
                color: "#FFFFFF"
                font.pixelSize: 22
                font.bold: true
                font.letterSpacing: 2
            }
            Text {
                text: "GROUND CONTROL SYSTEM · SECURE ACCESS"
                color: "#707E94"
                font.pixelSize: 11
                font.letterSpacing: 1
            }
        }
    }

    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 2
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: "#3B82F6" }
            GradientStop { position: 1.0; color: "#F59E0B" }
        }
    }

    Item {
        id: sectionDivider
        width: 360
        height: 20
        anchors.top: topHeader.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter

        Rectangle { width: 60; height: 1; color: "#2C353F"; anchors.left: parent.left; anchors.verticalCenter: parent.verticalCenter }
        Text {
            text: "OPERATOR AUTHENTICATION"
            color: "#5B6B82"
            font.pixelSize: 11
            font.letterSpacing: 3
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
        Rectangle { width: 60; height: 1; color: "#2C353F"; anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter }
    }

    // ==========================================
    // LOGIN CARD
    // ==========================================
    Rectangle {
        id: loginCard
        width: 480
        height: 420
        anchors.top: sectionDivider.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#0E1116"
        radius: 4
        border.color: "#2C3A52"
        border.width: 1

        Column {
            id: cardContent
            anchors.top: parent.top
            anchors.topMargin: 36
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 40
            anchors.rightMargin: 40
            spacing: 20

            Column {
                spacing: 8
                width: parent.width
                Text { text: "SYSTEM ACCESS"; color: "#FFFFFF"; font.pixelSize: 24; font.bold: true }
                Text {
                    text: "Authorized personnel only. All access is logged and monitored."
                    color: "#707E94"
                    font.pixelSize: 12
                    width: parent.width
                    wrapMode: Text.WordWrap
                }
            }

            Column {
                width: parent.width
                spacing: 8
                Text { text: "OPERATOR ID"; color: "#8B96A5"; font.pixelSize: 11; font.bold: true; font.letterSpacing: 1 }

                TextField {
                    id: emailField
                    placeholderText: "username"
                    width: parent.width
                    height: 46
                    color: "#E5E9EF"
                    placeholderTextColor: "#5B6B82"
                    font.pixelSize: 13
                    background: Rectangle {
                        color: "#161A1F"
                        radius: 4
                        border.color: emailField.activeFocus ? "#3B82F6" : "#2C353F"
                        border.width: 1
                    }
                    onAccepted: passwordField.forceActiveFocus()
                }
            }

            Column {
                width: parent.width
                spacing: 8
                Text { text: "ACCESS KEY"; color: "#8B96A5"; font.pixelSize: 11; font.bold: true; font.letterSpacing: 1 }

                TextField {
                    id: passwordField
                    placeholderText: "access key"
                    echoMode: TextInput.Password
                    width: parent.width
                    height: 46
                    color: "#E5E9EF"
                    placeholderTextColor: "#5B6B82"
                    font.pixelSize: 13
                    background: Rectangle {
                        color: "#161A1F"
                        radius: 4
                        border.color: passwordField.activeFocus ? "#3B82F6" : "#2C353F"
                        border.width: 1
                    }
                    onAccepted: windowRoot.attemptLogin()
                }
            }

            // Error message — shown on bad credentials
            Text {
                id: formErrorText
                width: parent.width
                text: ""
                color: "#F87171"
                font.pixelSize: 12
                wrapMode: Text.WordWrap
                visible: text.length > 0
            }

            Button {
                id: authenticateButton
                text: "AUTHENTICATE"
                width: parent.width
                height: 48

                background: Rectangle {
                    radius: 4
                    color: authenticateButton.pressed ? "#4F5FE0" : (authenticateButton.hovered ? "#6B7AF5" : "#5B6CF0")
                }

                contentItem: Text {
                    text: authenticateButton.text
                    color: "#FFFFFF"
                    font.pixelSize: 13
                    font.bold: true
                    font.letterSpacing: 1
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: windowRoot.attemptLogin()
            }
        }
    }

    // ==========================================
    // LOGIN LOGIC
    // ==========================================
    function attemptLogin() {
        formErrorText.text = ""

        if (emailField.text.length === 0 || passwordField.text.length === 0) {
            formErrorText.text = "Operator ID and Access Key are required."
            return
        }

        console.log("LoginButonclicked")
        AuthManager.login(
            emailField.text,
            passwordField.text)
    }

    function showLoginFailed(reason) {
        // Clear fields and show error — called from AuthManager signal below
        passwordField.text = ""
        formErrorText.text = reason && reason.length > 0 ? reason : "Invalid Operator ID or Access Key."
        emailField.forceActiveFocus()
    }

    // ==========================================
    // CONNECT TO AUTHMANAGER FAILURE SIGNAL
    // Replace 'loginFailed' below with whatever your
    // AuthManager actually emits on bad credentials.
    // ==========================================
    Connections {
        target: AuthManager
        function onLoginFailed(reason) {
            windowRoot.showLoginFailed(reason)
        }
    }
}