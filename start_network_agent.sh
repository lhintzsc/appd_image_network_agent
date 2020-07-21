#!/bin/bash

# function to replace text via environmental variables
replaceText () {
	sed -i -e "s|$2|$3|g" $1
}

# config files
NETWORK_VIZ_CONFIG_LUA="${NETV_AGENT_HOME}/conf/agent_config.lua"

# set config files
replaceText "${NETWORK_VIZ_CONFIG_LUA}" "enable_netlib = 1" "enable_netlib = 0"
replaceText "${NETWORK_VIZ_CONFIG_LUA}" "WEBSERVICE_IP=.*" "WEBSERVICE_IP=\"0.0.0.0\""
replaceText "${NETWORK_VIZ_CONFIG_LUA}" "port = 3892" "port = ${NETV_PORT}"
replaceText "${NETWORK_VIZ_CONFIG_LUA}" "/opt/appdynamics/netviz" "${NETV_AGENT_HOME}"

# start machine agent
${NETV_AGENT_HOME}/bin/appd-netagent -c ./conf -l ./logs -r ./run