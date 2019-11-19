#!/bin/bash

set -eu
set -o pipefail

os=$(uname)

if [ "$os" = "Linux" ]; then
  if [ $(id -u) -ne 0 ]; then
    echo $'Please run as root.\n'
    exit
  else
    user=$SUDO_USER
  fi
elif [ "$os" = "Darwin" ]; then
  user=$USER
fi

group=$(id -gn $user)
homedir=$HOME
statesdir=$(pwd)/states

sudo chown -R $user:$group /etc/salt /var/log/salt /var/cache/salt

# Set up grains if they don't exist
if [ ! -f grains ]; then
  salt-call --config=./ grains.setvals "{ \
    \"user\": \"${user}\", \
    \"group\": \"${group}\", \
    \"homedir\": \"${homedir}\", \
    \"statesdir\": \"${statesdir}\", \
    \"os\": \"${os}\"
  }"
fi

# Apply either high state or a single state based on arguments
if [[ "$#" -eq 1 ]]; then
  echo "Applying $1 state"
  salt-call --config=./ --state-output=mixed --retcode-passthrough state.sls $1
else
  echo "Applying high state"
  salt-call --config=./ --state-output=mixed --retcode-passthrough state.highstate
fi
