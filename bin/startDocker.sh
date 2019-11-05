#!/bin/bash
set -e


# Docker image to use
docker_image=dotfiles

repo_dir=$(pwd)


# Misc. arguments
interactive="-it"
cmd="bash"


# Get user groups
local_group_ids=$(cut -d ' ' -f 2- <<< $(id -G))
local_group_names=$(cut -d ' ' -f 2- <<< $(id -Gn))


run_args="-v ${host_home:-$HOME}/.ssh:/home/user/.ssh \
          -e USER \
          -e local_user_id=$(id -u) \
          -e local_group_id=$(id -g) \
          -e local_group_name=$(id -ng) \
          -e local_group_ids=${local_group_ids// /,} \
          -e local_group_names=${local_group_names// /,} \
          --init"

# Setup Salt volumes
run_args=$run_args" -v /etc/salt:/etc/salt \
                    -v /var/cache/salt:/var/cache/salt \
                    -v /var/run/salt:/var/run/salt"

# Mount current directory
run_args=$run_args" -v $(pwd -P):$repo_dir -w $repo_dir"


docker run $interactive $run_args $docker_image $cmd
