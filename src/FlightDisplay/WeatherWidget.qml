import QtQuick
import QtQuick.Controls

import QGroundControl
import QGC.Weather 1.0

Rectangle {
    width: 240
    height: 180

    radius: 10
    color: "#CC202020"

    border.color: "#4FC3F7"
    border.width: 1

    property var activeVehicle: QGroundControl.multiVehicleManager.activeVehicle
    property string lastUpdate: "--:--:--"

    function updateWeather() {

        if (activeVehicle) {

            WeatherManager.fetchWeather(
                activeVehicle.coordinate.latitude,
                activeVehicle.coordinate.longitude
            )

        } else {

            // Fallback location
            WeatherManager.fetchWeather(
                12.9716,
                77.5946
            )
        }

        lastUpdate = Qt.formatTime(new Date(), "hh:mm:ss")
    }

    Component.onCompleted: {
        updateWeather()
    }

    Timer {
        interval: 3000
        running: true
        repeat: true

        onTriggered: {
            updateWeather()
        }
    }

    Column {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 6

        Text {
            text: "🌦 Weather Monitor"
            color: "white"
            font.bold: true
            font.pixelSize: 16
        }

        Text {
            text: "🌡 Temp: "
                  + WeatherManager.temperature.toFixed(1)
                  + " °C"
            color: "white"
        }

        Text {
            text: "💧 Humidity: "
                  + WeatherManager.humidity.toFixed(0)
                  + " %"
            color: "white"
        }

        Text {
            text: "🌬 Wind: "
                  + WeatherManager.windSpeed.toFixed(1)
                  + " km/h"
            color: "white"
        }

        Text {
            text: "🧭 Direction: "
                  + WeatherManager.windDirection.toFixed(0)
                  + "°"
            color: "white"
        }

        Text {
            text: activeVehicle
                  ? "📍 Live Drone Location"
                  : "📍 Default Location"
            color: "#4FC3F7"
        }

        Text {
            text: "⏱ Updated: " + lastUpdate
            color: "#B0BEC5"
            font.pixelSize: 11
        }

        Text {
            text: "⚠ Flight Risk: LOW"
            color: "lightgreen"
        }
    }
}