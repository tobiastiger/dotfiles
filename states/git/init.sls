git:
  pkg.installed:
    - name: git

gitconfig:
  file.symlink:
    - name: {{ grains.homedir }}/.gitconfig
    - target: {{ grains.statesdir }}/git/gitconfig
