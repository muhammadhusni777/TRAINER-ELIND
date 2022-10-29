import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0
import SDK 1.0
import QtCharts 2.1

Window {
	id : root
	width: 400
    maximumWidth : width
	minimumWidth : width
    height: 400
	maximumHeight : height
	minimumHeight : height
	title:"Job 4 : Membaca LDR"
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
	text : "Job 4 : LDR to PyQt5 Via MQTT" 
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
	anchors.horizontalCenter: parent.horizontalCenter
	y:200
	
	width : 100
	height : 100
	source : "sun.png"
	}
	
	Rectangle{
	y : 120
	width : 250
	height : 250
	anchors.horizontalCenter: parent.horizontalCenter
	color : "transparent"
	
	RadialBar {
				
	        	id : radial2
	            anchors.horizontalCenter: parent.horizontalCenter
	            anchors.bottom: parent.bottom
	            width: parent.width / 1.1
	            height: width - (0.00000000001)
	            penStyle: Qt.RoundCap
	            progressColor: "blue"
	            foregroundColor: "#04f8fa"
	            dialWidth: 24

				
	            minValue: 0
	            maxValue: 4096
	           // value: text_val2
	            
	            textFont 
	            {	
					
	                family: "Times New Roman"
	                italic: false
	                pointSize: 14
	            }

	            textColor: "black"
				
				
	        }
	
	}
	
	Text{
	id : ldr_val
	anchors.horizontalCenter: parent.horizontalCenter
	y:340
	text : radial2.value
	color : "white"
	font.pixelSize : 20
	}
    
	Timer{
		id: gui_timer
		interval: 50
		repeat: true
		running: true
		onTriggered: {
		//ldr_val.text = backend.ldr_value()
		radial2.value = backend.ldr_value()
		
		}
	}

	
}













