#!/bin/bash

set -eu
set -o pipefail

if [ $(id -u) -ne 0 ]; then
  echo $'Please run as root. Exiting.\n'
  exit
fi

user=$SUDO_USER
group=$(id -gn $user)
homedir=$HOME
statesdir=$(pwd)/states
os=$(uname)

chown -R $user:$group /var/log/salt /var/cache/salt /var/run/salt /etc/salt

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

