---
layout: post
title:  "Raspberry PI DIY Serie: 02: LEDs müssen blinken!"
date:   2017-10-20 01:14:39 +0200
categories: Raspberry-PI-DIY
author: Fabian
permalink: /:categories/:title/
excerpt: >
   <iframe width="560" height="315" src="https://www.youtube.com/embed/Eh5dHIY5I4k" frameborder="0" allowfullscreen></iframe>
   <br />Im zweiten Teil der jetzt schon legendären Tutorialserie geht es darum, eine LED blinken zu lassen. Schau dir das Video an oder
---
# Eine LED muss blinken!

Das Ziel für die erste richtige *Bastelarbeit* soll eine LED sein, die mittels des Raspberry PI und einem selbst geschriebenen Programm darauf zum Blinken gebracht wird. Eine blinkende LED als solches ist jetzt noch nicht super überragend, aber es wird viel Wissen benötigt, worauf spätere Lektionen dann aufbauen werden.

Wie schon in der Einleitung erwähnt, habe ich das [Freenove Ultimate Starter Kit for Raspberry Pi](http://amzn.to/2halM2T) ausgesucht, um meine Tutorialserie darauf aufzubauen. Alle verwendeten Bauteile findest du in [Teil 1 dieser Serie]({{ site.baseurl }}{% post_url 2017-10-04-01 Einführung,Installation Raspbian,Installation Processing %}).

# Logische Schaltung

Noch geht es ja vorallem um die Art und Weise, wie die Testschaltung aufgebaut ist, daher ist die eigentliche Schaltung vergleichsweise einfach. Es gibt eine Stromquelle und eine LED. Die Stromquelle ist in dem Fall der GPIO Pin 17 des Raspberrys selbst, da er für eine LED genug Leistung zur Verfügung stellen kann. **Achtung:** Will man andere Verbraucher oder mehrere LEDs betreiben, so geht das nicht mehr direkt über den Raspberry! Jedenfalls muss noch der Strom begrenzt werden, der durch die LED fließt, da eine LED dies nicht von alleine tut. Das Bastelset hat nur 2 verschiedene Widerstandsarten dabei, beide gehen, sofern man aber die LED leuchten sehen will, sollte man die 220 Ω (Ohm) wählen. Man kann den nötigen Widerstand aber auch errechnen.

![Schaltung](/assets/pi-diy/2/pi_diy_02_Blinking_LED.png)

## Optional: Den minimalen Vorwiderstand für maximale Helligkeit ausrechnen

*Springe einfach zur nächsten Überschrift, falls dich die Rechnung gerade nicht interessiert!* Es ist aber auch nicht schwer, den optimalen Widerstand auszurechnen. Hierzu braucht man zuerst einige Fakten, die man den jeweiligen Datenblättern entnehmen kann. Wir wählen eine rote Standard-LED. Mangels konkretem Datenblatt habe ich mich im Internet umgeschaut, typischerweise ist der Spannungsabfall 2V und es wird eine maximale Stromstärke von 20mA angegeben. Die maximale Stromstärke des GPIO Pins hat sogar nur 16mA ([Quelle](https://raspberrypi.stackexchange.com/a/9299)).

Bisher bekannte Fakten:

- Spannung Stromquelle 3,3V
- Spannungsabfall LED 2V
- maximale Stromstärke `I` 16mA

Gesucht: Größe des Vorwiderstands.

Um nun den nötigen Widerstand zu bestimmen, benutzen wir die Standardformel `R=U/I`. Dabei ist `U` die Spannung, die über dem Widerstand abfällt. Die Summe aller Spannungen in einem Stromkreis muss `0` ergeben, daher gibt:

```math
    3,3V = U + 2V
       U = 1,3V
```

jetzt muss man nur noch die Werte einsetzen:

```math
    R = U / I
    R = 1,3V / 0,016A
    R = 81,25 Ω
```

Der minimale Widerstand, um weder den Raspberry PI noch die LED zu überlasten beträgt demnach 81Ω. Wir verwenden ja 220Ω, es besteht also keine Gefahr für unsere Bauteile.

# Schaltung tatsächlich zusammenstecken

*Bevor du anfängst, die Schaltung zu bauen, stelle bitte sicher, dass du den PI vom Strom trennst. Das dient weniger deiner Sicherheit als der Sicherheit des PIs. Die Betriebsspannung von 5V des PIs ist für den Menschen ungefährlich, solltest du beim Bauen aber einen Kurzschluss verursachen, kann dies deinen PI zerstören und das willst du ja sicherlich nicht?*

Im Mittelpunkt der Schaltung steht vor allem das Steckbrett:

![Schaltung auf dem Steckbrett aufgebaut](/assets/pi-diy/2/schaltung02.jpg)

Ein Steckbrett ist super geeignet, da man hiermit Schaltungen sehr schnell zusammenstecken kann. Außerdem muss man nicht Löten. Das spart Zeit und man ist auch flexibler. Auf dem Bild habe ich rote Rechtecke als farbliche Überlagerungen gemalt. Alle Löcher innerhalb eines Rechtecks sind leitend verbunden. Ich denke, das Muster sollte klar sein, auch wenn ich nicht alle Rechtecke gemalt habe.

Das [Freenove Ultimate Starter Kit for Raspberry Pi](http://amzn.to/2halM2T) enthält nun nicht nur das Steckbrett sondern auch einen Aufsatz, der auf einfache Art und Weise ein *Weiterleiten* des GPIO Anschlusses des Raspberrys erlaubt. Den Adapter selbst steckt man einfach auf das Steckbrett. Dann muss man nur noch das Flachbandkabel mit dem Adapter und dem PI verbinden. Der Adapter hat eine Aussparung, so dass man das Kabel hier nicht verdreht aufsetzen kann. Auf der Seite des PIs kann man das Kabel aber tatsächlich falsch aufsetzen. Hier hilft das folgende Foto:

![Raspberry PI3 mit GPIO Flachbandkabel](/assets/pi-diy/2/raspi_gpio_kabel.jpg)

Auf dem Foto ist nochmal extra hervorgehoben, wie das Kabel aufzusetzen ist. Das Kabel hat eine farbige Ader und die muss so angeschlossen sein, dass sie auf der Seite ist, wo der USB-Anschluss des PIs genau **nicht** ist.

Die restliche Schaltung kann man auf Basis des ersten Fotos aufbauen. Wichtig ist dabei noch die LED, denn eine LED funktioniert nur in eine Stromflussrichtung. Wenn man sich eine normale LED ansieht, hat sie unterschiedlich lange Beinchen. Das längere Beinchen muss dabei immer zur Plusseite der Stromquelle zeigen, in diesem Fall ist das der GPIO Pin 17.

# Programmieren

In [Teil 1 dieser Serie]({{ site.baseurl }}{% post_url 2017-10-04-01 Einführung,Installation Raspbian,Installation Processing %}) haben wir ja Processing installiert und unser erstes Testprogramm geschrieben. Jetzt nutzen wir es zum Schalten zeitlich gesteuerten An- und Ausschalten des GPIO Pins 17. Außerdem soll das Fenster gleichzeitig entweder Rot oder Schwarz sein. Dies sollte bei der eventuell nötigen Fehlersuche helfen.

## Die GPIO Funktionen

Die GPIO Funktionen sind alle im Namensraum `processing.io`enthalten, dementsprechend muss man den zuerst mit dem Kommando `import processing.io.*;` importieren, um sie nutzen können. Um flexibel sein zu können beim Ändern der Schaltung, merke ich mir in einer einzigen globalen Variablen, welchen GPIO Pin ich genau verwendet habe. Einmalig muss ich diesen Pin auf `Output` schalten, da dies nicht der Standard ist. Das mache ich mit `GPIO.pinMode(ledPin, GPIO.OUTPUT);`. Will ich nun den Pin eine Spannung ausgeben lassen, verwendet man digitalWrite: `GPIO.digitalWrite(ledPin, GPIO.HIGH);`. Das gleiche Kommando mit `LOW` statt `HIGH` setzt die Ausgabespannung auf 0V.

## Fensterfläche zeichnen

Außerdem soll ja auch das Fenster gezeichnet werden. Die Funktion `background(...)` gewährleistet das. Sie erwartet eine Farbangaben, z.B. in RGB. Um die LED übrigens nicht zu schnell zu schalten, greifen wir hier auf einen Trick zurück. Die Funktion `frameRate()` stellt ein, mit wie vielen Bildern pro Sekunde die Anwendung gezeichnet werden soll. Wir geben hier nur eine `1` an. Das bedeutet, dass unsere Anwendung nur einmal pro Sekunde gezeichnet wird. Der aktuelle Zustand der LED wird als `boolean` gehalten und bei jedem Zechnen geändert. Das führt dann zum Blinken.

## Die speziellen Methoden setup() und draw()

Das Programm verwendet die Funktionen `setup()` und `draw()`. Setup wird beim Start des Programms genau einmal durch Processing selbst aufgerufen und erlaubt es, einmalige Einstellungen vorzunehmen. Ich stelle hier die Framerate und den GPIO Pinmodus ein.

Die Funktion draw wird von Processing jedes Mal aufgerufen, wenn es wieder Zeit ist, dass ein Frame der Anwendung gezeichnet werden muss. Hier schalte ich den Modus der LED um und zeichne entsprechend den Hintergrund.

## Das vollständige Programm

```c#
import processing.io.*;

int ledPin = 17;
boolean isLedOn = false;

void setup() {
  frameRate(1);
  GPIO.pinMode(ledPin, GPIO.OUTPUT);
}

void draw() {
  isLedOn = !isLedOn;
  if(isLedOn) {
    background(255,0,0);
    GPIO.digitalWrite(ledPin, GPIO.HIGH);
  } else {
    background(0,0,0);
    GPIO.digitalWrite(ledPin, GPIO.LOW);
  }
}
```

Falls du ungeklärte Fragen zum Quelltext hast, kannst du in die [Referenz](https://processing.org/reference/) ([GPIO Referenz](https://processing.org/reference/libraries/io/GPIO.html)) von Processing schauen und dich danach in die Kommentare begeben um zu Fragen.

# Freuen und weiterführende Aufgabe

Wenn du es bis hier hin geschafft hast und auch richtig mitgemacht hast, dann spürst du jetzt hoffentlich auch das Gefühl, dass du was richtiges erschaffen hast! Freue dich darüber!

Du willst mehr? Versuche eine zweite LED an einen weiteren GPIO Pin anzuschließen und lasse sie abwechselnd blinken, oder in einer Form von Muster!