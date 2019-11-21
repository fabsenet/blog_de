---
layout: post
title:  "Zigbee2MQTT ersetzt alle Gateways"
date:   2019-11-20 19:00:00 +0200
categories: Raspberry-PI-DIY
author: Fabian Wetzel
permalink: /:categories/:title/
---

## Ja zu Zigbee, aber Nein zu Bridges!

Zigbee an sich ist ja ein Funkstandard, der sich offensicht zunehmend im Smarthome durchsetzt. Ich selbst besitze bisher *nur* ein [Ikea Floalt](https://www.ikea.com/de/de/p/floalt-led-lichtpaneel-dimmbar-weissspektrum-20436317/), was ich bisher im Standalonebetrieb mit der Fernbedienung genutzt hatte. Zigbee reagiert schnell, geht natürlich durch Wände, scheint aber viel stromsparender als WLAN zu sein. Die Fernbedienung geht schon ziemlich lange mit ihrer ersten Batterie.

## Was bisher geschah...

- Ich habe im [ersten Post/Video]({{ site.baseurl }}{% post_url 2019-10-22-Smarthome-Setup-Node-Red-Mqtt %}) ein Smarthome basierend auf Node-Red und Mosquitto auf einem Raspberry PI eingerichtet.
- Dann hatte ich gezeigt, wie ich damit [meine WLAN-Steckdosen von TP-Link steuere]({{ site.baseurl }}{% post_url 2019-10-30-Kasa-TP-Link-WLAN-Steckdose-in-Node-Red %}).

## [zigbee2mqtt](https://www.zigbee2mqtt.io/) übernimmt die Macht!

Ich habe mir einen kleinen [Funktransmitter⭐](https://amzn.to/35jDQ1O) für zigbee gekauft für meinen Raspberry PI. Der ist in dem Sinne besonders, dass er die nötige Firmwareänderung schon fertig geflasht hatte, man spart sich hier also viel Aufwand.

Man steckt den Stick in den PI, [installiert und konfiguriert zigbee2mqtt](https://www.zigbee2mqtt.io/getting_started/running_zigbee2mqtt.html) auf Basis der Schritt-für-Schritt-Anleitung, [paart die zigbee-Geräte](https://www.zigbee2mqtt.io/getting_started/pairing_devices.html) und dann kann Node-Red direkt [über mqtt mit zigbee Geräten](https://www.zigbee2mqtt.io/information/mqtt_topics_and_message_structure.html) sprechen.

## ...oder du schaust einfach das Video

Diese Lösung ist günstiger und flexibler als gekaufte Bridges und [unterstützt **massig** zigbee-Hardware (aktuell 450 Geräte von 93 Herstellern!!!)](https://www.zigbee2mqtt.io/information/supported_devices.html). Ich schätze mal, es unterstützt jegliches zigbee-Gerät? Das Video soll die Motivation dafür rüberbringen, daher empfehle ich es dir sehr:

{% youtube cxxZcjEVWmI %}

## sonst nix?

Dieser Beitrag endet hier schon. 😶
