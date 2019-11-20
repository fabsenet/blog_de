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

## zigbee2mqtt übernimmt die Macht!

Ich habe mir einen kleinen [Funktransmitter⭐](https://amzn.to/35jDQ1O) für zigbee gekauft für meinen Raspberry PI. Der ist in dem Sinne besonders, dass er die nötige Firmwareänderung schon fertig geflasht hatte, man spart sich hier also viel Aufwand.

Man steckt den Stick in den PI, installiert und konfiguriert zigbee2mqtt auf Basis der Schritt-für-Schritt-Anleitung, paar die zigbee-Geräte und dann kann Node-Red direkt über mqtt mit zigbee Geräten sprechen.

## ...oder du schaust einfach das Video

Diese Lösung ist günstiger und flexibler als gekaufte Bridges und unterstütz massig zigbee-Hardware. Ich schätze mal, es unterstützt jegliches zigbee-Gerät? Das Video soll die Motivation dafür rüberbringen, daher empfehle ich es dir sehr:

{% youtube cxxZcjEVWmI %}

## sonst nix

Dieser Beitrag endet hier schon. 😶
