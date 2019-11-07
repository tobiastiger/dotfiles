configs:
  file.symlink:
    - name: {{ grains.homedir }}/.config/kitty
    - target: {{ grains.statesdir }}/kitty/kitty
    - makedirs: True
    - force: True
    - backupname: "kitty-backup"
