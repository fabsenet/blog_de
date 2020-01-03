---
layout: post
title:  "Kaffeemaschine verbessern mit dem 3D Drucker"
date:   2020-01-03 09:00:00 +0200
categories: DIY
author: Fabian Wetzel
permalink: /:categories/:title/
---

## 3D Drucker sinnvoll einsetzen

Ich hab seit kurzen einen 3D Drucker und mir schon länger gesagt, wenn ich mal einen habe, dann modifiziere ich die Kaffeemaschine! Ich habe den [Philips HD8829/01 3000 Serie Kaffeevollautomat⭐](http://amzn.to/2ettRyE). Kurzgesagt ist es einfach so, dass nicht genug Bohnen in Bohnenfach passen und die Maschine auch ständig einige Bohnen verschwendet, wenn sie gerade leer werden. Das hat mich genervt, also habe ich angefangen einen Aufsatz zu designen, wie man das Fach nach oben vergrößern kann.

## die ganze Geschichte gibt es auch im Video

{% youtube loYx0kuW_8Y %}

## Designprozess

Ich habe mit Blender designed, weil ich es auch durch einige 3D Animationen zuletzt sehr gut kennen gelernt habe und ich das Wissen so nochmal anwenden kann. Ich habe mir auch Fusion360 angesehen, Blender war für mich und jetzt gerade aber einfach die bessere Wahl.

Ich habe ein Referenzfoto gemacht mit dem Deckel und einem Lineal, so dass ich dieses Bild in Blender exakt hinskalieren konnte.

{% include image.html file="/assets/2020/3d-druck-kaffee/referenzbild.jpg" description="Referenzfoto" %}

Das habe ich mit einen Curve-Objekt dann in Blender nachgemalt. Einmal die Innenseite und einmal die Außenseite. Das hab ich dann jeweils in ein Mesh gewandelt, in Z-Richtung ein Stück extrudiert und mit dem Solidify-Modifier eine Dicke gegeben. Damit hatte ich dann im Prinzip die Vorlage, wie die Verlängerung unten und oben jeweils aussehen muss.

{% include image.html file="/assets/2020/3d-druck-kaffee/ring.jpg" description="Ein kurzes Verlängerungsstück" %}

Dann habe ich viel zu lange gebraucht, um beide Teile in einer Weise zu verbinden, dass es schön aussieht und auch ohne Supports mit einem 3d Drucker druckbar ist:

{% include image.html file="/assets/2020/3d-druck-kaffee/verbunden.jpg" description="Verbundene Verlängerungsstücke" %}

und vonausgehende von dort musste ich es nur noch nach oben in Z-Richtung an der richtigen Stelle zerren. Im Laufe der Fehldrucke (siehe Video...) ist mir auch aufgefallen, dass ich den Bereich um diese Klappe durch eine Art Schornstein auslassen will. Außerdem wollte ich den vorderen Teil nicht ungenutzt lassen und habe eine "Rutsche" designed, wo die Bohnen runter rutschen können und so auch von dort im Mahlwerk enden. Abschließend sah das dann nach nur gut 15h Designphase etwa so aus: 

{% include image.html file="/assets/2020/3d-druck-kaffee/final-render.jpg" description="Designergebnis #1" %}
{% include image.html file="/assets/2020/3d-druck-kaffee/final-render2.jpg" description="Designergebnis #2" %}

## Fertiges Ergebnis

Das fertige Ergebnis ist (nach einigen Fehlversuchen) recht gut geworden. Ich habe später noch Magneten rein geklebt, dass die schwarzen Klappen nicht zu weit auf stehen und dass die Klappe für den Wassertank auf bleibt, wenn man sie öffnet.

{% include image.html file="/assets/2020/3d-druck-kaffee/final-real.jpg" description="Realer Aufsatz auf der Kaffeemaschine" %}
{% include image.html file="/assets/2020/3d-druck-kaffee/final-real2.jpg" description="Aufsatz gefüllt mit Bohnen" %}
{% include image.html file="/assets/2020/3d-druck-kaffee/final-real3.jpg" description="Frische Klappe auf dem Aufsatz" %}

## Download

Ich habe ein Github Repository erstellt, was die STL-Dateien und die ursprüngliche Blenderdatei enthält. Bei den STLs ist die erste das eigentliche Objekt und das zweite ist ein Supportblocker. Der Mittelteil muss bis zu den ersten paar mm mit Supports gedruckt werden, aber weiter oben geht alles ohne Supports. Die Dateien findest du im [Github Repository "fabsenet/3d-kaffee-extension"](https://github.com/fabsenet/3d-kaffee-extension) oder bei [Thingiverse](https://www.thingiverse.com/thing:4081676).