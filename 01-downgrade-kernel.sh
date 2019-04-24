#!/usr/bin/env bash

vagrant ssh storidge-1 --no-tty -c "sudo apt-get update && sudo apt-get install -y linux-image-4.4.0-142 linux-image-extra-4.4.0-142 linux-headers-4.4.0-142 linux-headers-4.4.0-142-generic"
vagrant ssh storidge-1 --no-tty -c "sudo sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=saved/g' /etc/default/grub && sudo update-grub && sudo grub-set-default \"1>4\" && sudo grub-reboot \"1>4\" && sudo reboot;"

vagrant ssh storidge-2 --no-tty -c "sudo apt-get update && sudo apt-get install -y linux-image-4.4.0-142 linux-image-extra-4.4.0-142 linux-headers-4.4.0-142 linux-headers-4.4.0-142-generic"
vagrant ssh storidge-2 --no-tty -c "sudo sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=saved/g' /etc/default/grub && sudo update-grub && sudo grub-set-default \"1>4\" && sudo grub-reboot \"1>4\" && sudo reboot;"

vagrant ssh storidge-3 --no-tty -c "sudo apt-get update && sudo apt-get install -y linux-image-4.4.0-142 linux-image-extra-4.4.0-142 linux-headers-4.4.0-142 linux-headers-4.4.0-142-generic"
vagrant ssh storidge-3 --no-tty -c "sudo sed -i 's/GRUB_DEFAULT=0/GRUB_DEFAULT=saved/g' /etc/default/grub && sudo update-grub && sudo grub-set-default \"1>4\" && sudo grub-reboot \"1>4\" && sudo reboot;"

exit 0
