#!/usr/bin/env bash

INSTALL_KERNEL="sudo apt-get update && sudo apt-get install -y linux-image-4.4.0-142 linux-image-extra-4.4.0-142 linux-headers-4.4.0-142 linux-headers-4.4.0-142-generic"
DOWNGRADE_KERNEL="sudo sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=saved/g' /etc/default/grub && sudo update-grub && sudo grub-set-default \"1>4\" && sudo grub-reboot \"1>4\" && sudo reboot;"
STORIDGE_CLUSTER_NODES=3

if [ ! -z "${VAGRANT_STORIDGE_CLUSTER_NODES}" ]
then
    STORIDGE_CLUSTER_NODES=${VAGRANT_STORIDGE_CLUSTER_NODES}
fi

# Install kernel on all machines
install() {
    echo " ===== STARTING KERNEL INSTALL FOR ${STORIDGE_CLUSTER_NODES} MACHINES ====="

    for (( i=1; i<=$STORIDGE_CLUSTER_NODES; i++ ))
    do
        (vagrant ssh storidge-$i --no-tty -c "${INSTALL_KERNEL}" | sed "s/^/[storidge-$i] /") &
    done
    wait

    echo " ===== KERNEL INSTALLED ON ALL MACHINES ====="
}

# Rollback kernel on all machines
rollback() {
    echo " ===== STARTING KERNEL ROLLBACK FOR ${STORIDGE_CLUSTER_NODES} MACHINES ====="

    for (( i=1; i<=$STORIDGE_CLUSTER_NODES; i++ ))
    do
        (vagrant ssh storidge-$i --no-tty -c "${DOWNGRADE_KERNEL}" | sed "s/^/[storidge-$i] /") &
    done
    wait

    echo " ==== KERNEL DOWNGRADED ON ALL MACHINES ====="
}

install
rollback
exit 0
