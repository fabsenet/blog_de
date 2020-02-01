---
layout: post
title:  "Meine 3 sinnvollsten Mods für meinen 3D Drucker Prusa MK3s"
date:   2020-01-03 09:00:00 +0200
categories: DIY
author: Fabian Wetzel
permalink: /:title/
---
# Was habe ich mit meinem 3D Drucker gemacht, um ihn noch sinnvoller zu machen?

In diesem Beitrag sage ich dir, was ich an meinem 3D Drucker (Prusa MK3s) gemoddet habe und wie sinnvoll es wirklich ist. Dabei haben sich 3 Dinge als besonders sinnvoll heraus kristallisiert:

1. Octoprint
1. Webcam
1. Druckbett manuell ausgleichen

Also immer schön der Reihe nach oder einfach hier erstmal als Video:

{% youtube todo %} fM1535x1hQc

## Mod 1: Octopi / Octoprint

Wer hantiert schon gerne mit SD-Speicherkarten rum, wenn man auch über ein Webinterface alles steuern kann? Es ist also, denke ich, fast schon Pflicht, einen Raspberry PI an den Drucker anzuschließen. Ich habe einen PI3 verwendet und habe darauf Octoprint installiert. Octoprint ist dabei die Software, die alles steuert. Das fertige Image für die SD Karte, was man einfach runterladen kann, heißt dann Octopi.

Octoprint => PI => PI Gehäuse => Spannungsregler

### Was ist OctoPrint?

Octoprint erlaubt es einem über ein Webinterface den Drucker zu steuern. Natürlich kann man erstmal eine GCODE-Datei dort hochladen und den Druck starten sowie den Druckfortschritt beobachten. Man kann darüber hinaus auch viele weitere Dinge tun. Man kann eine Webcam anbringen und so den Druck aus der Ferne überwachen, dazu später mehr. Man kann alle Achsen bewegen und auch das Heizen von Bett und Druckkopf starten. Das erlaubt einem ein einfaches Reinigen usw. Es gibt eine eingebaute GCODE-Analyse um sehen zu können, wie die Layer gedruckt aussehen sollen, so konnte ich vor kurzem z.B. auf diese Weise feststellen, dass was für mich erst wie ein Fehler beim Drucken aussah tatsächlich schon ein Fehler im Modell war, der bis zum Druck unbemerkt blieb.

### Unordnung mit vielen fliegenden Kabeln

Wenn man das jetzt gemacht hat, hat man ein Stromkabel am Drucker, ein Stromkabel zum PI, ein USB-Kabel zwischen PI und Drucker und ggf. ein USB Kabel für die Webcam. Das sieht dann durchaus schnell richtig unordentlich aus und ich musste mich dem annehmen. Denn der Drucker soll ja nicht für immer *provisorisch* aufgestellt wirken. Mir ist es lieber, wenn es nach *einer Einheit* aussieht.

### PI Gehäuse am Drucker!

