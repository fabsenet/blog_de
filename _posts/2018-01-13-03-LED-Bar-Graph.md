---
layout: post
title:  "Raspberry PI DIY Serie: 03: 10fach LED Bar Graph steuern!"
date:   2018-01-13 16:30:00 +0200
categories: Raspberry-PI-DIY
author: Fabian Wetzel
permalink: /:categories/:title/
excerpt: >
   <iframe width="560" height="315" src="https://www.youtube.com/embed/ufCFPsbHTEg" frameborder="0" allowfullscreen></iframe>
   <br />Im dritten Teil der Tutorialserie geht es um das Ansteuern einer 10 Segment-LED.
   Schau dir das Video an oder
---
# Wer eine LED steuern kann, kann auch 10 steuern?!

<iframe width="560" height="315" src="https://www.youtube.com/embed/ufCFPsbHTEg" frameborder="0" allowfullscreen></iframe>

Das Ziel für diese Episode soll ein LED Bar Graph sein, der vom Raspberry PI komplett gesteuert wird. Auf dem Raspberry PI soll ein Fenster zu sehen sein, wo man mittels der Maus beeinflussen können soll, welche Teile dieser 10fach LED leuchten sollen. Wie schon im letzten Teil der Serie erwähnt, verwende ich auch hier wieder das [Freenove Ultimate Starter Kit for Raspberry Pi](http://amzn.to/2halM2T). Weiterhin benutze ich auch wieder einen [Raspberry Pi 3 Model B](http://amzn.to/2x6jwne), das Netzteil [Anker PowerPort+1 18W USB Ladegerät](http://amzn.to/2w1ACid) mit dem Kabel [Anker Micro USB Kabel](http://amzn.to/2y6RZib) und schließlich der Speicherkarte [SanDisk Ultra 16GB microSDHC](http://amzn.to/2x5IMtR). Wenn du über diese Links bei Amazon einkaufst, unterstützt du diese Serie 🙏! Ich verlinke die Sachen aber auch für dich, dass du weißt, was genau du brauchst und dir sicher sein kannst, dass diese Sachen zusammen funktionieren werden. Ich könnte mir das übrigens auch als Geschenk vorstellen...

# Was ist ein LED Bar Graph?

In  [Teil 2 dieser Serie]({{ site.baseurl }}{% post_url 2017-10-23-02-LED-Blinken-lassen %}) haben wir ja schon die LED kennen gelernt. Ein LED Bar Graph oder 10 Segment-LED ist nun nichts anderes als zehn LEDs, die alle in einem Gehäuse untergebracht sind:

![Detailaufnahme eines LED Bar Graphs](/assets/pi-diy/3/detail_led_bar_graph.jpg)

Das Bauteil ist sehr symmetrisch und unterscheidet sich nur dadurch, dass auf der einen Seite ein Aufdruck `HB10101k` ist, auf der anderen nicht. Eine LED hat aber nun genau eine Richtung, in der der Strom fließt und die LED leuchtet. Ich habe also nun zuerst einen Testaufbau gemacht um herauszufinden, an welche Seite der LED Leiste der Weg zu Plus und an welcher er zu Minus führen muss:

![Testschaltung zum Finden der richtigen Polung](/assets/pi-diy/3/bar_graph_eine_led.jpg)

In dieser Schaltung benutze ich den Raspberry nur als Stromquelle, denn ich nutze nur GND und die 3,3V Leitung. Wichtig ist, dass man auch beim Testen den Vorwiderstand nicht vergisst. Ich hatte hier wieder den gleichen 220 Ohm Widerstand verwendet. Damit ist dann auf jeden Fall klar, dass die Seite, auf der die Schrift gedruckt ist, zu Minus bzw. zu Gnd (Ground) führen muss.

# Schaltung aufbauen

Die komplette Schaltung ist etwas größer als die aus dem zweiten Teil, aber eigentlich nicht komplizierter. Ich verbinde zuerst GND des PIs mit der blauen Schiene des Steckbretts. Von dort mit jeweils einem Vorwiderstand mit einem Pin des LED Bar Graphs. Von der anderen Seite des LED Bar Graphs verbinde ich jeden PIN direkt mit einem GPIO Anschluss des PIs. auf dem Adapter des Steckbretts sind die Pins ja benannt und ich wähle einfach die, wo GPIO drauf steht und dann unter denen einfach diejenigen, die am nahesten dran sind. Die Pinnummern in der richtigen Reihenfolge brauchen wir später beim Programmieren, man kann die also schon mal aufschreiben. Meine komplette Schaltung sieht dann so aus:

![Komplette Schaltung mit dem LED Bar Graph](/assets/pi-diy/3/bar_graph_komplette_schaltung.jpg)

# Programmieren

Das war es schon mit dem Aufbau der Schaltung und ich wende mich nun Processing auf dem Raspberry zu. Hier gibt es jetzt zwei Teilaufgaben. Ich muss zuerst das Fenster zeichnen, dessen Aussehen die Draufsicht des Bar Graphs wiederspiegeln soll und im zweiten Schritt muss dann noch die Ansteuerung der LEDs analog zur Darstellung im Fenster erfolgen.

## Fensterfläche zeichnen

In der `setup()`-Methode setze ich mit `size()` die Fenstergröße so, dass es etwas breiter ist. Außerdem nutze ich `background()` um den Hintergrund des Fensters auf ein mittleres Grau einzustellen. In der `draw()`-Methode habe ich dann eine `for`-Schleife, die 10 Durchläufe macht und ich nutze sie, um 10 Rechtecke zu malen. Der Befehl dafür ist `rect()` und der Erste Parameter der Funktion erwartet den X Wert des Rechtecks. Den mache ich abhängig vom Schleifendurchlauf und damit sind alle 10 Rechtecke dann nebeneinander.

Jetzt kommt die Dynamik ins Spiel, denn mit `mouseX` kann ich die X-Koordinate des Mauscursors abfragen. Ich vergleiche diesen mit der X-Koordinate des aktuell zu zeichnenden Rechtecks und entscheide dann, ob ich es mittels `fill()` entweder rot oder schwarz ausgemalt zeichne. Wenn man alle Zahlenwerte dabei einigermaßen geschickt wählt, sieht es so aus:

![Kurze Aufnahme der animierten Fensterfläche](/assets/pi-diy/3/fensteranimation.gif)

Der Code bis hierhin ist wirklich übersichtlich:

```java
void setup()
{
  size(640, 360);
  background(102);
}

void draw()
{
  for (int i=0; i<10; i++)
  {
    if (mouseX > 25+60*i)
    {
      fill(255, 0, 0);
    } else
    {
      fill(255, 255, 255);
    }
    rect(25+60*i, 90, 50, 180);
  }
}
```

## GPIO ansteuern

Wenn die Interaktion mit der Maus funktioniert und das Fenster die Rechtecke korrekt ausmalt, ist der nächste Schritt, die LEDs anzusteuern. Hier mache ich zunächst einen Array, der alle Pinnummern der verwendeten GPIOs enthält in der Reihenfolge des LED Bar Graphs. Bei mir ist das:

```java
int leds[]={17, 18, 27, 22, 23, 24, 25, 2, 3, 8};
```

Das wird bei dir aber dann vermutlich anders sein. In  `setup()` schreibe ich mir dann nochmal eine for-Schleife und setze alle LEDs mit `GPIO.pinMode(leds[i], GPIO.OUTPUT);` auf Output, denn ich will ja, dass der PI an diesen Pins eine Spannung zur Verfügung stellt. Standardmäßig sind Pins immer auf Input eingestellt, da so weniger kaputt gehen kann. Diese Funktionen muss ich natürlich aus dem Namensraum `processing.io.*` importieren. Als letztes nutze ich genau die Stelle, wo ich über die Füllfarbe des Rechtecks entscheide um dort auch den jeweiligen Pin entweder auf `LOW` oder auf `HIGH` zu schalten. Das war es auch schon um das gesetzte Ziel zu erreichen.

## Das vollständige Programm

```java
import processing.io.*;

int leds[]={17, 18, 27, 22, 23, 24, 25, 2, 3, 8};

void setup()
{
    size(640, 360);
    for (int i=0; i<10; i++)
    {
        GPIO.pinMode(leds[i], GPIO.OUTPUT);
    }

    background(102);
}

void draw()
{
    for (int i=0; i<10; i++)
    {
        if (mouseX > 25+60*i)
        {
            fill(255, 0, 0);
            GPIO.digitalWrite(leds[i], GPIO.LOW);
        }
        else
        {
            fill(255, 255, 255);
            GPIO.digitalWrite(leds[i], GPIO.HIGH);
        }
        rect(25+60*i, 90, 50, 180);
    }
}
```

Falls du ungeklärte Fragen zum Quelltext hast, kannst du in die [Referenz](https://processing.org/reference/) ([GPIO Referenz](https://processing.org/reference/libraries/io/GPIO.html)) von Processing schauen und dich danach in die Kommentare begeben um zu Fragen. Ich helfe dir gerne im Rahmen meiner Möglichkeiten!

# Freuen und tiefer gehende Hausaufgabe

Wenn du es bis hier hin geschafft hast und auch richtig mitgemacht hast, dann spürst du jetzt hoffentlich auch das Gefühl, dass du was Richtiges erschaffen hast! Freue dich darüber!

Du willst mehr? Versuche doch mal, ein automatisches Lauflicht zu schreiben, was immer hin und her geht und welches im Fenster und auf dem LED Bar Graph dargstellt wird:

![Lauflicht](/assets/pi-diy/3/lauflicht.gif)
