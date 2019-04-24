#!/usr/bin/env bash

vagrant ssh storidge-1 --no-tty -c "curl -fsSL ftp://download.storidge.com/pub/ce/cio-ce | sudo bash;"
vagrant ssh storidge-2 --no-tty -c "curl -fsSL ftp://download.storidge.com/pub/ce/cio-ce | sudo bash;"
vagrant ssh storidge-3 --no-tty -c "curl -fsSL ftp://download.storidge.com/pub/ce/cio-ce | sudo bash;"

exit 0
