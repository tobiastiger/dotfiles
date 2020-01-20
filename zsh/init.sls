zsh:
  pkg.installed

clear-oh-my-zsh:
  file.absent:
    - name: {{ grains.homedir }}/.oh-my-zsh

clear-zsh:
  file.absent:
    - name: {{ grains.homedir }}/.zshrc

oh-my-zsh:
  git.latest:
    - name: https://github.com/robbyrussell/oh-my-zsh.git
    - target: {{ grains.homedir }}/.oh-my-zsh

create-zsh-folder:
  file.directory:
    - name: {{ grains.homedir }}/zsh
    - user: {{ grains.user }}
    - group: {{ grains.group }}

link-prompt:
  file.symlink:
    - name: {{ grains.homedir }}/zsh/promptrc
    - target: {{ grains.statesdir }}/zsh/promptrc
    - user: {{ grains.user }}
    - group: {{ grains.group }}

link-zsh:
  file.symlink:
  - name: {{ grains.homedir}}/.zshrc
  - target: {{ grains.statesdir }}/zsh/zshrc
  - user: {{ grains.user }}
  - group: {{ grains.group }}

spaceship-prompt-oh-my-zsh:
  git.latest:
    - name : https://github.com/denysdovhan/spaceship-prompt.git
    - target: {{ grains.homedir }}/.oh-my-zsh/custom/themes/spaceship-prompt

  file.symlink:
    - name: {{ grains.homedir }}/.oh-my-zsh/custom/themes/spaceship.zsh-theme
    - target: {{ grains.homedir }}/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme
    - force: True

{{ grains.homedir }}/.oh-my-zsh:
  file.directory:
    - user: {{ grains.user }}
    - group: {{ grains.group }}
    - recurse:
      - user
      - group
