configs:
  file.symlink:
    - name: {{ grains.homedir }}/.config/kitty
    - target: {{ grains.statesdir }}/kitty/kitty
    - makedirs: True
    - force: True
    - backupname: "kitty-backup"

{{ grains.homedir }}/.config:
  file.directory:
    - user: {{ grains.user }}
    - group: {{ grains.group }}
    - recurse:
      - user
      - group
