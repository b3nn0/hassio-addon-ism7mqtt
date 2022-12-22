#!/usr/bin/with-contenv bashio

export CONFIG_PATH=/data/options.json

export ISM7_MQTTHOST=$(bashio::services mqtt "host")
export ISM7_MQTTUSERNAME=$(bashio::services mqtt "username")
export ISM7_MQTTPASSWORD=$(bashio::services mqtt "password")

export ISM7_IP=$(bashio::config 'ism7_ip')
export ISM7_PASSWORD=$(bashio::config 'ism7_password')
export HA_DISCOVERY_ID=$(bashio::config 'device_name')
export PARAMETER_JSON=$(bashio::config 'parameter_json')
export DEBUG_LOGGING=$(bashio::config 'debug_logging')


set -x

ISM_ARGS="--hass-id=$HA_DISCOVERY_ID"
if [[ "$DEBUG_LOGGING" == "true" ]]; then
    ISM_ARGS+=" -d "
fi

echo $PARAMETER_JSON > /parameter.json
ISM_ARGS+=" -t /parameter.json "

echo "Starting ism7mqtt $ISM_ARGS"

/app/ism7mqtt $ISM_ARGS

