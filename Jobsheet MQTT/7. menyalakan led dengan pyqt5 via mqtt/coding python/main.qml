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
	title:"Job 6 : Menyalakan Led"
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
	text : "Job 6 : Led from PyQt5 Via MQTT" 
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
	
	Button {
		id : button1
		x: 100
		y : 200
		width : 250
		height : 50
        checked: false
        checkable : true
		
		onClicked:{
					if (button1.checked == true){
					button1_color.color = "red" 
					
					}
					
					if (button1.checked == false){
					button1_color.color = "blue" 
					
					}
					
					}
		
		Rectangle{
			id : button1_color
			width : parent.width
			height : parent.height
			color : "blue"
			
			Text{
				anchors.horizontalCenter: parent.horizontalCenter
				y:10
				text : "Led 1" 
				color : "white"
				font.pixelSize : 20
			}
			
		}
		
		
    }
	
	
	
	
	Button {
		id : button2
		x: 100
		y : 300
		width : 250
		height : 50
        checked: false
        checkable : true
		
		onClicked:{
					if (button2.checked == true){
					button2_color.color = "red" 
					
					}
					
					if (button2.checked == false){
					button2_color.color = "blue" 
					
					}
					
					}
		
		Rectangle{
			id : button2_color
			width : parent.width
			height : parent.height
			color : "blue"
			
			Text{
				anchors.horizontalCenter: parent.horizontalCenter
				y:10
				text : "Led 2" 
				color : "white"
				font.pixelSize : 20
			}
			
		}
		
		
    }
	
	
	
	Button {
		id : button3
		x: 100
		y : 400
		width : 250
		height : 50
        checked: false
        checkable : true
		
		onClicked:{
					if (button3.checked == true){
					button3_color.color = "red" 
					
					}
					
					if (button3.checked == false){
					button3_color.color = "blue" 
					
					}
					
					}
		
		Rectangle{
			id : button3_color
			width : parent.width
			height : parent.height
			color : "blue"
			
			Text{
				anchors.horizontalCenter: parent.horizontalCenter
				y:10
				text : "Led 3" 
				color : "white"
				font.pixelSize : 20
			}
			
		}
		
		
    }
	
	
	
	
	
	Timer{
		id: gui_timer
		interval: 1000
		repeat: true
		running: true
		onTriggered: {
			backend.button1(button1.checked)
			backend.button2(button2.checked)
			backend.button3(button3.checked)
		
		}
	}

	
}













