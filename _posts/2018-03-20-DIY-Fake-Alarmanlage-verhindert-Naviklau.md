---
layout: post
title:  Fake Alarmanlage selber bauen! Naviklau und Autodiebstahl günstig verhindern!
categories: ESP8266
author: Fabian Wetzel
excerpt: >
   <iframe width="560" height="315" src="https://www.youtube.com/embed/fz2OkOPKx1E" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
   <br />Einem guten Freund wurde das Auto aufgebrochen und es wurde das komplette Navigations- und Entertainmentsystem geklaut. Das Auto hat auch keine Alarmanlage. Ich habe das beobachtet und mir dazu was überlegt.

---
## Fake Alarmanlage selber bauen!

Einem guten Freund wurde das Auto aufgebrochen und es wurde das komplette Navigations- und Entertainmentsystem geklaut. Das Auto hat auch keine Alarmanlage. Ich habe das beobachtet und mir meine Gedanken gemacht. Eine Alarmanlage nachzurüsten ist möglich, aber auch teuer und dann bleibt die Frage, ob sie wirklich was bringt?! Meine Idee war nun, die Existenz einer Alarmanlage zu faken in dem man die charakteristisch blinkende LED einfach nachbaut. Der Dieb kann vor dem Aufbruch des Autos ja nicht wissen, ob das nun Fake oder echt ist, sofern er es nicht an Details erkennt.

### Wie immer auch als Video 🎥

<iframe width="560" height="315" src="https://www.youtube.com/embed/fz2OkOPKx1E" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

Falls du nur das Video schaust, solltest du unten unbedingt noch den Hinweis zum DeepSleep des ESP lesen, denn der hat es leider nicht ins Video geschafft.

## Ziele (m)einer Fake-Alarmanlage ☑️

Es soll eine LED blinken, aber ich will mich nicht der Gefahr aussetzen, dass das Auto deshalb nicht anspringt, da im Stand die Batterie leer gesaugt wurde. Außerdem will ich keine tiefgreifenden Umbauten am Auto machen und abschließend soll das Blinken automatisch an und aus gehen, je nachdem ob das Auto an ist oder nicht. 4 kleine Ziele, die ich jetzt nacheinander angehe:

### 1. Es soll blinken 💡

Das erste Ziel ist, dass eine LED blinkt. Dafür brauche ich ganz offensichtlich eine LED.

