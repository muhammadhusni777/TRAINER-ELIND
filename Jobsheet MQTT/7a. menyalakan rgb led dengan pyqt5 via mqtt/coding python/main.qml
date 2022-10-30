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
	title:"Job 7 : Menyalakan RGB Led"
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
	text : "Job 7 : Led from PyQt5 Via MQTT" 
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
					slider1.visible = true 
					}
					
					if (button1.checked == false){
					button1_color.color = "blue" 
					slider1.visible = false
					slider1.value = 0
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
				text : "Led Red" 
				color : "white"
				font.pixelSize : 20
			}
			
		}
		
		
    }
	
	Slider{
	id : slider1
	x: 90
	y : 270
	from : 0
	to : 255
	value : 0
	width : 300
	visible : false
	
	}
	
	
	
	
	Button {
		id : button2
		x: 100
		y : 320
		width : 250
		height : 50
        checked: false
        checkable : true
		
		onClicked:{
					if (button2.checked == true){
					button2_color.color = "red" 
					slider2.visible = true
					}
					
					if (button2.checked == false){
					button2_color.color = "blue" 
					slider2.visible = false
					slider2.value = 0
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
				text : "Led Green" 
				color : "white"
				font.pixelSize : 20
			}
			
		}
		
		
    }
	
	Slider{
	id : slider2
	x: 90
	y : 390
	from : 0
	to : 255
	value : 0
	width : 300
	visible : false
	}
	
	
	Button {
		id : button3
		x: 100
		y : 450
		width : 250
		height : 50
        checked: false
        checkable : true
		
		onClicked:{
					if (button3.checked == true){
					button3_color.color = "red" 
					slider3.visible = true
					}
					
					if (button3.checked == false){
					button3_color.color = "blue" 
					slider3.visible = false
					slider3.value = 0
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
				text : "Led Blue" 
				color : "white"
				font.pixelSize : 20
			}
			
		}
		
		
    }
	
	Slider{
	id : slider3
	x: 90
	y : 520
	from : 0
	to : 255
	value : 0
	width : 300
	visible : false
	}
	
	
	
	Timer{
		id: gui_timer
		interval: 1000
		repeat: true
		running: true
		onTriggered: {
			backend.slider1(slider1.value)
			backend.slider2(slider2.value)
			backend.slider3(slider3.value)
		
		}
	}

	
}













