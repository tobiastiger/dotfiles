roboto-mono-regular:
  file.copy:
    {% if grains.os == 'Linux' %}
    - name: {{ grains.homedir }}/.fonts/RobotoMono-Regular.ttf
    - source: {{ grains.statesdir }}/fonts/roboto-mono/RobotoMono-Regular.ttf
    - makedirs: True
    {% endif %}
