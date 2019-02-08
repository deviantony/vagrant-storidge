#!/usr/bin/env bash

# Authorize public keys across all machines
vagrant upload storidge-2/id_rsa.pub /tmp/id_rsa.pub.2 storidge-1
vagrant upload storidge-3/id_rsa.pub /tmp/id_rsa.pub.3 storidge-1
vagrant ssh storidge-1 --no-tty -c "cat /tmp/id_rsa.pub.2 | sudo tee -a /root/.ssh/authorized_keys"
vagrant ssh storidge-1 --no-tty -c "cat /tmp/id_rsa.pub.3 | sudo tee -a /root/.ssh/authorized_keys"

vagrant upload storidge-1/id_rsa.pub /tmp/id_rsa.pub.1 storidge-2
vagrant upload storidge-3/id_rsa.pub /tmp/id_rsa.pub.3 storidge-2
vagrant ssh storidge-2 --no-tty -c "cat /tmp/id_rsa.pub.1 | sudo tee -a /root/.ssh/authorized_keys"
vagrant ssh storidge-2 --no-tty -c "cat /tmp/id_rsa.pub.3 | sudo tee -a /root/.ssh/authorized_keys"

vagrant upload storidge-1/id_rsa.pub /tmp/id_rsa.pub.1 storidge-3
vagrant upload storidge-2/id_rsa.pub /tmp/id_rsa.pub.2 storidge-3
vagrant ssh storidge-3 --no-tty -c "cat /tmp/id_rsa.pub.1 | sudo tee -a /root/.ssh/authorized_keys"
vagrant ssh storidge-3 --no-tty -c "cat /tmp/id_rsa.pub.2 | sudo tee -a /root/.ssh/authorized_keys"

vagrant ssh storidge-1 --no-tty -c "sudo sed -i 's/ExecStart=\/usr\/bin\/dockerd -H unix:\/\//ExecStart=\/usr\/bin\/dockerd -H unix:\/\/ -H tcp:\/\/10.0.9.10:2375/g' /lib/systemd/system/docker.service"
vagrant ssh storidge-1 --no-tty -c "sudo systemctl daemon-reload && sudo systemctl restart docker"

CLUSTER_CREATE_OUTPUT=$(vagrant ssh storidge-1 --no-tty -c "sudo cioctl create --ip 10.0.9.10")
JOIN_COMMAND=$(echo "${CLUSTER_CREATE_OUTPUT}" | grep 'cioctl join' | xargs)
INIT_COMMAND=$(echo "${CLUSTER_CREATE_OUTPUT}" | grep 'cioctl init' | xargs)

vagrant ssh storidge-2 --no-tty -c "sudo ${JOIN_COMMAND} --ip 10.0.9.11"
vagrant ssh storidge-3 --no-tty -c "sudo ${JOIN_COMMAND} --ip 10.0.9.12"
vagrant ssh storidge-1 --no-tty -c "sudo ${INIT_COMMAND}"

exit 0
