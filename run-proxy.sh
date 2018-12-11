#!/bin/bash

#
# Salt-Proxy Run Script
#

set -e

# Log Level
PROXY_LOG_LEVEL=${PROXY_LOG_LEVEL:-"debug"}

# Run Salt as a Deamon
/usr/bin/salt-proxy --log-level=$PROXY_LOG_LEVEL --proxyid=$PROXYID
