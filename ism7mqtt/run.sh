#!/usr/bin/with-contenv bashio

export CONFIG_PATH=/data/options.json

export ISM7_MQTTHOST=$(bashio::services mqtt "host")
export ISM7_MQTTUSERNAME=$(bashio::services mqtt "username")
export ISM7_MQTTPASSWORD=$(bashio::services mqtt "password")
export DEBUG_LOGGING=$(bashio::config 'debug_logging')


function start_ism7mqtt() {
    export ISM7_HOMEASSISTANT_ID=$1
    export ISM7_IP=$2
    export ISM7_PASSWORD=$3
    export ISM7_INTERVAL=$4
    
    if [ $ISM7_INTERVAL = "" ]; then
        export ISM7_INTERVAL=60
    fi

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

    # Not really needed, most of it could also be read from env, but helps identifying which process is which
    ISM_ARGS="--hass-id=$ISM7_HOMEASSISTANT_ID --interval=$ISM7_INTERVAL --ipAddress=$ISM7_IP -t $parameters"
    if [[ "$DEBUG_LOGGING" == "true" ]]; then
        ISM_ARGS+=" -d"
    fi

    while [ true ]; do
        echo "Starting ism7mqtt $ISM_ARGS"
        /app/ism7mqtt $ISM_ARGS || echo "ism7mqtt unexpectedly quit with return code $?"
        sleep 10
    done

}

HA_DISCOVERY_ID=$(bashio::config 'device_name')
ISM7_IP=$(bashio::config 'ism7_ip')
ISM7_PASSWORD=$(bashio::config 'ism7_password')
INTERVAL=$(bashio::config 'interval')

echo "Setting up ism7mqtt $HA_DISCOVERY_ID $ISM7_IP"
start_ism7mqtt $HA_DISCOVERY_ID $ISM7_IP $ISM7_PASSWORD $INTERVAL &


# Set username and password for the broker
for device in $(bashio::config 'additional_devices|keys'); do
  devname=$(bashio::config "additional_devices[${device}].device_name")
  ip=$(bashio::config "additional_devices[${device}].ism7_ip")
  password=$(bashio::config "additional_devices[${device}].ism7_password")
  interval=$(bashio::config "additional_devices[${device}].interval")

  echo "Setting up ism7mqtt $devname $ip"
  start_ism7mqtt $devname $ip $password $interval &
done


wait