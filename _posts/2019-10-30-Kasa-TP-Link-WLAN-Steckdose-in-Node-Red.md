---
layout: post
title:  "Kasa TP-Link WLAN-Steckdose in Node-Red verwenden"
date:   2019-10-30 19:00:00 +0200
categories: Raspberry-PI-DIY
author: Fabian Wetzel
permalink: /:categories/:title/
---

## Endlich die TP-Link WLAN Steckdosen ohne App steuern!

Ich habe ja im [Letzten Post]({{ site.baseurl }}{% post_url 2019-10-22-Smarthome-Setup-Node-Red-Mqtt %}) beschrieben, wie ich auf einem Raspberry PI mein Smarthome mit Node-Red eingerichtet habe. Nun will ich das ja auch nutzen und ich will mit meinen WLAN Steckdosen von TP-Link anfangen. Ich habe von den normalen [Wlan-Steckdosen von TP-Link⭐](https://amzn.to/31tZuOr) glaube ich mittlerweile schon ca. zehn Stück. Ich habe außerdem [eine weitere Steckdose von TP-Link⭐](https://amzn.to/32H70H9), die auch den Stromverbrauch messen kann. Wie man die Steckdosen mit Node-Red verwendet, erfährst du hier in diesem Artikel.

### ...oder du schaust einfach das Video

{% youtube VAjPetvCM8g %}

## Installation des Node-Red Addons

Du startest auf der Weboberfläche deiner Node-Red-Instanz (bei mir ist es z.B. `http://smarthome:1880`) und klickst oben rechts auf das Hamburgermenü und dann auf `Palette verwalten`:

{% include image.html file="/assets/Smarthome/NodeRedPaletteVerwalten.png" description="Node-Red: Palette verwalten" %}

Im sich öffnenden Menü, geht man auf den Reiter `installieren` und benutzt dann die Suche, um das Paket mit dem Namen [`node-red-contrib-tplink-iot`](https://github.com/adreno369/node-red-contrib-tplink-iot/) zu finden und mit einem weiteren Klick zu installieren. Achtung, bei mir hat das Installieren durchaus ca. 2 Minuten gedauert, ohne dass sich im Benutzerinterface in der Zeit irgendwas großartig getan hat.

{% include image.html file="/assets/Smarthome/node-red-contrib-tplink-iot.png" description="Node-Red: Paket node-red-contrib-tplink-iot installieren" %}

Wenn man die Installation abgeschlossen hat, hat man in der Nodes-Palette zwei neue Nodes:

{% include image.html file="/assets/Smarthome/node-red-contrib-tplink-iot-nodes.png" description="Nodes des Addons node-red-contrib-tplink-iot" %}

## Nötige Vorbereitungen

Die WLAN-Steckdosen müssen mittels der normalen KASA App ([Google Play Store](https://play.google.com/store/apps/details?id=com.tplink.kasa_android&hl=de); gibt bestimmt auch was für Apple) von TP-Link in das eigene WLAN gebracht werden. Falls man das ohne die App hinbekommen kann, lass es mich gerne wissen! Anschließend brauchst du die IP-Adresse, die die Steckdose erhalten hat.

## Die neuen Nodes verwenden

Um auszuprobieren, was die neue `Smart plug` Node so kann, habe ich einen *eigentlich* ganz einfachen Flow gemacht. Es gibt viele verschiedene Inject Nodes, die alle in die `Smart Plug` Node laufen und die dann einfach mit einer `Debug`-Node die Ausgaben in der Debugausgabe ausgibt, so dass man die sich ansehen kann:

{% include image.html file="/assets/Smarthome/node-red-contrib-tplink-iot-sample.png" description="Smart Plug Node ausprobiert." %}

Das Schalten der Steckdose ist das Einfachste, man benötigt lediglich eine Nachricht mit dem Payload `true` oder `false` (`boolean`!).

Alle anderen Kommandos sind vom Typ `string` und geben ein Wort an, was man machen möchte. Sinnvoll ist hier `getInfo`. Man bekommt eine Antwort, die den aktuellen Zustand der Steckdose umfasst:

```javascript
{
    "sw_ver": "1.5.4 Build 180815 Rel.121440",
    "hw_ver": "2.0",
    "type": "IOT.SMARTPLUGSWITCH",
    "model": "HS110(EU)",
    "mac": "98:DA:...",
    "dev_name": "Smart Wi-Fi Plug With Energy Monitoring",
    "alias": "messdose",
    "relay_state": 1, //Schaltzustand (1 ist an)
    "on_time": 3, // wie lange es an ist in Sekunden
    "active_mode": "none",
    "feature": "TIM:ENE",
    "updating": 0,
    "icon_hash": "",
    "rssi": -63,
    "led_off": 0,
    "longitude_i": 99123, //irgendwoher hat er meine Koordinaten?
    "latitude_i": 5312345, //???
    "timestamp": "2019-10-25T16:10:47+01:00"
}
```

Diese Antwort bekommt man nur einmalig, wenn man sozusagen danach fragt. Möchte man sie regelmäßig bekommen, muss man sich dafür abonnieren. Das macht man mit `getInfoEvents`. Deabonnieren geht mit `clearEvents`. Jetzt bekommt man regelmäßig die Infonachrichten aus der Node. Dieses Abonnement ist anscheinend nur in der Node gespeichert, welche regelmäßig die Steckdose befragt, denn deployed man den Flow neu, muss man ein neues Abonnement machen.

Wer die Variante mit der Strommessfunktion hat, kann mit `getMeterInfo` einmalig oder mit `getMeterEvents` regelmäßig Infos über den Stromverbrauch bekommen.

```js
{
    "voltage_mv": 229429,
    "current_ma": 148,
    "power_mw": 33960,
    "total_wh": 26,
    "err_code": 0,
    "timestamp": "2019-10-25T16:17:18+01:00"
}
```

Wie man sieht, hat mein Strom hier gerade eine Spannung von 229V, es fließen 148mA und das macht 33,9W. Das klingt stimmig, denn es ist eine 35W Halogenlampe.

Denkbar ist hier eine Automatisierung, die z.B. auf Basis des Stromverbrauchs ermittelt, ob das Gerät dahinter an ist oder nur im Standby.

Ich habe aus Spaß auf die Messdose eine normale WLAN-Steckdose gesteckt und deren eigenen Strombedarf zu ermitteln:

```javascript
{
    "voltage_mv": 229438,
    "current_ma": 16,
    "power_mw": 446,
    "total_wh": 27,
    "err_code": 0,
    "timestamp": "2019-10-25T16:24:05+01:00"
}
```

Wenn die Steckdose ausgeschaltet it, verbraucht sie ca. 0,45W, wenn sie angeschaltet ist, nimmt sie 1,1W.

Den Quellcode des Addons findest du auf [Github](https://github.com/adreno369/node-red-contrib-tplink-iot), dort kann man auch alle Events nachlesen, denn es gibt noch einige mehr.
