install-tmux:
  pkg.installed:
    - name: tmux

tmux-plugin-manager:
  git.cloned:
    - name: https://github.com/tmux-plugins/tpm
    - target: {{ grains.homedir }}/.tmux/plugins/tpm

tmux-config:
  file.symlink:
    - name: {{ grains.homedir }}/.tmux.conf
    - target: {{ grains.statesdir }}/tmux/tmux-conf
    - user: {{ grains.user }}
    - group: {{ grains.group }}

restore-tmux-permissions:
  file.directory:
    - name: {{ grains.homedir }}/.tmux
    - user: {{ grains.user }}
    - group: {{ grains.group }}
    - recurse:
      - user
      - group
