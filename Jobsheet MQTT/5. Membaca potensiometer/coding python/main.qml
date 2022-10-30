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
	title:"Job 5 : Membaca potensiometer"
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
	text : "Job 5 : Potensiometer to PyQt5 Via MQTT" 
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
	
	CircularGauge {
			id: pot_gauge
			width: 300
			height: 300
			value: 0
			anchors.centerIn: parent
			minimumValue : 0
			maximumValue : 4096
			//tickmarkStepSize : 1
			style: CircularGaugeStyle {
				id: style
				labelStepSize: Math.floor((pot_gauge.maximumValue - pot_gauge.minimumValue)/5)
				
				
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
						ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,degreesToRadians(valueToAngle(0) - 90), degreesToRadians(valueToAngle(100) - 90));
						ctx.stroke();
					}
				}
					
				
			}
			
			
			
			
			Rectangle {
				id:rectsg2
				anchors.horizontalCenter: parent.horizontalCenter
				y: 250
				width: 40
				height: 20
				color: "#000212"
				Text {
					
					anchors.horizontalCenter: parent.horizontalCenter
					text: (pot_gauge.value).toFixed(1)
					font.family: "Times New Roman"
					font.pointSize: 14
					color: "white"
				}
			}
			
			
		
		
		}
	
	
	
	
	
	Timer{
		id: gui_timer
		interval: 50
		repeat: true
		running: true
		onTriggered: {
			
		pot_gauge.value = backend.potensiometer_value().toFixed(0)
		}
	}

	
}













