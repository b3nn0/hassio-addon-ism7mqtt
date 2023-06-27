
# STOP! BREAKING CHANGES! READ CAREFULLY!

## What's Changed
- Bump ism7mqtt to v0.0.13
- added German translation for add-on configuration
- fix output of BinaryReadOnlyConverterTemplate, MicerStateConverterTemplate and corresponding ha discovery topics by @zivillian in #60
- Ism7MQTT now auto-generates parameters.json and stores it in your /config directory

## Breaking Changes

- Parameters.json file format has changed and will now be generated automatically on first startup:
  If you have removed certain parameters from your json file, you will have to redo this. After first start of the new version, you will find the file "ism7-parameters-<device name>.json" in your /config directory.
  Re-apply your changes there, then restart the add-on
- Entity IDs have changed. If you only start the new version, all your entities will be duplicated (old/new ID).
  Follow these steps to properly update:
  - Stop the old version of the Add-on
  - Download the program MQTTExplorer, start it, and connect to your MQTT broker
  - Search for your device name with an underscore, usually "Wolf_"
  - Delete all the topics homeassistant/...Wolf_
  - Now update and start the new version
  - Adjust your dashboards and automations to use the new instead of the old entity ID. In most cases, it's easiest to edit in "yaml" mode, and insert a 0 in the middle of all the parameter IDs
  
