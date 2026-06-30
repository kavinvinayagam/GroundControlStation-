import QtQuick
import QtQuick.Controls

Page {

    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        Label {
            text: "User Management"
            font.pixelSize: 24
        }

        Row {
            spacing: 10

            Button {
                text: "Add User"

                onClicked: {
                    createUserDialog.open()
                }
            }

            Button {
                text: "Refresh"

                onClicked: {
                    authManager.loadUsers()
                }
            }
        }

        TableView {
            anchors.left: parent.left
            anchors.right: parent.right
            height: 500

            model: authManager.userModel
        }
    }

    CreateUserDialog {
        id: createUserDialog
    }
}