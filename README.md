# Storidge powered by Vagrant

This repository allows you to quickly setup a Storidge environment (http://storidge.com/) on Ubuntu 16.04 using Vagrant.

## Requirements

Install Vagrant: https://www.vagrantup.com/ and Virtualbox: https://www.virtualbox.org/

## Configuration

The original configuration (available in the `Vagrantfile`) can be overrided using the following environment variables:

* `VAGRANT_STORIDGE_CLUSTER_NODES`: number of nodes inside the Storidge cluster (default: `3`)
* `VAGRANT_STORIDGE_NODE_MEM`: memory associated to each node in MB (default: `512`)
* `VAGRANT_STORIDGE_DISK_COUNT`: number of data disks per Storidge node (default: `3`)
* `VAGRANT_STORIDGE_DATA_DISK_SIZE`: data disk size in GB (default: `2`)

See the usage section below on how to use these variables.

## Usage

Spin up the virtual machines:

```
vagrant up
```

Example with configuration override:
```
export VAGRANT_STORIDGE_DATA_DISK_SIZE=20
vagrant up
```

After the VMs are ready, use the following script to install and setup Storidge:

```
./02-install-cio-and-setup-cluster.sh all
```

**NOTE**: This script will also expose the Docker API over TCP for the first node of the cluster (`10.0.9.10:2375`).

After the setup is completed, you can access the Portainer interface on *10.0.9.10:9000*.

## Convenience scripts

The `01-downgrade-kernel.sh` script can be used to downgrade each VM kernel version to a specific kernel version.

You must configure the `KERNEL_VERSION` variable in this script first and then start it before using the `02-install-cio-and-setup-cluster.sh` script.


```
vagrant up
./01-downgrade-kernel.sh
# Wait for VMs to reboot
./02-install-cio-and-setup-cluster.sh all
```
