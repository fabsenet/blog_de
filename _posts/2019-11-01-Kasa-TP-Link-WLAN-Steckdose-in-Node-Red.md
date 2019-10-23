---
layout: post
title:  "Kasa TP-Link WLAN-Steckdose in Node-Red verwenden"
date:   2019-11-01 17:50:00 +0200
categories: Raspberry-PI-DIY
author: Fabian Wetzel
permalink: /:categories/:title/
---

## Endlich die TP-Link WLAN Steckdosen ohne App steuern!

Ich habe ja im [letzten Post](TODO) beschrieben, wie ich auf einem Raspberry PI mein Smarthome mit Node-Red eingerichtet habe. Nun will ich das ja auch nutzen und ich will mit meinen WLAN Steckdosen von TP-Link anfangen. Ich habe von den normalen [Wlan-Steckdosen von TP-Link⭐](https://amzn.to/31tZuOr) glaube ich mittlerweile schon ca. zehn Stück. Ich habe außerdem [eine weitere Steckdose von TP-Link⭐](https://amzn.to/32H70H9), die auch den Stromverbrauch messen kann. Wie man die Steckdosen mit Node-Red verwendet, erfährst du hier in diesem Artikel.

### ...oder du schaust einfach das Video

{ % youtube TODO % }

## Installation des Node-Red Addons

Du startest auf der Weboberfläche deiner Node-Red-Instanz (bei mir ist es z.B. `http://smarthome:1880`) und klickst oben rechts auf das Hamburgermenü und dann auf `Palette verwalten`:

{% include image.html file="/assets/pi-diy/NodeRedPaletteVerwalten.png" description="Node-Red: Palette verwalten" %}

Im sich öffnenden Menü, geht man auf den Reiter `installieren` und benutzt dann die Suche, um das Paket mit dem Namen `node-red-contrib-tplink-iot` zu finden und mit einem weiteren Klick zu installieren. Achtung, bei mir hat das Installieren durchaus ca. 2 Minuten gedauert, ohne dass sich im Benutzerinterface in der Zeit irgendwas großartig getan hat.

{% include image.html file="/assets/pi-diy/node-red-contrib-tplink-iot.png" description="Node-Red: Paket node-red-contrib-tplink-iot installieren" %}

Wenn man die Installation abgeschlossen hat, hat man in der Nodes-Palette zwei neue Nodes:

{% include image.html file="/assets/pi-diy/node-red-contrib-tplink-iot.png" description="Nodes des Addons node-red-contrib-tplink-iot" %}

## Nötige Vorbereitungen

Die WLAN-Steckdosen müssen mittels der normalen KASA App von TP-Link in das eigene WLAN gebracht werden. Falls man das ohne die App hinbekommen kann, lass es mich gerne wissen! Anschließend brauchst du die IP-Adresse, die die Steckdose erhalten hat.

## Die neuen Nodes verwenden

