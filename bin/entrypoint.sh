#!/bin/bash


if [ $(id -u) -ne 0 ]; then
  # If we don't start as root, we continue
  exec "$@"
else

  # Set up local user and start as that user
  user_id=${local_user_id:-9001}
  group_id=${local_group_id:-9001}
  user_name=${USER:-user}
  group_name=${local_group_name:-user}

  
  groupadd -f -g $group_id $group_name
  

  # Create all groups the user belongs to
  group_names=(${local_group_names//,/ })
  index=0
  for group_id in ${local_group_ids//,/ }
  do
    groupadd -f -g $group_id ${group_names[ $index ]}
    (( index++ ))
  done
  

  # Create and add any extra groups
  if [ ! -z "$local_group_names" ]; then
    useradd -M --no-user-group --home-dir /home/$user_name --shell /bin/bash -u $user_id -g $group_id -G $local_group_names -c "" $user_name
  else
    useradd -M --no-user-group --home-dir /home/$user_name --shell /bin/bash -u $user_id -g $group_id -c "" $user_name
  fi


  echo "$user_name ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$user_name
  chmod 0440 /etc/sudoers.d/$user_name
  chown $user_name $HOME

  if [ -e /tmp/$user_name ]; then
    chown -R $user_name /tmp/$user_name
  fi


  # Create a file in /tmp to use for synchronization check
  touch /tmp/initializationDone

  if [[ "$@" != "" ]]; then
    exec sudo -H -E -u $user_name "$@"
  else
    exec sudo -H -E -u "$user_name" bash
  fi

fi

