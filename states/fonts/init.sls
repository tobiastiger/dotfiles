roboto-mono-regular:
  file.copy:
    {% if grains.os == 'Linux' %}
    - name: {{ grains.homedir }}/.local/share/fonts/RobotoMono/RobotoMono-Regular.ttf
    - source: {{ grains.statesdir }}/fonts/roboto-mono/RobotoMono-Regular.ttf
    - makedirs: True
    {% endif %}

roboto-mono-light:
  file.copy:
    {% if grains.os == 'Linux' %}
    - name: {{ grains.homedir }}/.local/share/fonts/RobotoMono/RobotoMono-Light.ttf
    - source: {{ grains.statesdir }}/fonts/roboto-mono/RobotoMono-Light.ttf
    - makedirs: True
    {% endif %}

roboto-mono-thin:
  file.copy:
    {% if grains.os == 'Linux' %}
    - name: {{ grains.homedir }}/.local/share/fonts/RobotoMono/RobotoMono-Thin.ttf
    - source: {{ grains.statesdir }}/fonts/roboto-mono/RobotoMono-Thin.ttf
    - makedirs: True
    {% endif %}

sauce-code-pro-regular:
  file.copy:
    {% if grains.os == 'Linux' %}
    - name: {{ grains.homedir }}/.local/share/fonts/SauceCodePro/sauce-code-pro-nerd-font-regular.ttf
    - source: {{ grains.statesdir }}/fonts/sauce-code-pro/SauceCodePro-Regular.ttf
    - makedirs: True
    {% endif %}
    
sauce-code-pro-extra-light:
  file.copy:
    {% if grains.os == 'Linux' %}
    - name: {{ grains.homedir }}/.local/share/fonts/SauceCodePro/sauce-code-pro-nerd-font-light.ttf
    - source: {{ grains.statesdir }}/fonts/sauce-code-pro/SauceCodePro-Light.ttf
    - makedirs: True
    {% endif %}
