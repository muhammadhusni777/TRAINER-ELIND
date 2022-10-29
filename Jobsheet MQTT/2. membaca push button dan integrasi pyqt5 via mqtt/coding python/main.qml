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
	title:"Job 2 : Membaca Push Button"
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
	text : "Job 2 : Push Button to PyQt5 Via MQTT" 
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
	

    StatusIndicator {
		id : button_status1
		x : 75
		y : 200
		width: 100
		height: 100
        color: "green"
		active : true
    }
	
	Text{
	x:80
	y:300
	text : "BUTTON 1" 
	color : "white"
	font.pixelSize : 20
	}
	
	
	StatusIndicator {
		id : button_status2
		x : 225
		y : 200
		width: 100
		height: 100
        color: "green"
		active : true
    }
	
	Text {
	x:230
	y:300
	text : "BUTTON 2" 
	color : "white"
	font.pixelSize : 20
	}
	
	
	Timer{
		id: gui_timer
		interval: 50
		repeat: true
		running: true
		onTriggered: {
		 button_status1.color = backend.button1_color()
		 button_status2.color = backend.button2_color()
		
		}
	}

	
}













