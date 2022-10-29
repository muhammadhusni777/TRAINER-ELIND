import QtQuick 2.12
import QtQuick.Window 2.13
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0


Window {
	id : root
	width: 400
    maximumWidth : width
	minimumWidth : width
    height: 400
	maximumHeight : height
	minimumHeight : height
	title:"Job 3 : Membaca Infrared"
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
	text : "Job 3 : Infrared to PyQt5 Via MQTT" 
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
	
	
	Rectangle{
	id : infrared
	x:0
	y:200
	width : 130
	anchors.horizontalCenter: parent.horizontalCenter
	height : 130
	color : "#122e55"
	border.color: "white"
    border.width: 4
	
	Image {
	anchors.verticalCenter: parent.verticalCenter
	anchors.horizontalCenter: parent.horizontalCenter
	width : parent.width - 20
	height : parent.height - 20
	source :"infrared.png"
		
	}
	
	}

	Text{
	anchors.horizontalCenter: parent.horizontalCenter
	y:340
	text : "INFRARED" 
	color : "white"
	font.pixelSize : 20
	}
    
	Timer{
		id: gui_timer
		interval: 50
		repeat: true
		running: true
		onTriggered: {
		 infrared.color = backend.infrared_color()
		
		}
	}

	
}













