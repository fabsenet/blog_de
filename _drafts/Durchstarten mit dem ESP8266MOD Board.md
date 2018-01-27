---
layout: post
title:  Durchstarten mit dem ESP8266MOD Board
categories: ESP8266
author: Fabian Wetzel
excerpt: >
   <iframe width="560" height="315" src="data:text/html;charset=utf-8;base64,PGJvZHkgc3R5bGU9ImJhY2tncm91bmQ6cmVkO2ZvbnQ6MTUzcHggY29uc29sYXM7Ij5WSURFTzwvYm9keT4=" frameborder="0" allowfullscreen></iframe>
   <br />todo🦆💥

---
# Warum jetzt auf einmal der ESP8266?

Ich habe dieses Microcontroller einem Freund (basierend auf dessen Wunschliste) geschenkt und dabei habe ich mir einfach auch drei eigene Boards mitbestellt. Naja und will ich herausfinden, wie man mit dem ESP8266 arbeitet und was er so kann. In diesem Beitrag beschreiben ich, was zu tun ist, um das Board soweit zu bringen, dass die on-board LED blinkt. Es geht also vorallem um das richtige Setup.

# Setupschritte

## Windows Treiber für das Board

Auf der Webseite von Wemos gibt es den [Treiber als Download](https://wiki.wemos.cc/products:d1:d1_mini) den man benötigt, damit das Board über USB als solches auch erkannt wird. Man lädt einfach den Treiber als ZIP Paket runter und entpackt es. Es gibt darin nur eine Exe Datei, die man startet und auf Install drückt. Fertig.

## Arduino IDE installieren

Als zweites braucht man dann die Arduino IDE. Die bekommt man als [Download auf der arduino.cc Webseite](https://www.arduino.cc/en/Main/Software). Ich habe die Variante "Windows Installer" gewählt. Nachdem der Download fertig ist, starte ich die exe und drücke solange auf Next bis alles fertig installiert ist.

![Arduino Setup](/assets/2018_mixed/arduino-1.8.5-ide-install.png)

## Den ESP8266 in der Arduino IDE verfügbar machen

Weiter geht es direkt in der Arduino IDE. Von der offiziellen [esp8266 GitHub Seite](https://github.com/esp8266/Arduino) habe ich die Boardmanager URL bezogen. Aktuell ist das:

```text
http://arduino.esp8266.com/stable/package_esp8266com_index.json
```

Unter Datei > Voreinstellungen trägt man diese URL unter "Zusätzliche Boardverwalter URLs" ein.

Jetzt kann man unter Werkzeuge > Board > Boardverwalter nach `esp8266` suchen und dann das erste Suchergebnis auswählen und installieren. Wenn das erledigt ist, wähle ich unter Werkzeuge > Board den `Wemos D1 R2 & mini` aus.

# Testprogramm hochladen

Jetzt sollte alles soweit sein, dass alles läuft. Mittels eines USB-auf-microUSB_Kabel verbinde ich jetzt den Microcontroller mit dem PC. Um den richtigen COM-Port unter Werkzeuge > Port einzustellen habe ich mir gemerkt, welche Ports vor dem Anstecken da waren und welche danach. Bei mir ist COM5 dazu gekommen, deshalb wähle ich den jetzt aus. Man kann sonst aber auch durchprobieren, so viele Ports sollte die Liste ja eigentlich nicht enthalten.

Unter Datei > Beispiele > esp8266 wähle ich jetzt `Blink`. Ein neues Fenster öffnet sich. Ich musste hier erneut COM5 auswählen, das Board stimmt aber.

![Arduino IDE kompiliert Blink Beispiel](/assets/2018_mixed/esp8266_compiling_blink.png)

Nachdem kompilieren hat das Board direkt angefangen das Programm auszuführen und ich sehe die LED jetzt blinken. Damit ist diese Anleitung am Ende angekommen.

Hat bei *dir* alles geklappt? Was willst *du* jetzt damit basteln? Ich freue mich auf deine Antwort in den Kommentaren.