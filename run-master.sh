#!/bin/bash

#
# Salt-Master Run Script
#

set -e

# Log Level
MASTER_LOG_LEVEL=${MASTER_LOG_LEVEL:-"warning"}

# Run Salt Master
/usr/bin/salt-master --log-level=$MASTER_LOG_LEVEL
