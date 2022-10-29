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

infrared_status = "off"

infrared_color = ""


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
    def infrared_color(self):  return infrared_color

    
    
#----------------------------------------------------------------#
def data_process(num):
    global infrared_color
    
    while True:
        if (infrared_status == "on"):
            infrared_color = "#04f8fa"
            
        if (infrared_status == "off"):
            infrared_color = "#df1c39"
            
            
    
    
#----------------------------------------------------------------#   
def on_message(client, userdata, message):
    msg = str(message.payload.decode("utf-8"))
    t = str(message.topic)

    if(msg[0] == 'c'):
        val =  1
    else:
        val = (msg)
        
    if (t == "trainer_iot_upi_01/infrared"):
        global infrared_status
        infrared_status = msg
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
    
    client.subscribe("trainer_iot_upi_01/infrared")
    
    t1 = threading.Thread(target=data_process, args=(10,))
    t1.start()
    
    main = table()
    
    
#----------------------------------------------------------------#
