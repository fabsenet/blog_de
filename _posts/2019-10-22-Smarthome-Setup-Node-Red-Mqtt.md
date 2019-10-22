---
layout: post
title:  "Smarthome PI Installation mit Raspbian, Node-Red und Mosquitto"
date:   2019-10-22 17:50:00 +0200
categories: Raspberry-PI-DIY
author: Fabian Wetzel
permalink: /:categories/:title/
---

## Warum das Ganze? (Und was überhaupt?)

Ich habe bereits einige Geräte angesammelt, die man in einem Smarthome auch steuern könnte. Dazu gehören die [Wlan-Steckdosen von TP-Link⭐](https://amzn.to/31tZuOr), einen [ESP8266⭐](https://amzn.to/2BsPZok) mit [Tasmota-Firmware](https://github.com/arendst/Sonoff-Tasmota/), ein [IKEA Floalt LED-Panel](https://www.ikea.com/de/de/p/floalt-led-lichtpaneel-dimmbar-weissspektrum-10302969/) und auch meinen Desktop-PC. Die generelle Erweiterbarkeit (m)eines Smarthomes kann ich mir dabei auch leicht vorstellen. (=Ich werde weitere Geräte und Einsatzwecke finden, die ich steuern möchte.)

Ich habe einige andere Smarthome-Hubs angesehen und mich für Node-Red + MQTT (Mosquitto) entschieden. Mir war wichtig, dass möglichst viel des Smarthomes lokal ohne Clouddienste läuft. Das schließt Lösungen mit Alexa und Google Home direkt weitestgehend aus. Ich will, dass auch bei einem Ausfall des Dienstleisters oder des Internets so viel des Smarthomes noch funktioniert, wie nur möglich. Was kann ein Amazon Echo noch ohne Internetzugang?

Weiterhin bastel ich gerne, so dass eine Lösung, die mehr Richtung DIY und Basteln/Programmieren geht, gut zu mir passt.

## Video zum Blogeintrag

Schau dir gerne das Video an!

{% youtube KMgIa0l_ukQ %}

## Und was nun genau?

Ich möchte Node-Red und einen MQTT-Broker auf einem Raspberry-PI betreiben. Dafür verwende ich folgende Hardware:

- [Raspberry Pi 3 Model B⭐](http://amzn.to/2x6jwne): Der PI verbraucht viel weniger Strom als ein normaler Computer und damit kann man ihn ohne schlechtes Gewissen 24/7 betreiben, was ja für ein Smarthome-Hub erforderlich ist. Falls du noch gar keinen Raspberry PI hast, empfehle ich dir den aktuelleren [PI 4⭐](https://amzn.to/2VTz4EM).
- [Anker PowerPort+1 18W USB Ladegerät⭐](http://amzn.to/2w1ACid): Ein erstklassiges Handyladegerät, was extrem viel Strom bietet und alle verbreiteten Schnellladetechniken der verschiedenen Hersteller unterstützt. Es liefert auch für den PI genug Strom. Du kannst auch ein Micro-USB Netzteil verwenden, das du schon hast.
- [Anker Micro USB Kabel⭐](http://amzn.to/2y6RZib): Das von mir vorgeschlagene Ladegerät kommt ohne Kabel daher, das hier ist super, wir haben jetzt schon einige davon zuhause.
- MicroSD Speicherkarte: Du brauchst eine Speicherkarte, wo das Betriebssystem für den PI drauf kommt. Sie muss mindestens 8GB groß sein. Je schneller sie ist, desto besser. Eine schnelle und gute ist z.B. [SanDisk Ultra 16GB microSDHC⭐](http://amzn.to/2x5IMtR). Ich habe eine 128GB Karte verwendet, die ich noch da hatte.
- Dein PC benötigt ein Kartenlesegerät für microSD für die initiale Erstinstallation, [hier ist ein super schnelles von Kingston⭐](https://amzn.to/2pDV3TS)!

## Installation

### Raspbian auf microSD Karte kopieren

{% include image.html file="/assets/pi-diy/raspbian_logo.png" description="Raspbian Logo" %}

Auf der Homepage vom [RaspberryPI](https://www.raspberrypi.org/downloads/raspbian/) habe ich Raspbian heruntergeladen. Es gibt da aktuell mehrere Versionen, ich habe `Raspbian Buster with desktop` gewählt, später aber festgestellt, dass ich den Desktop niemals brauche, es sollte also auch problemlos mit `Raspbian Buster Lite` funktionieren.

Um das jetzt auf die microSD Karte drauf zu bekommen, benutze ich [Etcher](https://github.com/balena-io/etcher/releases/latest). Ich habe `balenaEtcher-Setup-1.5.60.exe` gewählt, aber der Link zeigt immer zur neuesten Version. Es gibt auch Varianten für Mac.

Nach der Installation startet man Etcher und wird mit dem sehr übersichtlichen UI begrüßt:

{% include image.html file="/assets/Smarthome/Etcher.png" description="Etcher UI" %}

Hier muss man entsprechend des UIs 3 Schritte durchführen:

1. Man wählt das Raspbian Image aus, was man gerade runter geladen hat. Wenn es nochmal gezippt ist, kann das so bleiben, denn Etcher versteht zip Dateien!
1. Wenn die microSD Karte eingesteckt ist, muss man diese dann bei `Select target` auswählen. Bitte wähle hier nicht deine Festplatte aus. Etcher hilft hier aber auch etwas.
1. Jetzt musst du nur noch auf Flash klicken und ein paar Minuten warten und deine microSD Karte hat Raspbian drauf.

Etcher wirft die microSD Karte aus, wenn es fertig ist, eigentlich will ich aber noch mehr machen. Daher muss man jetzt die Karte einmal aus dem Leser ziehen und wieder rein stecken. Jetzt sollte im Arbeitsplatz ein Laufwerk auftauchen, was `boot` heißt. Dort geht man rein und legt eine ganz leere Datei mit dem Namen `SSH` (alles groß!) an. Das geht z.B. in dem man eine neue txt-Datei anlegt und die Dateiendung entfernt. Das signalisiert Raspbian, dass der remote SSH Zugang von Anfang an aktiviert werden soll. Das ist mir wichtig, denn ich will weder später noch zur Ersteinrichtung Monitor und Maus und Keyboard usw. anschließen müssen.

Wenn man den PI über ein Netzwerkkabel betreiben will (oder muss), ist man jetzt fertig. Ich will ihn über WLAN nutzen, daher muss man auf der microSD Karte auch noch die eigenen WLAN Anmeldedaten hinterlegen. Dazu macht man eine neue Datei mit dem Namen `wpa_supplicant.conf`. Diese öffnet man dann mit einem Texteditor - ich verwende Visual Studio Code - und fügt folgenden Text ein:

```conf
country=US # Your 2-digit country code
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
network={
    ssid="Hier muss der Name deines WLANs rein"
    psk="und hier das Passwort"
    key_mgmt=WPA-PSK
}
```

...dass du an den richtigen Stellen deine Datein eintragen musst, hast du dir bestimmt gedacht?

Jetzt ist die microSD Karte fertig und kann in den PI gesteckt werden. Dann kann der PI an den Strom angeschlossen werden.

### Über SSH mit dem PI verbinden

Wenn der PI hochgefahren ist und alles geklappt hat, sollte er im WLAN erreichbar sein. Du benötigst nun seine IP-Adresse. Du solltest dich auf deinem Router (z.B. Fritzbox) einloggen können und dort die IP des Gerätes bekommen. Falls du dort einstellen kannst, dass dieses Gerät immer die gleiche IP bekommen soll, empfehle ich dir auch diese Einstellung. Falls du die IP nicht raus bekommst, kannst du es stattdessen auch mit dem Gerätenamen `raspberrypi` statt einer IP versuchen.

{% include image.html file="/assets/Smarthome/Putty.png" description="Putty UI" %}

Zum Verbinden über SSH verwende ich [Putty](https://www.putty.org/). Nach dem Download musst du es nur starten und IP/Namen des PIs angeben und auf `Open` klicken. Beim ersten Mal muss man eine Sicherheitsfrage bestätigen, dann kommt der Login des PI.

```conf
Benutzername = pi
Standardpassword = raspberry
```

Mit dem Standardlogin kann man sich dann einloggen.

### Raspbian einrichten

Ist man eingeloggt auf dem PI, macht man immer erst mal ein generelles Update des Systems mit den folgenden zwei Befehlen:

```bash
sudo apt-get update
sudo apt-get upgrade -y
```

Danach macht man `sudo raspi-config` und kann erstmal grundlegende Einstellungen für den PI vornehmen. Wenn man will, kann man hier VNC aktivieren, um sich auch remote mit einer grafischen Oberfläche verbinden zu können. Ich hab das nicht getan.

Dann habe ich eingestellt, dass bei Bootvorgang nur ins Terminal bzw. in die Konsole gebootet werden soll. Warum soll der PI die graphische Oberfläche laden, wenn die doch nie jemand sehen wird? Falls du das machst und sie dann doch mal brauchst, tippe einfach `startx` auf der Konsole.

Als Locale habe ich dann noch `de_DE.UTF8` ausgewählt, das sorgt dafür, dass einige Texte und Fehlermeldungen auf Deutsch sind.

Außerdem kann man hier auch den Hostname des PIs ändern. Ich habe ihn auf `smarthome` gesetzt, so dass ich den anstatt der IP-Adresse ab sofort verwenden kann.

Das wars mit raspi-config und wenn man es verlässt, fragt er, ob man neustarten möchte, das habe ich getan.

### Node-Red und Mosquitto installieren

Ich bleibe noch einen Moment in Putty. Auf der [Homepage von Node-Red](https://nodered.org/docs/getting-started/raspberrypi) gibt es ein handliches Kommando, was man nur in die Kommandozeile kopieren muss und das Skript sorgt dann dafür, dass alles richtig für Node-Red eingerichtet wird.

Hier ist eine Kopie der Zeile:

```bash
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
```

Wenn Node-Red installiert ist, will ich noch, dass es mit dem System zusammen automatisch startet, dafür füre ich folgende Zeilen aus. Die erste aktiviert den Start bei Systemstart, die zweite startet Node-Red jetzt sofort.

```bash
sudo systemctl enable nodered.service
sudo systemctl start nodered.service
```

Jetzt brauchen wir nur noch Mosquitto, das wird mit folgendem Kommando installiert:

```bash
sudo apt-get install mosquitto mosquitto-clients -y
```

Mosquitto startet ohne weitere Eingriffe mit dem System und auch sofort. Das Setup ist damit fertig, jetzt kann man Testen!

## Test

### Mosquitto testen

Dieser Unterpunkt ist kein Lerntutorial für Mosquitto. Auf der Kommandozeile kann man ein Topic abonnieren mit

```bash
mosquitto_sub -d -t /home/data
```

Wenn man das gemacht hat, bleibt das Programm an, bis man es mit STRG+c unterbricht. Es wird jede Nachricht des Topics (hier `/home/data`) ausgeben. Man kann sich übrigens auch auf alle Topics abonnieren, in dem man `mosquitto_sub -d -t "#"` macht.

Jetzt öffne ich eine zweite Putty-Instanz, verbinde mich wieder mit dem PI und mache dann das folgende Kommando, um auf das gleiche Topic eine Nachricht zu senden mit dem Inhalt `Hello World`:

```bash
mosquitto_pub -d -t /home/data -m "Hello World"
```

Man kann auch noch eine Session öffnen und ein weiteres `mosquitto_sub` ausführen. Dann wird deutlich, dass Mosquitto Nachrichten auch vervielfachen kann.

### Node-Red testen

Das Hauptinterface von Node-Red läuft im Browser, dementsprechend kannst du an deinem PC oder Mac jetzt den Browser nehmen und die URL `http://smarthome:1880` öffnen. Falls du einen anderen Hostnamen vergeben hast, musst du den natürlich ersetzen. Der Standardport von Node-Red ist jedenfalls 1880.

Zum ersten Testen habe ich hier eine Inject-Node in den Flow gezogen mit Drag'n'Drop und eine Debug-Node. Wenn man jetzt eine Linie zwischen dein beiden zieht, kann man Deploy (oben rechts) klicken. Dann kann man auf das kleine Viereck bei der Timestamp-Node klicken und sieht auf der rechten Debugausgabe dann einen neuen Eintrag. Das sieht insgesamt ungefähr so aus:

{% include image.html file="/assets/Smarthome/NodeRedSample.png" description="Node-Red Beispielflow" %}

Im Video zeige ich auch noch, wie man mit Node-Red MQTT-Nachrichten senden und empfangen kann und so schließt sich dann der Kreis mit Mosquitto.
