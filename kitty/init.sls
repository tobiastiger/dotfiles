kitty:
  pkg.installed

configs:
  file.symlink:
    - name: {{ grains.homedir }}/.config/kitty
    - target: {{ grains.statesdir }}/kitty/kitty
    - makedirs: True
    - user: {{ grains.user }}
    - group: {{ grains.group }}

# restore-kitty-permissions:
#   file.directory:
#     - name: {{ grains.homedir }}/.config
#     - user: {{ grains.user }}
#     - group: {{ grains.group }}
#     - recurse:
#       - user
#       - group
