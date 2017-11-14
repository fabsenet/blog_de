---
layout: post
title:  "Raspberry PI DIY Serie: 01: Einführung, Installation Raspbian und Installation Processing!"
date:   2017-10-04 21:14:39 +0200
categories: Raspberry-PI-DIY
author: Fabian Wetzel
permalink: /:categories/:title/
excerpt: >
   <iframe width="560" height="315" src="https://www.youtube.com/embed/Eh5dHIY5I4k" frameborder="0" allowfullscreen></iframe>
   <br />Das ist der Auftakt einer Serie von Beiträgen, die sich um das Basteln mit dem Raspberry PI dreht. Es geht mir um eine Kombination aus einfachen Schaltungen in Hardware, die mit den GPIO Pins des PIs angesteuert werden. Ich freue mich über jeden, der nicht nur mitliest bzw. mitschaut, sondern der auch wirklich sich hinsetzt und aktiv mitmacht! Die Belohnung dabei ist, dass jeder für sich etwas lernt und ein Gefühl des Erfolgs erhält, dass man etwas geschafft hat. Ich werde dabei...
---
# Worum geht es?

Das ist der Auftakt einer Serie von Beiträgen, die sich um das Basteln mit dem Raspberry PI dreht. Es geht mir um eine Kombination aus einfachen Schaltungen in Hardware, die mit den GPIO Pins des PIs angesteuert werden. Auf dem PI läuft dann ein Programm, welches über die GPIO Pins entsprechend reagiert.

Ich freue mich über jeden, der nicht nur mitliest bzw. mitschaut, sondern der auch wirklich aktiv mitmacht! Die Belohnung dabei ist, dass jeder für sich etwas lernt und ein Gefühl des Erfolgs erhält, dass man etwas geschafft hat. Ich werde dabei jeden Abschnitt auch als Video veröffentlichen, so dass du die freie Wahl hast, entweder das Video zu schauen oder dein Beitrag zu lesen.

<iframe width="560" height="315" src="https://www.youtube.com/embed/Eh5dHIY5I4k" frameborder="0" allowfullscreen></iframe>

# Benötigte Hardware um mitzumachen (kann man auch verschenken!)

![Raspberry PI](/assets/pi-diy/RPi_Logo.png)

Du brauchst den Raspberry PI mit Speicherkarte und Stromversorgung. Ich hoffe du hast einen PC mit Speicherkartenlesegerät, ansonsten solltest du dir das auch kaufen. Die Einzelteile zusammen könnten auch ein Geschenk sein?!

Was du brauchst um mitzumachen:

