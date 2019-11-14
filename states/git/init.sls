git:
  pkg.installed:
    - name: git

gitconfig:
  file.symlink:
    - name: {{ grains.homedir }}/.gitconfig
    - target: {{ grains.statesdir }}/git/gitconfig
    - user: {{ grains.user }}
    - group: {{ grains.group }}
    - force: True
    - backup: "gitconfig-backup"
