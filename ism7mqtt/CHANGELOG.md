## What’s changed

!!! STOP !!!

If you used this add-on before, while it was in beta testing, read below!
This version contains a major rework of the entity IDs provided by this Addon.

To make everything work seemlessly with HA, I recommend you to

1. Stop this Addon
2. Update this Addon, but don't start it yet!
3. Use something like MQTT-Explorer to delete the complete "homeassistant" and "Wolf" topic trees.
If you have other stuff using HA discovery, you might only want to delete topics starting with "Wolf" (or whatever hass-ID you have given in the settings)
4. Restart HA
5. Start this Add-on

As the IDs have changed, you might have to re-add whatever you need to the dashboard(s).


## Real changes

- rework mqtt topic tree and json structure by @zivillian in #32
- add SSL proxy for older modules (with firmware < 200) by @zivillian in #38
- process ServiceReadNumber (support CWL) by @zivillian in #40
- Home Assistant discovery by @b3nn0 in #35

## Breaking Change

There are multiple changes to the MQTT topic structure and json payload. Please check your integrations for changed parameter names.