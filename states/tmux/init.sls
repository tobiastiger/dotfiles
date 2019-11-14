tmux:
  pkg.installed

tmux-plugin-manager:
  git.latest:
    - name: https://github.com/tmux-plugins/tpm
    - target: {{ grains.homedir }}/.tmux/plugins/tpm

tmux-config:
  file.symlink:
    - name: {{ grains.homedir }}/.tmux.conf
    - target: {{ grains.statesdir }}/tmux/tmux-conf
    - force: True
    - backup: "tmux-backup"
