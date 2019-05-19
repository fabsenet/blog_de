---
layout: post
title:  "Raspberry PI DIY Serie: 04: RGB LED🚦 mit dem Raspberry PI steuern"
date:   2018-10-05 21:30:00 +0200
categories: Raspberry-PI-DIY
author: Fabian Wetzel
permalink: /:categories/:title/
---
## Wir brauchen alle Farben in einer LED, wie geht das?

Das Ziel für diese Episode soll sein, dass du verstehst, was Pulsweitenmodulation ist, wie man es machen kann, warum der Raspberry PI nur bedingt dafür geeignet ist und wie man das Wissen nutzt, um eine RGB Led anzusteuern.

<!-- more -->

Auch diese Episode gibt es natürlich wieder als Video:

{% youtube DYe_8qmTk4k %}

Wie schon in den letzten Teilen der Serie erwähnt, verwende ich hier

- das [Freenove Ultimate Starter Kit for Raspberry Pi](http://amzn.to/2halM2T)
- einen [Raspberry Pi 3 Model B](http://amzn.to/2x6jwne)
- Netzteil [Anker PowerPort+1 18W USB Ladegerät](http://amzn.to/2w1ACid)
- mit passendem Kabel [Anker Micro USB Kabel](http://amzn.to/2y6RZib) 
- und schließlich der Speicherkarte [SanDisk Ultra 16GB microSDHC](http://amzn.to/2x5IMtR)

*Wenn du über diese Links bei Amazon einkaufst, unterstützt du diese Serie!* Ich verlinke die Sachen aber auch für dich, dass du einfach weißt, was genau du brauchst und dir sicher sein kannst, dass diese Sachen zusammen funktionieren werden.

## Was ist eine RGB LED?

{% include image.html file="/assets/pi-diy/4/RGB_LED_Bauteil.png" description="RGB LED" %}

In [Teil 2 dieser Serie]({{ site.baseurl }}{% post_url 2017-10-23-02-LED-Blinken-lassen %}) haben wir ja schon die LED kennen gelernt. Eine RGB Led ist nun eine LED, die eigentlich gleich 3 LEDs in einem fast genauso aussehenden Gehäuse vereint. Diese Kombi-LED hat dabei nur 4 statt der zuerst logisch erscheinenden 6 Beinchen. Das liegt daran, dass man je nach Bauweise alle inneren LEDs entweder sich die gleiche Anode oder Katode teilen.

{% include image.html file="/assets/pi-diy/4/RGB_LED.png" description="RGB LED 'von innen'" %}

Ich konnte mir selbst auch noch nie merken, was jetzt was ist, aber es gibt eine einfache Faustregel:

> Bei dem längeren Beinchen könnte man ein Stück abschneiden, um die Beinchen gleich lang zu machen. Dieses Stückchen könnte man bei dem Beinchen so hinlegen, dass sich ein Plus bildet.

Das lange Beinchen muss daher mit Plus verbunden werden.

## Was ist nun Pulsweitenmodulation?

{% include image.html file="/assets/pi-diy/4/pwm.png" description="RGB LED" %}

Bei der Pulsweitenmodulation (kurz PWM) erzeugt man ein periodisches digitales Signal. Auf diese Art und Weise kann man eine LED ansteuern. Ist die Periode kurz genug, also die Frequenz hoch genug, wirkt es für das menschliche Auge, als würde die LED mit verringerter Helligkeit leuchten.

Im Schaubild ist `T` die Periodenlänge. Die Frequenz ist üblicherweise im kHz Bereich, dementsprechend ist `T = 1ms` oder kürzer.

`t` ist dann weiterhin die Zeit innerhalb einer Periode, wo das Signal auf high ist. Im Schaubild ist das beispielsweise 25%. Da unsere Beispiel-LED ja mit dem anderen Beinchen an Plus hängt, leuchtet sie, wenn der GPIO Port auf LOW geht, dementsprechend würde man etwa 75% Helligkeit wahrnehmen, wenn eine LED mit dem Beispielsignal geschaltet wird.

Ich empfehle dir auch, dich zu [PWM bei Wikipedia](https://de.wikipedia.org/wiki/Pulsweitenmodulation) tiefer einzulesen. (Dort ist auch das Bild her.)

## Schaltung aufbauen

{% include image.html file="/assets/pi-diy/4/schaltung_pi_leds.png" description="Komplette Schaltung mit RGB LED" %}

Die komplette Schaltung ist etwas größer als die aus dem zweiten Teil, aber eigentlich nicht komplizierter. Alle 3 Teil-LEDs werden am gemeinsamen Ende mit der 3,3V Spannung verbunden und am anderen Ende über einen 220 Ohm Widerstand an einen freien GPIO Port gebunden. Da es kein einzelnes Schaubild für eine RGB LED gibt, kann man auf dem Schaltplan nichtmal richtig erkennen, ob es sich um 3 einzelne LEDs oder eine RGB LED handelt.

## Programmieren

Für dieses Beispiel verweise ich dich direkt auf den Beispielcode von Freenove. Er umfasst viel graphische Elemente, deren Programmierung langwierig ist, dich in diesem Moment aber mit der PWM Steuerung nicht weiterbringt. [Der komplette Sketch](https://github.com/fabsenet/Freenove_Ultimate_Starter_Kit_for_Raspberry_Pi/tree/master/Processing/Sketchs/Sketch_04_1_1_ColorfulLED) besteht aus 3 Dateien, die du in Processing öffnest, in der `Sketch_04_1_1_ColorfulLED.pde` trägst du ganz oben ein, welche GPIO Ports du verwendet hast und du kannst auch schon die Anwendung starten.

{% include image.html file="/assets/pi-diy/4/RGB_LED_GUI_sidebyside.jpg" description="RGB LED GUI mit echter Schaltung" %}

Das PWM Signal wird dabei in der [`SOFTPWM.pde`](https://github.com/fabsenet/Freenove_Ultimate_Starter_Kit_for_Raspberry_Pi/blob/master/Processing/Sketchs/Sketch_04_1_1_ColorfulLED/SOFTPWM.pde) Datei erzeugt. Hier finden sich wie erwartet die Funktionsaufrufe zum Steuern eines GPIO Pins. Es werden auch die entsprechenden Wartezeiten berechnet, die für das PWM Signal benötigt werden. Die Erzeugung des Signals ist dann eine Endlosschleife:

```c++
while (true)
{
    space = range - marks;
    if (marks!=0)
    {
        GPIO.digitalWrite(pin, GPIO.HIGH);
        delayMicroSeconds(marks);
    }
    if (space!=0)
    {
        GPIO.digitalWrite(pin, GPIO.LOW);
        delayMicroSeconds(space);
    }
}
```

Das ist genau das, was man erwarten würde, aber dennoch ist es schlecht! Wenn man eine LED ansieht, die auf diese Art und Weise gedimmt wird, sieht man sie gelegentlich Flackern.

## Warum flackert das?!?

Gute Frage! Es liegt tatsächlich vergraben in der Art und Weise, wie das "Abwarten" realisiert wird. `delayMicroSeconds(...)` ruft intern die Betriebssystemfunktion `Thread.sleep(...)` auf. Das Programm fordert das Betriebssystem an dieser Stelle auf, nach einer gewissen Zeit wieder aktiviert zu werden. Das Problem ist, dass diese Zeit in dem Fall wenige µs beträgt. So wie das Betriebssystem von dieser Zeitspanne abweicht, leuchtet die LED sofort zu viel oder zu wenig. Das passiert bei Raspbian, oder jedem normalen Linux und Windows aber, denn es handelt sich nicht um Echtzeitbetriebssysteme. Das System gibt nicht die Garantie ab, dass es im µs sich vorhersehbar verhält. Diese Art der Signalerzeugung wird auch **Software**-PWM genannt, denn es wird permanent durch Software erzeugt. Es ist daher sehr abhängig vom Betriebssystem und allem, was noch auf dem System läuft. Das sporadische Flimmern ist derart schlimm, dass ich mir keine LED ins Wohnzimmer stellen möchte, die auf diesem Wege ihre Farben mischt.

Es gibt auch **Hardware**-PWM. Hier gibt es spezielle Abschnitte auf dem (Mikro-)Prozessor, die man nur einmalig konfigurieren muss und die dann das PWM Signal ohne weiteres Zutun erzeugen. Hier ist die Signalqualität deutlich besser. Der Raspberry PI hat angeblich zwei Hardware-PWM-Kanäle, diese lassen sich aber in praktisch keiner Programmierumgebung nutzen.

Mit den GPIO Pins des PIs lassen sich viele schöne Projekte umsetzen aber PWM-Erzeugung gehört meiner Meinung nach nicht dazu.