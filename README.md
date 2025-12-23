# Ism7MQTT Addon Repository

This Repository contains a Home Assistant Addon to run Ism7MQTT for reading data from Wolf heaters, equipped with an ISM7 Module, directly.

Also supports running multiple instances of ism7mqtt. To do so, configure the first instance normally, then, for each additional ISM7 you have, specify a block like this under "additional ISM7 devices":
```
- device_name: "WolfHeizung2"
  ism7_ip: "192.168.x.y"
  ism7_password: "see sticker on the ISM7"
  interval: 60
```

Note that each ISM7 needs a distinct device name without spaces or special characters.

For more information, or if you encounter any issues, please refer to https://github.com/zivillian/ism7mqtt



# Beginner guide
1. Go to Settings -> Add Ons and install "Mosquitto broker" and Start it
2. Go to Settings -> Integrations and install "MQTT" It will ask you if it should use the local "Mosquitto broker" Add-On - click Yes
3. Go to Settings -> Add Ons "Add On Store" (bottom right) -> Repository (Top Right) -> Add "https://github.com/b3nn0/hassio-addon-ism7mqtt" Repository
4. Add the "Ism7MQTT" Add-On and Configure it for your WOLFLINK (Name, IP, Password (the one on the sticker)) -> Open the Add-On -> TAB "Configure"
5. start the Add-On "Ism7MQTT", it will configure all Entities for your WOLF. If something goes wrong, check the log/protocol tab of the Add-on.


# Important, if some entities are unavailable
The ISM7 Module is easily overwhelmed when monitoring hundreds of parameters. This can result in temporary connection drops, or some parameters being unavailable/not being updated.

Possible solutions have been found:
- Reduce load on the microcontroller by disabling the connection to the Wolf portal
- Connect via ethernet cable instead of Wifi. The Wifi connection is reported to be very unreliable
- Manually disable a bunch of parameters you don't need anyway

To do so, click on parameters you don't need and note their device and parameter ID:
![image](https://github.com/zivillian/ism7mqtt/assets/1858945/c9c685d7-cdcd-40cd-a906-1d7eb61a8a7e)

Then use a text editor addon to modify the "config/ism7-parameters-Wolf.json" (or similar, depending on the device name) and remove either a complete device section, or individual parameters.
These parameters will then not be queried any more, so more important updates work correctly.
The removed parameters will disappear in Home Assistant on next restart.

