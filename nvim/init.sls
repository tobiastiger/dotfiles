nvim:
  pkg.installed:
    - name: neovim

nvim-config:
  file.symlink:
    - name: {{ grains.homedir }}/.config/nvim
    - target: {{ grains.statesdir }}/nvim/nvim
    - makedirs: True
    - force: True

minpac:
  git.cloned:
    - name: https://github.com/k-takata/minpac.git
    - target: {{ grains.homedir }}/.local/share/nvim/site/pack/minpac/opt/minpac

{{ grains.homedir }}/.config:
  file.directory:
    - user: {{ grains.user }}
    - group: {{ grains.group }}
    - recurse:
      - user
      - group

{{ grains.homedir }}/.local:
  file.directory:
    - user: {{ grains.user }}
    - group: {{ grains.group }}
    - recurse:
      - user
      - group
