# Ism7MQTT Addon Repository

This Repository contains a Home Assistant Addon to run Ism7MQTT for reading data from Wolf heaters, equipped with an ISM7 Module, directly.

Also supports running multiple instances of ism7mqtt. To do so, configure the first instance normally, then, for each additional ISM7 you have, specify a block like this under "additional ISM7 devices":
```
- device_name: "WolfHeizung2
  ism7_ip: "192.168.x.y"
  ism7_password: "something"
  interval: 60
```

Note that each ISM7 needs a distinct device name without spaces or special characters.

For more information, or if you encounter any issues, please refer to https://github.com/zivillian/ism7mqtt
