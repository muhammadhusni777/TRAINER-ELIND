/*  
 * JOB 5 : Membaca dht via mqtt
 * Written by : Muhammad Husni Muttaqin (1503467)
 * 
 */


#include <WiFi.h>
#include <PubSubClient.h>
#include <Wire.h>

#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd(0x27, 16, 2);


const char* ssid = "Wifihusni12";
const char* password = "123456789";
const char* mqtt_server = "broker.emqx.io";

WiFiClient espClient;
PubSubClient client(espClient);

#include <TM1637Display.h>


// Define the connections pins
#define CLK 19 //clk tm1637
#define DIO 18 //dio tm1637

long lastMsg = 0;
char msg[50];
int value = 0;



unsigned long data_send_time;
unsigned long data_send_time_prev;
unsigned long data_send_period = 2000;

TM1637Display display = TM1637Display(CLK, DIO);

int seven_segment_value;

void setup() {
  
  lcd.begin();
  lcd.clear();
  lcd.backlight();
  lcd.setCursor(0,0);
  lcd.print(mqtt_server);


 
  Serial.begin(115200);
  setup_wifi();
  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);

  // Set the display brightness (0-7)
  display.setBrightness(5);
  
  // Clear the display
  display.clear();  
  
}

void setup_wifi() {
  delay(10);
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
    lcd.setCursor(0,1);
    lcd.print("ATTEMPTING");
  }

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  lcd.setCursor(0,1);
  lcd.print("CONNECTED ");
}

void callback(char* topic, byte* message, unsigned int length) {
  Serial.print("Message arrived on topic: ");
  Serial.print(topic);
  Serial.print(". Message: ");
  String messageTemp;
  
  for (int i = 0; i < length; i++) {
    Serial.print((char)message[i]);
    messageTemp += (char)message[i];
  }
  Serial.println();

  
  if (String(topic) == "trainer_iot_upi_01/7segment") {
    seven_segment_value = messageTemp.toInt();
    
  }

 
}



void reconnect() {
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    if (client.connect("ESP32Client")) {
      Serial.println("connected");
      client.subscribe("trainer_iot_upi_01/7segment");
      
     
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      delay(5000);
    }
  }
}


void loop() {
  if (!client.connected()) {
    reconnect();
    
  }

  display.showNumberDec(seven_segment_value);
  
  data_send_time = millis() - data_send_time_prev;
  if (data_send_time > data_send_period){

    
    data_send_time_prev = millis();
  }

  
  client.loop();
  }
