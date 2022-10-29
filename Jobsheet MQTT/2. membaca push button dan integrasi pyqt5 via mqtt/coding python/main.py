######  PROGRAM MEMANGGIL WINDOWS PYQT5 ##########################

####### memanggil library PyQt5 ##################################
#----------------------------------------------------------------#
from PyQt5.QtCore import * 
from PyQt5.QtGui import * 
from PyQt5.QtQml import * 
from PyQt5.QtWidgets import *
from PyQt5.QtQuick import *  
import sys
#----------------------------------------------------------------#

import paho.mqtt.client as paho

import threading

broker="broker.emqx.io"
port =  1883
topic_test = ""

button1_status = "off"
button2_status = "off"

button1_color = ""
button2_color = ""

########## mengisi class table dengan instruksi pyqt5#############
#----------------------------------------------------------------#
class table(QObject):    
    def __init__(self, parent = None):
        super().__init__(parent)
        self.app = QApplication(sys.argv)
        self.engine = QQmlApplicationEngine(self)
        self.engine.rootContext().setContextProperty("backend", self)    
        self.engine.load(QUrl("main.qml"))
        sys.exit(self.app.exec_())
        
    @pyqtSlot(result=str)
    def button1_color(self):  return button1_color
    
    @pyqtSlot(result=str)
    def button2_color(self):  return button2_color
    
    
#----------------------------------------------------------------#
def data_process(num):
    global button1_color
    global button2_color
    
    while True:
        if (button1_status == "on"):
            button1_color = "green"
            
        if (button1_status == "off"):
            button1_color = "red"
            
        if (button2_status == "on"):
            button2_color = "green"
        
        if (button2_status == "off"):
            button2_color = "red"
    
    
    
#----------------------------------------------------------------#   
def on_message(client, userdata, message):
    msg = str(message.payload.decode("utf-8"))
    t = str(message.topic)

    if(msg[0] == 'c'):
        val =  1
    else:
        val = (msg)
        
    if (t == "trainer_iot_upi_01/button1"):
        global button1_status
        button1_status = msg
        #print(msg)
        
    if (t == "trainer_iot_upi_01/button2"):
        global button2_status
        button2_status = msg
        #print(msg)
        
        
        
########## memanggil class table di mainloop######################
#----------------------------------------------------------------#    
if __name__ == "__main__":
    
    client= paho.Client("GUI")
    client.on_message=on_message

    print("connecting to broker ",broker)
    client.connect(broker,port)#connect
    print(broker," connected")
    
    client.loop_start()
    print("Subscribing")
    
    client.subscribe("trainer_iot_upi_01/button1")
    client.subscribe("trainer_iot_upi_01/button2")
    
    t1 = threading.Thread(target=data_process, args=(10,))
    t1.start()
    
    main = table()
    
    
#----------------------------------------------------------------#
