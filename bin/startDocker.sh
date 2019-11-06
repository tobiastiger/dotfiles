#!/bin/bash
set -e


# Docker image to use
docker_image=dotfiles

repo_dir=$(pwd)


cmd=""
detached_mode=""
dockerfile=""
dry_run=""
interactive="-i"
sandbox_arg=1
use_tty="-t"
while :; do
  case $1 in
    -c|--command)   cmd=$2; use_tty=""; shift ;;
    -d|--detached)  detached_mode="-d" ;;
    --dry)          dry_run="echo" ;;
    -f|--file)      dockerfile=$2; shift ;;
    -s|--sandbox)   sandbox_arg=0 ;;
    *) break
  esac
  shift
done


# Get user groups
local_group_ids=$(cut -d ' ' -f 2- <<< $(id -G))
local_group_names=$(cut -d ' ' -f 2- <<< $(id -Gn))


run_args="-v ${host_home:-$HOME}/.ssh:/home/user/.ssh \
          -e USER \
          -e HOME \
          -e local_user_id=$(id -u) \
          -e local_group_id=$(id -g) \
          -e local_group_name=$(id -ng) \
          -e local_group_ids=${local_group_ids// /,} \
          -e local_group_names=${local_group_names// /,} \
          --init"


# Mount current directory as r/w or r only
if [[ sandbox_arg -eq 0 ]]; then
  run_args=$run_args" -v $(pwd -P):$repo_dir:ro -w $repo_dir"
elif [[ sandbox_arg -eq 1 ]]; then
  run_args=$run_args" -v $(pwd -P):$repo_dir -w $repo_dir"
fi


# Setup Salt volumes
run_args=$run_args" -v /etc/salt:/etc/salt \
                    -v /var/cache/salt:/var/cache/salt \
                    -v /var/run/salt:/var/run/salt"


$dry_run docker run $interactive $use_tty $detached_mode $run_args $docker_image $cmd
