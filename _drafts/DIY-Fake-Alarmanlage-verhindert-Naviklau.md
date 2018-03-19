---
layout: post
title:  Fake Alarmanlage selber bauen! Naviklau und Autodiebstahl günstig verhindern!
categories: ESP8266
author: Fabian Wetzel
excerpt: >
   <iframe width="560" height="315" src="https://www.youtube.com/embed/fz2OkOPKx1E" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
   <br />todo🦆💥

---
# TODO 🦆💥

<iframe width="560" height="315" src="https://www.youtube.com/embed/fz2OkOPKx1E" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>


## ziele erreichen

Das erste Ziel ist, dass eine LED blinkt. Dafür brauche ich ganz offensichtlich eine LED. 

Blinken lasse ich die LED mittels einens Mikrokontrollers. Da käme jetzt vermutlich jeder in Frage, aber ich habe den Wemos D1 Mini hier, daher nehme ich den auch direkt. Der ist eigentlich viel zu leistungsfähig, aber auch angenehm klein. 

Damit ist das erste Ziel einer blinkenden LED schon erreicht.

Als nächstes muss die Fakealarmanlage mit Strom versorgt werden und da ich ja eine Batterieentladung der Autobatterie vermeiden will, nehme ich eine USB Powerbank. Wie lange die hält und welche ich genau gekauft habe, kläre ich gleich. Auf jeden Fall ist damit das zweite Ziel erreicht.

Das dritte Ziel ist nun, die Powerbank ohne Umbaumaßnahmen am Auto zu laden, hier nehme ich ein Auto-USB-Ladegerät. Hier muss man eigentlich nur testen, ob das Zielauto die Steckdosen mit der Zündung schaltet. Wenn dem so ist, wird der Akku immer während der Fahrt aufgeladen. Ziel erreicht!

Bleibt nur noch das letzte Ziel: Das System muss ohne Steuerung von selbst erkennen, ob es blinken soll oder nicht. Ich will hier diese Information aus der geschalteten Steckdose ziehen. Jetzt kann der Code im ESP entsprechend reagieren, womit das letzte Ziel auch erreicht ist.

Ziele
- LED blinkt
- Keine Umbauten
- Keine Gefahr der Batterieentladung
- Schaltet von selbst an/aus

![Schaltungsüberblick](/assets/2018_mixed/fakealarmanlage/fakealarm_überblick.jpg)

## spannungen teilen

Aber schauen wir nochmal genauer darauf, wie der Mikrocontroller die Spannung des USB Netzteils liest.

Denn man muss hier darauf achten, dass der USB Adapter ja 5V liefert, der ESP aber nur 3,3V verträgt. Ich nehme hier einen Spannungsteiler aus drei gleichen Widerständen und komme so von 5 auf 3,3V. Wichtig ist auch noch, dass es eine gemeinsame Masse gibt.

![Schaltplan des Spannungsteilers](/assets/2018_mixed/fakealarmanlage/schaltplan_spannungsteiler.png)

## y kabel // kabelbau

TODO

# steckbrett

in voiceover

# outro

TODO

[EasyAcc 20000mAh Externer Akku PowerBank mit 4 USB Ausgängen (4A Eingang 4.8A Smart Ausgang)](http://amzn.to/2u6UHqY)


[AZDelivery D1 Mini NodeMcu Lua ESP8266 ESP-12E](http://amzn.to/2G73T37)


[Elegoo Electronic Fun Kit Breadboard Kabel Widerstand Kondensator LED Potentiometer für Arduino Learning Kit, UNO, MEGA2560 Arduino Electronic Kit](http://amzn.to/2G6wSnT)

[Anker PowerDrive 2 Elite 24W 2 Port Kfz Ladegerät, Auto Ladegerät mit PowerIQ Technologie für iPhone, iPad Air / Mini, Samsung Galaxy / Note, HTC, LG, Huawei, Xiaomi, alle Smartphones, Tablets, Bluetooth Geräten, Powerbank und mehr](http://amzn.to/2IEdT2n)

```text
    Ian = 90mA
    Iaus = 0,5mA
    Tan= 150mS
    Taus=1500mS
    Iavg = (90*150+0,5*1500)/(150+1500) = 8,6mA
    Q = 20.000mAh
    t = Q/I = 20.000mAh / 8,6mA = 96d

 Iavg = 8,6mA
    Q = 20.000mAh
    t = Q/I = 20.000mAh / 8,6mA = 96d
```


```c++
//an welchem Port ist die LED?
const int BLINK_LED = D6;
//an welchem Port kann das Laden erkannt werden? 
const int SENSE_PIN = D2;

void setup() {
  pinMode(SENSE_PIN, INPUT);
}

void loop() {
  if (!digitalRead(SENSE_PIN))
  {
    //Auto ist aus
    pinMode(BLINK_LED, OUTPUT);
    digitalWrite(BLINK_LED, LOW);
    delay(150);
    digitalWrite(BLINK_LED, HIGH);
    ESP.deepSleep(15e5); //=1,5s
  } else {
    //Auto ist an
    delay(500);
  }
}
```