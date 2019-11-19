install-tmux:
  pkg.installed:
    - name: tmux

tmux-plugin-manager:
  git.latest:
    - name: https://github.com/tmux-plugins/tpm
    - target: {{ grains.homedir }}/.tmux/plugins/tpm

tmux-config:
  file.symlink:
    - name: {{ grains.homedir }}/.tmux.conf
    - target: {{ grains.statesdir }}/tmux/tmux-conf
    - user: {{ grains.user }}
    - group: {{ grains.group }}
    - force: True
    - backup: "tmux-backup"

{{ grains.homedir }}/.tmux:
  file.directory:
    - user: {{ grains.user }}
    - group: {{ grains.group }}
    - recurse:
      - user
      - group
