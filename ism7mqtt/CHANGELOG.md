## What’s changed

!!! STOP !!!

This version contains a major rework of the entity IDs provided by this Addon.

To make everything work seemlessly with HA, I recommend you to

1. Stop this Addon
2. Update this Addon, but don't start it yet!
3. Use something like MQTT-Explorer to delete the complete "homeassistant" and "Wolf" topic trees.
If you have other stuff using HA discovery, you might only want to delete topics starting with "Wolf" (or whatever hass-ID you have given in the settings)
4. Restart HA
5. Start this Add-on

As the IDs have changed, you might have to re-add whatever you need to the dashboard(s).
  
