#include <WiFi.h>
#include <PubSubClient.h>
#include <Wire.h>

#include <LiquidCrystal_I2C.h>

// Set the LCD address to 0x27 for a 16 chars and 2 line display
LiquidCrystal_I2C lcd(0x27, 16, 2);




// Replace the next variables with your SSID/Password combination
const char* ssid = "Wifihusni12";
const char* password = "123456789";
const char* mqtt_server = "broker.emqx.io";

WiFiClient espClient;
PubSubClient client(espClient);
long lastMsg = 0;
char msg[50];
int value = 0;


#include <TM1637Display.h>


// Define the connections pins
#define CLK 19 //clk tm1637
#define DIO 18 //dio tm1637


// LED Pin
/*
const int led1_pin = 2; //led builtin
const int led2_pin = 32; //led onboard
const int led3_pin = 33; //led onboard
*/

const int led1_pin = 12; //led rgb
const int led2_pin = 13; //led rgb
const int led3_pin = 14; //led rgb

const int pwm_pin = 23; 

// button pin
const int button1_pin = 17; //infrared
const int button2_pin = 19;

int button1_state;
int button2_state;
int pwm_value;

int buzzer = 5;//buzzer

int analog;

int seven_segment_value;

// Create display object of type TM1637Display
TM1637Display display = TM1637Display(CLK, DIO);

void setup() {
  
  lcd.begin();
  // Turn on the blacklight and print a message.
  lcd.clear();
  lcd.backlight();
  lcd.setCursor(0,0);
  lcd.print(mqtt_server);

  
  Serial.begin(115200);
  setup_wifi();
  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);

  pinMode(led1_pin, OUTPUT);
  pinMode(led2_pin, OUTPUT);
  pinMode(led3_pin, OUTPUT);


  pinMode(button1_pin, INPUT_PULLUP);
  pinMode(button2_pin, INPUT_PULLUP);

  pinMode(34, INPUT);
  
  ledcSetup(0, 1000, 8);
  ledcAttachPin(pwm_pin, 0);

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

  
  if (String(topic) == "trainer_iot_upi_01/led1") {
    Serial.print("Changing output to ");
    if(messageTemp == "on"){
      Serial.println("ON");
      digitalWrite(led1_pin, HIGH);
    }
    else if(messageTemp == "off"){
      Serial.println("OFF");
      digitalWrite(led1_pin, LOW);
    }
  }

  if (String(topic) == "trainer_iot_upi_01/led2") {
    Serial.print("Changing output to ");
    if(messageTemp == "on"){
      Serial.println("ON");
      digitalWrite(led2_pin, HIGH);
    }
    else if(messageTemp == "off"){
      Serial.println("OFF");
      digitalWrite(led2_pin, LOW);
    }
  }

  if (String(topic) == "trainer_iot_upi_01/led3") {
    Serial.print("Changing output to ");
    if(messageTemp == "on"){
      Serial.println("ON");
      digitalWrite(led3_pin, HIGH);
    }
    else if(messageTemp == "off"){
      Serial.println("OFF");
      digitalWrite(led3_pin, LOW);
    }
  }


  if (String(topic) == "trainer_iot_upi_01/seven_segment") {
    seven_segment_value = messageTemp.toInt();
  
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
      client.subscribe("trainer_iot_upi_01/seven_segment");      
      client.subscribe("analog_send");
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
  client.loop();

  ledcWrite(0, pwm_value);


  display.showNumberDec(seven_segment_value);
  

  long now = millis();
  if (now - lastMsg > 1000) {
    lastMsg = now;
    
    //kirim data 
    analog = analogRead(34);   
    char analog_send[8];
    dtostrf(analog, 1, 2, analog_send);
    
    client.publish("trainer_iot_upi_01/potensiometer", analog_send);
    
    button1_state = !digitalRead(button1_pin);
    if (button1_state == 1){
      client.publish("trainer_iot_upi_01/sensor1", "on");
    } else{
      client.publish("trainer_iot_upi_01/sensor1", "off");
    }


    button2_state = !digitalRead(button2_pin);
    if (button2_state == 1){
      client.publish("trainer_iot_upi_01/sensor2", "on");
    } else{
      client.publish("trainer_iot_upi_01/sensor2", "off");
    }



  }
}
