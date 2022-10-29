######  PROGRAM MEMANGGIL WINDOWS PYQT5 ##########################

####### memanggil library PyQt5 ##################################
#----------------------------------------------------------------#
import sys, string, os
from PyQt5 import QtGui, QtCore, Qt,QtQml
from PyQt5.QtCore import QUrl, QObject, pyqtSignal, pyqtSlot, QTimer, pyqtProperty
from PyQt5.QtCore    import pyqtSlot, pyqtSignal, QUrl, QObject,QStringListModel, Qt
from PyQt5.QtQuick   import QQuickView
from PyQt5.QtWidgets import QApplication, QCheckBox, QGridLayout, QGroupBox
from PyQt5.QtWidgets import QMenu, QPushButton, QRadioButton, QVBoxLayout, QWidget, QSlider
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtGui import QGuiApplication, QIcon
from RadialBar import RadialBar
import threading


#----------------------------------------------------------------#

import paho.mqtt.client as paho

import threading

from RadialBar import RadialBar

broker="broker.emqx.io"
port =  1883
topic_test = ""

ldr_value = 0.0


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
        
    @pyqtSlot(result=float)
    def ldr_value(self):  return float(ldr_value)

    
    
#----------------------------------------------------------------#
def data_process(num):
    
    while True:
        pass
            
            
    
    
#----------------------------------------------------------------#   
def on_message(client, userdata, message):
    msg = str(message.payload.decode("utf-8"))
    t = str(message.topic)

    if(msg[0] == 'c'):
        val =  1
    else:
        val = (msg)
        
    if (t == "trainer_iot_upi_01/ldr"):
        global ldr_value
        ldr_value = float(msg)
        print(msg)
        
    
        
        
        
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
    
    client.subscribe("trainer_iot_upi_01/ldr")
    
    #t1 = threading.Thread(target=data_process, args=(10,))
    #t1.start()
    QtQml.qmlRegisterType(RadialBar, "SDK", 1,0, "RadialBar")
    main = table()
    
    
#----------------------------------------------------------------#
