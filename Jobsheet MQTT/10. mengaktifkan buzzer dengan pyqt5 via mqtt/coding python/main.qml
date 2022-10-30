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
	title:"Job 10 : Menyalakan buzzer"
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
	text : "Job 10 : buzzer from PyQt5 Via MQTT" 
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
	
	
	
	Text{
	anchors.horizontalCenter: parent.horizontalCenter
	y:300
	text :  (slider1.value).toFixed(0)
	color : "gold"
	font.pixelSize : 70
	}
	
	Slider{
	id : slider1
	anchors.horizontalCenter: parent.horizontalCenter
	y : 430
	from : 0
	to : 255
	value : 0
	width : 450
	stepSize : 1
	
	}
	
	Gauge {
		id : buzzer_gauge
		x: 50
		y: 160
		height : 240
		width : 150
		minimumValue: 0
		minorTickmarkCount: 0
		font.pixelSize: 20
		maximumValue: 255
		tickmarkStepSize: 50
		value : slider1.value
		style: GaugeStyle {
			
			valueBar: Rectangle {
				color: "blue"
				implicitWidth: 60
			}

			
						
		
		}
	}
	
	
	
	
	
	
	Timer{
		id: gui_timer
		interval: 1000
		repeat: true
		running: true
		onTriggered: {
			backend.slider1(slider1.value)
			
		
		}
	}

	
}













