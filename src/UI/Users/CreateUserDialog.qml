import QtQuick
import QtQuick.Controls

Dialog {

    modal: true

    Column {

        spacing: 10

        TextField {
            id: emailField
            placeholderText: "Email"
        }

        TextField {
            id: passwordField
            placeholderText: "Password"
        }

        ComboBox {
            id: roleBox

            model: [
                "operator",
                "admin"
            ]
        }

        Button {

            text: "Create"

            onClicked: {

                authManager.createUser(
                    emailField.text,
                    passwordField.text,
                    roleBox.currentText
                )

                close()
            }
        }
    }
}