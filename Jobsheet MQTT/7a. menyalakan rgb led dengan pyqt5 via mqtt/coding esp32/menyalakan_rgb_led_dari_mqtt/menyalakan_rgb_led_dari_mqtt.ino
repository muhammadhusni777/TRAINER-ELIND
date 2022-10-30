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

#include "DHT.h"

#define DHTPIN 16 

#define DHTTYPE DHT11 


DHT dht(DHTPIN, DHTTYPE);


float temperature;
float humidity;

long lastMsg = 0;
char msg[50];
int value = 0;

const int led1_pin = 12;
const int led2_pin = 13; 
const int led3_pin = 14; 

int led1_value;
int led2_value;
int led3_value;


unsigned long data_send_time;
unsigned long data_send_time_prev;
unsigned long data_send_period = 2000;

void setup() {
  
  lcd.begin();
  lcd.clear();
  lcd.backlight();
  lcd.setCursor(0,0);
  lcd.print(mqtt_server);

  pinMode(led1_pin, OUTPUT);
  pinMode(led2_pin, OUTPUT);
  pinMode(led3_pin, OUTPUT);

  ledcSetup(0, 1000, 8);
  ledcAttachPin(led1_pin, 0);

  ledcSetup(1, 1000, 8);
  ledcAttachPin(led2_pin, 1);

  ledcSetup(2, 1000, 8);
  ledcAttachPin(led3_pin, 2);
  
  Serial.begin(115200);
  setup_wifi();
  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);

  dht.begin();
  
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

  
  if (String(topic) == "trainer_iot_upi_01/led1") {
    led1_value = messageTemp.toInt();
    
  }

  if (String(topic) == "trainer_iot_upi_01/led2") {
    led2_value = messageTemp.toInt();
  }

  if (String(topic) == "trainer_iot_upi_01/led3") {
    led3_value = messageTemp.toInt();
  }
}



void reconnect() {
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    if (client.connect("ESP32Client")) {
      Serial.println("connected");
      client.subscribe("trainer_iot_upi_01/led1");
      client.subscribe("trainer_iot_upi_01/led2");
      client.subscribe("trainer_iot_upi_01/led3");
     
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
  ledcWrite(0, led1_value);
  ledcWrite(1, led2_value);
  ledcWrite(2, led3_value);
  data_send_time = millis() - data_send_time_prev;
  if (data_send_time > data_send_period){

    
    data_send_time_prev = millis();
  }

  
  client.loop();
  }