Blinken lasse ich die LED mittels eines Mikrokontrollers. Da käme jetzt vermutlich jeder in Frage, aber ich habe den Wemos D1 Mini hier (bzw. das dazu kompatible Modul [AZDelivery D1 Mini NodeMcu Lua ESP8266 ESP-12E](http://amzn.to/2G73T37)), daher nehme ich den auch direkt. Der ist eigentlich viel zu leistungsfähig, aber auch angenehm klein. Damit ist das erste Ziel einer blinkenden LED schon erreicht.

### 2. Keine Gefahr der Entladung der Autobatterie 🔋

Als nächstes muss die Fakealarmanlage mit Strom versorgt werden und da ich eine Batterieentladung der Autobatterie vermeiden will, nehme ich eine USB Powerbank. Wie lange die hält und welche ich genau gekauft habe, kläre ich gleich, **denn es kann leider nicht jede Powerbank verwendet werden**! Auf jeden Fall ist damit das zweite Ziel erreicht.

### 3. Keine Umbaumaßnahmen am Auto 🚗

Das dritte Ziel ist nun, die Powerbank ohne Umbaumaßnahmen am Auto zu laden. Hier nehme ich ein [Auto-USB-Ladegerät](http://amzn.to/2IEdT2n). Man muss dabei eigentlich nur testen, ob das Zielauto die Steckdosen mit der Zündung schaltet. Wenn dem so ist, wird der Akku immer während der Fahrt aufgeladen. Ziel erreicht!

### 4. Automatische an/aus-schalten des Blinkens 🕹️

Bleibt nur noch das letzte Ziel: Das System muss ohne Steuerung von selbst erkennen, ob es blinken soll oder nicht. Ich will hier diese Information aus der geschalteten USB-Steckdose ziehen. Jetzt kann der Code im ESP entsprechend reagieren, womit das letzte Ziel auch erreicht ist.

## Finales Blockdiagramm

![Schaltungsüberblick](/assets/2018_mixed/fakealarmanlage/fakealarm_überblick.jpg)

Auf diesem Bild ist nun zu sehen, wie alle Komponenten ineinander greifen und zusammen die geforderten Anforderungen erfüllen. Zwei Besonderheiten gilt es dabei aber genauer zu betrachten.

### 1. Y-USB-Kabel selbst bauen

Vom USB-Stromadapter gehen zwei Verbindungskabel weg. Das eine geht zur Powerbank, das andere direkt zum ESP8266. Es ist hier durchaus möglich, tatsächlich zwei USB Kabel zu verwenden sofern der Stromadapter über mindestens zwei Anschlüsse verfügt. Ich habe jedoch ein Kabel der Powerbank genommen (Sie wird sogar mit zwei Kabeln geliefert!) und habe dieses in der Mitte aufgetrennt. Dann habe ich ein zwei-adriges Kabel parallel verlötet. Das USB-Kabel hatte ohnehin nur zwei Adern, es ist also ein reines Stromkabel ohne Datenübertragung. Mittels des angelöteten separaten Kabels kann ich nun erkennen, ob die Zündung des Autos an ist oder nicht.

### 2. Der ESP kann keine 5V. Spannungen teilen! ⚡

Genau dieses Kabel liefert aber nun 5V Spannung, der ESP kann aber nur 3,3V ohne Schaden vertragen. Ich nehme hier einen Spannungsteiler aus drei gleichen Widerständen und komme so von 5V auf 3,3V. Wichtig ist auch noch, dass es eine gemeinsame Masse gibt:

![Schaltplan des Spannungsteilers](/assets/2018_mixed/fakealarmanlage/schaltplan_spannungsteiler.png)

## Alles auf dem Steckbrett

Das ist jetzt alles nicht mehr wirklich schwer, es auf dem Steckbrett zusammen zu schalten. Ich habe an meinen Wemos D1 mini die Beinchen angelötet. Sonst muss man den Spannungsteiler aufbauen, eine LED mit Vorwiderstand und ansonsten nur noch das USB-Kabel von der Powerbank an den Wemos stecken. Fertig.

### Wichtig für DeepSleep!

Für das erfolgreiche Aufwachen aus dem DeepSleep des ESPs ist eine direkte Verbindung von `D0` mit `RST` nötig ([Quelle](https://www.losant.com/blog/making-the-esp8266-low-powered-with-deep-sleep)). Die Verbindung soll ein normales Kabel sein. Sie darf aber nicht da sein, wenn der ESP über USB programmiert werden soll. Das ist auf einem Steckbrett nicht schwer, denn man kann hier einfach die Verbindung kurz lösen, aber wenn man das zusammen lötet, ist es problematisch. Ich habe hier testweise einen 220 Ohm Widerstand zwischen geschaltet und hatte damit manchmal (!) Erfolg, den ESP zu programmieren und ihn gleichzeitig auch aufwecken zu lassen. Probier es bitte selbst aus und lass es mich wissen, wie es lief!

## Code

Der Code ist eigentlich ganz einfach. Es wird geschaut, ob das Auto an ist oder nicht. Ist es aus, wird die LED für 150ms angeschaltet, danach wieder aus und der ESP geht für 1,5s in den DeepSleep-Modus um Strom zu sparen.

Ist das Auto an, wird gar nichts gemacht. Der ESP hat ja WLAN und man könnte hier mit einer Hausautomatisierung kommunizieren, um das Ankommen und/oder das Verlassen des Zuhauses als Event zur Verfügung zu haben. Ich habe hier aber erstmal nichts gemacht.

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

## Analyse des Stromverbrauchs

Wie lange kann diese Konstruktion jetzt die Lampe bei abgestelltem Auto blinken lassen?

Gemessen habe ich:

- Wenn der ESP an ist und die LED leuchtet: 90mA
- ESP im DeepSleep: 0,5mA

Timings:

- LED an: 150ms
- DeepSleep: 1500ms

Damit ergibt sich ein mittlerer Stromverbrauch von `Iavg = (90*150+0,5*1500)/(150+1500) = 8,6mA`

Meine verwendete Powerbank hat 20.000mAh und kann damit rechnerisch 96 Tage den Aufbau mit Strom versorgen. Durch einen Langzeitversuch hat sich eine Laufzeit von 25 Tagen ergeben. Das führe ich darauf zurück, dass die Spannungswandlung in der Powerbank auch Strom verbraucht, den ich nicht gemessen und nicht berechnet habe und dass die Nennkapazität möglicherweise nicht vollständig erreicht wird.

Das Ergebnis ist dennoch sehr gut. Man kann also mit dieser Fakealarmanlage das Auto trotzdem für einen dreiwöchigen Urlaub abstellen.

## Was macht diese Powerbank nun so speziell?

Die hohe Kapazität ist natürlich nett für eine lange Laufzeit, tatsächlich ist aber das Feature _Passtrough Charging_ das Entscheidende! Denn beim An- und Abschalten des Autos wird die Powerbank ja entweder geladen oder wieder vom Ladestrom getrennt. Unterstützt eine Powerbank nun kein _Passtrough Charging_ schaltet sie die Versorgungsspannung ab, wenn man die Powerbank selbst vom Ladegerät trennt.

Der ESP ist damit dann stromlos, wenn er eigentlich blinken müsste und er geht auch nicht von selbst wieder an. Bei meinen anderen Powerbanks im Haushalt hilft hier nur "Taste drücken" oder Kabel kurz ausstecken und wieder einstecken. Im Zweifel kann man vorhandene Powerbanks aber schnell testen bevor man eine kauft.

Ich verwende die Powerbank mit dem sperrigen Namen [EasyAcc 20000mAh Externer Akku PowerBank mit 4 USB Ausgängen (4A Eingang 4.8A Smart Ausgang)](http://amzn.to/2u6UHqY) und kann sagen, dass dieses Modell Passthrough Charging unterstützt. Dieses Feature wird leider nicht genannt - weder bei diesem noch bei anderen Modellen.

## Disclaimer

Die Produktlinks hier sind Affiliatelinks. Wenn du darüber bestellst, kostet es dich keinen Cent mehr, du hast also keinen Nachteil, aber du unterstützt damit diesen Blog und den Inhalt hier, was ich cool von dir finde.

Hier nochmal alle Produkte:

- Powerbank: [EasyAcc 20000mAh Externer Akku PowerBank mit 4 USB Ausgängen (4A Eingang 4.8A Smart Ausgang)](http://amzn.to/2u6UHqY)
- Kit mit Steckbrett und LEDs usw.: [Elegoo Electronic Fun Kit Breadboard Kabel Widerstand Kondensator LED Potentiometer für Arduino Learning Kit, UNO, MEGA2560 Arduino Electronic Kit](http://amzn.to/2G6wSnT)
- Auto USB-Ladegerät: [Anker PowerDrive 2 Elite 24W 2 Port Kfz Ladegerät, Auto Ladegerät mit PowerIQ Technologie für iPhone, iPad Air / Mini, Samsung Galaxy / Note, HTC, LG, Huawei, Xiaomi, alle Smartphones, Tablets, Bluetooth Geräten, Powerbank und mehr](http://amzn.to/2IEdT2n)

## Noch Fragen? 🙋

Ist noch was unklar? Dann ab in die Kommentare damit!