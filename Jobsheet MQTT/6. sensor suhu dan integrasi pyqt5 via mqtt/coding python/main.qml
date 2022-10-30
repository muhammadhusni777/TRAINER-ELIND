import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0

Window {
	id : root
	width: 500
    maximumWidth : width
	minimumWidth : width
    height: 600
	maximumHeight : height
	minimumHeight : height
	title:"Job 6 : Membaca sensor suhu"
	color : "#000212"
    visible: true
    flags: Qt.Dialog // Qt.WindowMaximized //
	
	Rectangle{
	x:0
	y:30
	width : parent.width - 20
	anchors.horizontalCenter: parent.horizontalCenter
	height : 100
	color : "#122e55"
	border.color: "white"
    border.width: 4
	
	Text{
	anchors.horizontalCenter: parent.horizontalCenter
	y:10
	text : "Job 6 : DHT11 to PyQt5 Via MQTT" 
	color : "white"
	font.pixelSize : 20
	}
	
	Text{
	anchors.horizontalCenter: parent.horizontalCenter
	y:40
	text : "Muhammad Husni (1503467)" 
	color : "white"
	font.pixelSize : 20
	}
	
	Text{
	anchors.horizontalCenter: parent.horizontalCenter
	y:70
	text : "ELIND 2015" 
	color : "white"
	font.pixelSize : 20
	}
	
	}
	
	Image{
		x : -20
		y : 180
		width : 300
		height : 350
		source : "thermometer.png"
	}
	
	Gauge {
		id : temp_gauge
		x: 100
		y: 180
		height : 270
		width : 150
		minimumValue: 0
		minorTickmarkCount: 0
		font.pixelSize: 1
		value: 36
		maximumValue: 50
		tickmarkStepSize: 50
		
		style: GaugeStyle {
			
			valueBar: Rectangle {
				color: "red"
				implicitWidth: 20
			}

			tickmark: Item {
				implicitWidth: 18
				implicitHeight: 1

				Rectangle {
					visible : false
					color: "#c8c8c8"
					anchors.fill: parent
					anchors.leftMargin: 3
					anchors.rightMargin: 3
				}
			}
						
		
		}
	}
	
	
	
	Rectangle {
	x: 100
	y:445
     width: 60
     height: 60
     color: "red"
     radius: width*0.5
    
}


	Text{
	x: 50
	y:550
	text : "Temperatur : " + temp_gauge.value + " °C"
	color : "white"//"#04f8fa"
	font.pixelSize : 20
	}
	
	
	Gauge {
		id : hum_gauge
		x: 330
		y: 200
		height : 330
		width : 150
		minimumValue: 0
		minorTickmarkCount: 0
		font.pixelSize: 10
		value: 36
		maximumValue: 100
		tickmarkStepSize: 10
		
		style: GaugeStyle {
			
			valueBar: Rectangle {
				color: "blue"
				implicitWidth: 80
			}
			
		}
	}
	
	Text{
	x: 300
	y:550
	text : "Kelembaban : " + hum_gauge.value + " %"
	color : "white"//"#04f8fa"
	font.pixelSize : 20
	}
	
	Timer{
		id: gui_timer
		interval: 50
		repeat: true
		running: true
		onTriggered: {
			temp_gauge.value = backend.temperature_value()
			hum_gauge.value = backend.humidity_value()
		
		}
	}

	
}