Naja und wie wird es eine Einheit? in dem der PI am Drucker direkt untergebracht wird! Ich habe ein gutes Gehäuse gefunden für den (PI3)[https://www.thingiverse.com/thing:3759782] (oder (PI4)[https://www.thingiverse.com/thing:3811421]) welches direkt am Drucker angebracht wird. Ich hatte einige Probleme damit, dass eine Seite sich beim Drucken ständig verformt hat, so hatte ich das Gehäuse mehrfach gedruckt. Im Video siehst du, wie ich zwischendurch auch einige Löcher im Gehäuse in Blender schließe, da ich sie nicht brauche.

### Gehäusebestückung, Lüfter, Spannungsversorgung

Das Gehäuse ist so gemacht, dass ein 40mm Lüfter angebracht werden kann. Ich benutze hier einen Noctua-Lüfter für 5V, den kann man direkt an den GPIO Pins des PIs anschließen und der hält den PI dann schön kühl. Gerade wenn man einen PI4 verwendet ist das wichtig. Leistungsmäßig ist der PI3 aber vollkommen ausreichen für Octoprint. Ich hatte einen PI4 probiert, hab dann aber wieder nur einen PI3 in Verwendung, es reicht einfach aus.

Um dann noch die seperate Stromversorgung los zu werden, habe ich in dem Gehäuse auch noch einen Step-Down Spannungsregler untergebracht. Den Strom hole ich mir vom Drucker direkt und schleife ein Kabel durch das Druckermainboard durch. Es ist ziemlich fummelig, muss man halt entscheiden, ob man das machen will. Den Spannungsregler habe ich dann so eingestellt, dass er aus den 24V verlässlich 5V macht und habe dann den Ausgang ebenfalls mit den richtigen GPIOs des PIs verbunden. Es gibt verschiedene Diskussionen darüber, ob es gut und richtig ist, den PI durch den GPIO mit Strom zu versorgen. Ich kann dazu nur sagen, ich hab es gemacht und seit dem auch schon 20 oder 30 Stunden Dinge gedruckt und es läuft stabil bisher.

Dann habe ich noch ein super kurzes USB-Kabel für die Verbindung von Drucker und PI gekauft und jetzt sieht es echt richtig aufgeräumt auf.

## Mod 2: Webcam für den Drucker

Also muss ich viel schreiben, warum eine Webcam sinnvoll ist? Selbst wenn man zu Hause ist, während der Drucker druckt, sitzt man ja nicht die ganze Zeit daneben. Ich kann jetzt immer einfach das Handy zücken und man kurz nachsehen, ob noch alles gut aussieht. Octoprint unterstützt super viele Webcams, besonders beliebt scheinen aber die Logitech C270, die Logitech C920 und die originale PI Cam zu sein. Ich habe eine Logitech C920 gekauft und dafür hat jemand einen (Arm)[https://www.thingiverse.com/thing:3111450] designed, welcher direkt mit der X-Achse des Druckers hoch und runter fährt. So hat man gerade den Druckkopf immer im Blick, egal wie hoch der Druck ist.

### Befestigung direkt an der X-Achse

Nachdem man diesem Arm gedruckt hat, wird er mit einer Schraube aus den Spare-Parts des MK3s direkt an dem einen Steppermotor befestigt. Der Arm hat sogar Vorbereitungen für Kabelbinder zum befestigen des Kabels der Webcam.

### C920 zerlegen und anbauen

Einzig die Webcam muss man etwas zerlegen. Hier braucht man einen sehr kleinen Schraubenzieher und etwas Geduld, dann kann man aber den zusätzlichen Standfuß der Webcam abschrauben und das Ergebnis ist super slim.

## Mod 3: Manueller Bettausgleich

Der Prusa MK3s hat eigentlich einen Sensor mit dem er den Abstand zwischen Druckkopf und Druckbett misst und Unebenheiten in der Software ausgleicht. In der Theorie klingt das nett, aber ich habe beim Drucken durchaus massive Unterschiede bemerkt zwischen der linken und der rechten Hälfte des Druckbetts.
Bed Visualizer => Bed Umbau
### Problem?

Octoprint hat hier ein Plugin, welches die Messwerte des Druckers visualisieren kann und da kann man dann feststellen, dass der Abstand bei mir zwischen dem tiefsten und dem höchsten Punkt 0,5mm ist. Das klingt im normalen Leben nach nichts, wenn aber eine Druckebene nur 0,15mm hat, ist das ein Unterschied von 3 bis 4 Druckebenen! Das Problem ist nun, dass der Prusa MK3s keine manuellen Einstellmöglichkeinten vorsieht.

### Lösung mit 8 Schrauben und Guide

Aber natürlich hat das schon jemand im Internet gelöst und einen richtig guten Guide geschrieben. Man benötigt 8 Sicherungsmuttern, die man unter das Heizbett schraubt und ersetzt damit die original Abstandshalterhülsen. Nun ist man in der Lage durch drehen der Schrauben die Höhe des Betts sehr genau einzustellen. Es gibt hier wieder ein Octoprintplugin, welches einem sogar anzeigen kann, wie weit man jede einzelne Schraube genau drehen muss. So war es mir möglich, das Bett viel viel flacher zu bekommen und das habe ich gleich beim nächsten Druck sofort gemerkt. Jetzt ist das ganze Druckbett super und nicht nur ein Teil! Der Mod hat vielleicht eine halbe Stunde gekostet und war die Zeit definitiv wert.
