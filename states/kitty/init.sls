configs:
  file.symlink:
    - name: {{ grains.homedir }}/.config/kitty
    - target: {{ grains.statesdir }}/kitty/kitty
    - makedirs: True
    - force: True
    - backupname: "kitty-backup"

restore-kitty-permissions:
  file.directory:
    - name: {{ grains.homedir }}/.config
    - user: {{ grains.user }}
    - group: {{ grains.group }}
    - recurse:
      - user
      - group
