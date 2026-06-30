import QtQuick
import QtQuick.Controls

Page {

    Column {
        anchors.centerIn: parent

        Label {
            text: "Operator Dashboard"
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