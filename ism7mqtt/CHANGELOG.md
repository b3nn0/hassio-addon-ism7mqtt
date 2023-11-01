## What's Changed
- Allow configuration of an external MQTT broker
- Allow multiple instances of ism7mqtt to run.
Exmaple config for additional devices:
```
- device_name: "WolfHeizung2"
  ism7_ip: 192.168.x.x
  ism7_password: xxxx
  interval: 60
```
