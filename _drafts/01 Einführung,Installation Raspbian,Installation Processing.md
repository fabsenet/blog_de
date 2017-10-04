---
layout: post
title:  "Raspberry PI DIY Serie: 01: Einführung, Installation Raspbian und Installation Processing!"
date:   2017-09-24 16:14:39 +0200
categories: Raspberry-PI-DIY
author: Fabian
permalink: /:categories/:title/
excerpt: >
   Ich will eine Serie von Beiträgen machen, die sich um das Basteln mit dem Raspberry PI dreht. Es geht mir um eine Kombination aus einfachen Schaltungen in Hardware, die mit den GPIO Pins des PIs angesteuert werden. Ich freue mich über jeden, der nicht nur mitliest bzw. mitschaut, sondern der auch wirklich sich hinsetzt und aktiv mitmacht! Die Belohnung dabei ist, dass jeder für sich etwas lernt und ein Gefühl des Erfolgs erhält, dass man etwas geschafft hat. Ich werde dabei...
---

# Worum geht es?

Ich will eine Serie von Beiträgen machen, die sich um das Basteln mit dem Raspberry PI dreht. Es geht mir um eine Kombination aus einfachen Schaltungen in Hardware, die mit den GPIO Pins des PIs angesteuert werden. Auf dem PI läuft dann ein Programm, welches über die GPIO Pins entsprechend reagiert.

Ich freue mich über jeden, der nicht nur mitliest bzw. mitschaut, sondern der auch wirklich sich hinsetzt und aktiv mitmacht! Die Belohnung dabei ist, dass jeder für sich etwas lernt und ein Gefühl des Erfolgs erhält, dass man etwas geschafft hat. Ich werde dabei jeden Abschnitt auch als Video veröffentlichen, so dass man nicht immer lesen muss, sondern sich auch anschauen kann, wie es funktioniert. 

# Benötigte Hardware um mitzumachen (kann man auch verschenken!)

Du brauchst den Raspberry PI mit Speicherkarte und Stromversorgung. Ich hoffe du hast einen PC mit Speicherkartenlesegerät, ansonsten solltest du dir das auch kaufen. Die Einzelteile zusammen könnten auch ein Geschenk sein?!

Was du brauchst um mitzumachen:
 - [Freenove Ultimate Starter Kit for Raspberry Pi9](http://amzn.to/2halM2T)
 - [Raspberry Pi 3 Model B](http://amzn.to/2x6jwne)
 - [Anker PowerPort+1 18W USB Ladegerät](http://amzn.to/2w1ACid)
 - [Anker Micro USB Kabel](http://amzn.to/2y6RZib)
 - [SanDisk Ultra 16GB microSDHC](http://amzn.to/2x5IMtR)
 - USB Tastatur 
 - USB Maus 
 - Bildschirm mit HDMI Eingang

# Installation Raspbian

Raspbian ist ein Betriebssystem für den Raspberry PI. Die Installation ist eigentlich ganz einfach. Du lädst dir die [aktuellste Version von der Raspberry PI Webseite](https://www.raspberrypi.org/downloads/raspbian/) als ZIP Datei herunter. Dann lädst du dir die Software [etcher](https://etcher.io/) herunter. Etcher installierst du dann ganz normal. Etcher hat eine simple Oberfläche, der man einfach nur Folgen muss:
 1. zuerst wählst du das ZIP Archiv aus, welches du herunter geladen hast.
 2. Du steckst die micro SD Karte in deinen Kartenleser, etcher erkennt dies automatisch und wählt diese SD Karte aus. Alternativ wählst du sie selbst aus.
 3. Du klickst auf _Flash!_ und nach wenigsten Minuten ist die micro SD Karte fertig.

Das war schon der schwerste Teil. Die SD Karte steckst du jetzt in den Raspberry PI. Dann kannst du noch Maus und Tastatur anschließen sowie deinen Monitor. Falls du Netzwerk über Kabel zuhause betreibst, musst du das auch anschließen. **Zuletzt** schließt du das Netzteil an, denn dann beginnt der PI sofort mit dem Starten. Wenn alles geklappt hat, bootet der PI in den Desktop und ist einsatzbereit. Falls du dich mit dem WLAN verbinden willst, kannst du oben rechts auf das WLAN-Icon klicken und dein Netzwerk auswählen, schlüssel eintippen und fertig.

Die Raspbian Installation ist wirklich über die Jahre sehr einfach geworden. Solltest du dennoch Probleme haben, die du einfach nicht gelöst bekommst, kannst du dich gerne über die Kommentare melden.


# Installation Processing

Processing ist die Programmierumgebung, die ich für diese Serie verwenden will. Sie funktioniert mit dem PI zusammen sowie unter Windows und Linux und anscheinend überall.

# Erstes kleines Programm

Um einen ersten kleinen Erfolg feiern zu können, schreibe ich jetzt nur ein kleines Programm, was nichts anderes tut, als dass ein Kreis gezeichnet wird:

```js
ellipse(50, 50, 80, 80);
```

Diese eine Zeile genügt! Die [Dokumentation für `ellipse()`](https://processing.org/reference/ellipse_.html) ist ausreichend. Die ersten beiden Werte bestimmen den Mittelpunkt der Ellipse und die zweiten beiden Werte die jeweiligen Radien. Wenn beide gleich sind, ist die Ellipse ein Kreis. 

![Processing Window mit dem ellipse() Kommando]({{ site.url }}/assets/pi-diy/ellipse_window.png)

Offenbar hat Processing viele Annahmen und Voreinstellungen getroffen, so dass mit dieser einen Zeile allein ein Fenster aufgeht, auf dem ein Kreis zu sehen ist.


In dieser Videoserie...

