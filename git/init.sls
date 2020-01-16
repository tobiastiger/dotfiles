gitconfig:
  file.symlink:
    - name: {{ grains.homedir }}/.gitconfig
    - target: {{ grains.statesdir }}/git/gitconfig
    - user: {{ grains.user }}
    - group: {{ grains.group }}
