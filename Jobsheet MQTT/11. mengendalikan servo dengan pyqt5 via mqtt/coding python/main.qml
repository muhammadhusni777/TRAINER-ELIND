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
	title:"Job 11 : Menyalakan motor servo"
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
	text : "Job 11 : Servo from PyQt5 Via MQTT" 
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
	to : 180
	value : 0
	width : 450
	stepSize : 1
	
	}
	
	CircularGauge {
			id: gauge2
			width: 300
			height: 300
			value: slider1.value
			anchors.centerIn: parent
			minimumValue : 0
			maximumValue : 180
			//tickmarkStepSize : 1
			style: CircularGaugeStyle {
				id: style
				labelStepSize: Math.floor((gauge2.maximumValue - gauge2.minimumValue)/5)
				
				
				function degreesToRadians(degrees) {
					return degrees * (Math.PI / 180);
				}
				
						
				background: Canvas {
					onPaint: {
						var ctx = getContext("2d");
						ctx.reset();
						ctx.beginPath();
						ctx.strokeStyle = "#e34c22";
						ctx.lineWidth = outerRadius * 0.02;
						ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,degreesToRadians(valueToAngle(0) - 90), degreesToRadians(valueToAngle(180) - 90));
						ctx.stroke();
					}
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













