# Ism7MQTT Addon Repository

This Repository contains a Home Assistant Addon to run Ism7MQTT for reading data from Wolf heaters, equipped with an ISM7 Module, directly.

Also supports running multiple instances of ism7mqtt. To do so, configure the first instance normally, then, for each additional ISM7 you have, specify a block like this under "additional ISM7 devices":
```
- device_name: "WolfHeizung2"
  ism7_ip: "192.168.x.y"
  ism7_password: "something"
  interval: 60
```

Note that each ISM7 needs a distinct device name without spaces or special characters.

For more information, or if you encounter any issues, please refer to https://github.com/zivillian/ism7mqtt


# Beginner guide
1. Go to Settings -> Add Ons and install "Mosquitto broker" and Start it
2. Go to Settings -> Integrations and install "MQTT" It will ask you if it should use the local "Mosquitto broker" Add-On - click Yes
3. Go to Settings -> Add Ons "Add On Store" (bottom right) -> Repository (Top Right) -> Add "https://github.com/b3nn0/hassio-addon-ism7mqtt" Repository
4. Add the "Ism7MQTT" Add-On and Configure it for your WOLFLINK (Name, IP, Password) -> Open the Add-On -> TAB "Configure"
5. start the Add-On "Ism7MQTT", it will configure all Entities for your WOLF. If something goes wrong, check the log/protocol tab of the Add-on.
