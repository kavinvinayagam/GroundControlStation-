import QtQuick
import QtQuick.Controls

Page {

    Column {
        anchors.centerIn: parent
        spacing: 20

        Label {
            text: "Admin Dashboard"
            font.pixelSize: 28
        }

        Button {
            text: "User Management"

            onClicked: {
                stackView.push(
                    "UserManagementPage.qml"
                )
            }
        }

        Button {
            text: "Ground Controller"

            onClicked: {
                stackView.push(
                    "GroundControlPage.qml"
                )
            }
        }
    }
}