- [Freenove Ultimate Starter Kit for Raspberry Pi](http://amzn.to/2halM2T): Es handelt sich hier um eine Kiste mit vielen vielen elektronische Bauteilen sowie einem Steckbrett, mit dem man alles ohne nerviges Löten zusammen bauen kann und ausprobieren kann. Es ist auch eine praktische Verbindung zu den GPIO Ports des PIs dabei. Das Kit kommt mit einer umfangreichen Anleitung, so dass man darüber von Lektion zu Lektion das Programmieren und Basteln vertiefen kann. *Ich will mit dieser Serie dieser Anleitung grob folgen.*
- [Raspberry Pi 3 Model B](http://amzn.to/2x6jwne): Das Herzstück, worum sich diese Serie dreht brauchst du natürlich auch. Der PI ist ein kleiner Computer, aber das ist jetzt nicht neu für dich, oder?
- [Anker PowerPort+1 18W USB Ladegerät](http://amzn.to/2w1ACid): Ein erstklassiges Handyladegerät, was extrem viel Strom bietet und alle verbreiteten Schnellladetechniken der verschiedenen Hersteller unterstützt. Es liefert auch für den PI genug Strom. Du kannst auch ein Micro-USB Netzteil verwenden, das du schon hast. Falls der PI dir im laufenden Betrieb ein buntes Symbol oben rechts einblendet, liefert es nicht genug Strom!
- [Anker Micro USB Kabel](http://amzn.to/2y6RZib): Das von mir vorgeschlagene Ladegerät kommt ohne Kabel daher, das hier ist super, wir haben jetzt schon 4 davon zuhause.
- [SanDisk Ultra 16GB microSDHC](http://amzn.to/2x5IMtR): Du brauchst eine Speicherkarte, wo das Betriebssystem für den PI drauf kommt. Sie muss mindestens 8GB groß sein. Je schneller sie ist, desto besser. Ich habe dir eine gute verlinkt. Dein PC benötigt ein Kartenlesegerät für das Erstinstallation!
- USB-Tastatur und -Maus: Du brauchst Maus und Tastatur am PI um ihn zu benutzen! Es sollte eigentlich fast alles funktionieren, was USB hat.
- Bildschirm mit HDMI Eingang: Der PI hat einen HDMI Ausgang. Den kannst du an einen Fernseher oder PC-Monitor anschließen.

# Installation Raspbian

![Raspbian Logo](/assets/pi-diy/raspbian_logo.png)

Raspbian ist ein Betriebssystem für den Raspberry PI. Die Installation ist eigentlich ganz einfach. Du lädst dir die [aktuellste Version von der Raspberry PI Webseite](https://www.raspberrypi.org/downloads/raspbian/) als ZIP Datei herunter. Dann lädst du dir die Software [etcher](https://etcher.io/) herunter. Etcher installierst du dann ganz normal. Etcher hat eine simple Oberfläche, der man einfach nur Folgen muss:

1. zuerst wählst du das ZIP Archiv aus, welches du herunter geladen hast.
1. Du steckst die micro SD Karte in deinen Kartenleser, etcher erkennt dies automatisch und wählt diese SD Karte aus. Alternativ wählst du sie selbst aus.
1. Du klickst auf _Flash!_ und nach wenigsten Minuten ist die micro SD Karte fertig.

Das war schon der schwerste Teil. Die SD Karte steckst du jetzt in den Raspberry PI. Dann kannst du noch Maus und Tastatur anschließen sowie deinen Monitor. Falls du Netzwerk über Kabel zuhause betreibst, musst du das auch anschließen. **Zuletzt** schließt du das Netzteil an, denn dann beginnt der PI sofort mit dem Starten. Wenn alles geklappt hat, bootet der PI in den Desktop und ist einsatzbereit. Falls du dich mit dem WLAN verbinden willst, kannst du oben rechts auf das WLAN-Icon klicken und dein Netzwerk auswählen, schlüssel eintippen und fertig.

Die Raspbian Installation ist wirklich über die Jahre sehr einfach geworden. Solltest du dennoch Probleme haben, die du einfach nicht gelöst bekommst, kannst du dich gerne über die Kommentare melden.

# Installation Processing

![Processing Logo](/assets/pi-diy/processing_logo.png)

[Processing](https://processing.org/) ist die Programmierumgebung, die ich für diese Serie verwenden will. Sie funktioniert mit dem PI, sowie unter Windows und Linux ... anscheinend überall. [Die Installation auf dem PI](https://github.com/processing/processing/wiki/Raspberry-Pi) ist dabei super einfach. Du öffnest eine Kommandozeile auf dem PI und gibst dort folgendes Kommando ein:

```bash
curl https://processing.org/download/install-arm.sh | sudo sh
```

Dann wartest du einfach bis es fertig ist und das war es schon. Über das Menü kannst du jetzt Processing auswählen und starten.

![Processing im Menü des PIs](/assets/pi-diy/1/processing_pi_menu.png)

# Erstes kleines Programm

Um einen ersten kleinen Erfolg feiern zu können, schreibe ich jetzt nur ein kleines Programm, was nichts anderes tut, als dass ein Kreis gezeichnet wird:

```js
ellipse(50, 50, 80, 80);
```

Diese eine Zeile genügt schon! Die [Dokumentation für `ellipse()`](https://processing.org/reference/ellipse_.html) ist ausreichend. Die ersten beiden Werte bestimmen den Mittelpunkt der Ellipse und die zweiten beiden Werte die jeweiligen Radien. Wenn beide gleich sind, ist die Ellipse ein Kreis.

Dein Processing-Fenster sollte jetzt in etwa so aussehen:

![Processing Window mit dem ellipse() Kommando](/assets/pi-diy/1/processing_ellipse.png)

und wenn du dein erstes eigenes Programm mit STRG+R oder einem Klick auf den Play-Button startest, sollte es so aussehen:

![Erstes eigenes Programm mit dem ellipse() Kommando](/assets/pi-diy/1/ellipse_window.png)

Offenbar hat Processing hier viele Annahmen und Voreinstellungen getroffen, so dass mit dieser einen Zeile allein ein Fenster aufgeht, auf dem ein Kreis zu sehen ist.

Du hast jetzt dein erstes eigenes Programm fertig gestellt! **Wow!**

# Bonusaufgabe

Während du auf die nächste Folge dieser Serie wartest, versuche doch mal ein Programm zu schreiben, was das folgende Fenster als Ausgabe erzeugt. (Du musst hierfür eventuell auf die [Processing Reference](https://processing.org/reference/) zurückgreifen.)

![Processing Bonus Aufgabe](/assets/pi-diy/1/processing_bonus_aufgabe.png)
