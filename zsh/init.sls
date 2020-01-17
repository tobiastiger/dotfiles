zsh:
  pkg.installed

clear-oh-my-zsh:
  file.absent:
    - name: {{ grains.homedir }}/.oh-my-zsh

clear-zsh:
  file.absent:
    - name: {{ grains.homedir }}/.zshrc

oh-my-zsh:
  cmd.run:
    - name: sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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

syntax-highlightning:
  git.latest:
    - name: https://github.com/zsh-users/zsh-syntax-highlighting.git
    - target: {{ grains.homedir }}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

{{ grains.homedir }}/.oh-my-zsh:
  file.directory:
    - user: {{ grains.user }}
    - group: {{ grains.group }}
    - recurse:
      - user
      - group
