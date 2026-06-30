import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QGC.Auth 1.0

Page {

    signal backRequested()

    //==========================
    // Validation Properties
    //==========================
    property string errorMessage: ""

    function validateEmail(email) {
        var regex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
        return regex.test(email);
    }

    function validatePassword(password) {
        return password.length >= 8;
    }

    Rectangle {

        anchors.fill: parent

        color: "#07111E"

        ColumnLayout {

            anchors.centerIn: parent

            width: 500

            spacing: 20

            Label {

                text: "CREATE USER"

                color: "white"

                font.pixelSize: 30

                font.bold: true
            }

            TextField {

                id: emailField

                Layout.fillWidth: true

                placeholderText: "Email"
            }

            TextField {

                id: passwordField

                Layout.fillWidth: true

                echoMode: TextInput.Password

                placeholderText: "Password"
            }

            //==========================
            // Error Message
            //==========================
            Label {

                Layout.fillWidth: true

                text: errorMessage

                color: "red"

                wrapMode: Text.WordWrap

                visible: errorMessage !== ""
            }

            ComboBox {

                id: roleCombo

                Layout.fillWidth: true

                model: [
                    "admin",
                    "operator",
                    "pilot"
                ]
            }

            Button {

                Layout.fillWidth: true

                text: "CREATE USER"

                onClicked: {

                    errorMessage = ""

                    if(emailField.text.trim() === "") {
                        errorMessage = "Email cannot be empty."
                        return
                    }

                    if(!validateEmail(emailField.text)) {
                        errorMessage = "Enter a valid email address (example@domain.com)."
                        return
                    }

                    if(passwordField.text.trim() === "") {
                        errorMessage = "Password cannot be empty."
                        return
                    }

                    if(!validatePassword(passwordField.text)) {
                        errorMessage = "Password must contain at least 8 characters."
                        return
                    }

                    //==========================
                    // ORIGINAL LOGIC (UNCHANGED)
                    //==========================
                    UserService.createUser(
                        emailField.text,
                        passwordField.text,
                        roleCombo.currentText
                    )

                    backRequested()
                }
            }

            Button {

                Layout.fillWidth: true

                text: "BACK"

                onClicked: {
                    backRequested()
                }
            }
        }
    }
}