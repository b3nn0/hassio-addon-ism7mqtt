#!/usr/bin/with-contenv bashio

export CONFIG_PATH=/data/options.json

export ISM7_MQTTHOST=$(bashio::services mqtt "host")
export ISM7_MQTTUSERNAME=$(bashio::services mqtt "username")
export ISM7_MQTTPASSWORD=$(bashio::services mqtt "password")

export ISM7_IP=$(bashio::config 'ism7_ip')
export ISM7_PASSWORD=$(bashio::config 'ism7_password')
export HA_DISCOVERY_ID=$(bashio::config 'device_name')
export INTERVAL=$(bashio::config 'interval')
export DEBUG_LOGGING=$(bashio::config 'debug_logging')

set -x

cd /app

parameters="/config/ism7-parameters-$HA_DISCOVERY_ID.json"

if ! [ -f $parameters ]; then
    echo "Creating initial configuration $parameters"
    /app/ism7config -t $parameters
    if ! [ -f $parameters ]; then
        echo "Parameter file creation seems to have failed. Please report to the ism7mqtt project: https://github.com/zivillian/ism7mqtt/issues/new"
        exit -1
    fi
fi




ISM_ARGS="--hass-id=$HA_DISCOVERY_ID --interval=$INTERVAL -t $parameters"
if [[ "$DEBUG_LOGGING" == "true" ]]; then
    ISM_ARGS+=" -d"
fi

while [ true ]; do
    echo "Starting ism7mqtt $ISM_ARGS"
    /app/ism7mqtt $ISM_ARGS || echo "ism7mqtt unexpectedly quit with return code $?"
    sleep 10
done

