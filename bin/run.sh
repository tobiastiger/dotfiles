#!/bin/bash

set -eu
set -o pipefail


user=$USER
homedir=$HOME
statesdir=$(pwd)/states


# Set up grains if they don't exist
if [ ! -f grains ]; then
  salt-call --local --config=./ grains.setvals "{ \
    \"user\": \"${user}\", \
    \"homedir\": \"${homedir}\", \
    \"statesdir\": \"${statesdir}\"
  }"
fi


# Apply either high state or a single state based on arguments
if [[ "$#" -eq 1 ]]; then
  echo "Applying $1 state"
  salt-call --local --config=./ --state-output=mixed --retcode-passthrough state.sls $1
else
  echo "Applying high state"
  salt-call --local --config=./ --state-output=mixed --retcode-passthrough state.highstate
fi

