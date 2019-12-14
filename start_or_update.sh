#!/bin/bash
unset VERSION_COTURN
VERSION_COTURN=$(git ls-remote https://git.scimetis.net/yohan/docker-coturn.git| head -1 | cut -f 1|cut -c -10) \
 sudo -E bash -c 'docker-compose up -d'

