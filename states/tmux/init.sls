tmux:
  pkg.installed

tmux-config:
  file.symlink:
    - name: {{ grains.homedir }}/.tmux.conf
    - target: {{ grains.statesdir }}/tmux/tmux-conf
    - force: True
    - backup: "tmux-backup"
