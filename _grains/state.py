import os
import grp
import sys


def user_state():
    grains = {}
    grains['os'] = sys.platform
    grains['user'] = os.path.expandvars('$SUDO_USER')
    grains['group'] = grp.getgrnam(grains['user'])[0]
    grains['homedir'] = os.path.expandvars('$HOME')
    grains['statesdir'] = os.path.expandvars('$HOME/dotfiles')
    return grains
