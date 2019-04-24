# Storidge powered by Vagrant

This repository allows you to quickly setup a Storidge (http://storidge.com/) environment on Ubuntu 16.04 using Vagrant.

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

That's it, you can now access each node via `vagrant ssh` and use the `cioctl` binary to setup your cluster.

```
vagrant ssh storidge-1
> cioctl create ...
```

A convenience setup script can be used to setup:

**WARNING**: This script can only be used with a 3 node cluster (default configuration), it will not work if you tuned the `VAGRANT_STORIDGE_CLUSTER_NODES` variable.

**NOTE**: This script will also expose the Docker API over TCP for the first node of the cluster (`10.0.9.10:2375`).

```
./setup_storidge.sh
```

After the setup is completed, you can access the Portainer interface on *10.0.9.10:9000*.

## Problem with latest kernel version

**WARNING - 25.04.2019**: Due to an issue with CIO 2751 and latest kernel version (4.4.0-146), we need to force the kernel version to 4.4.0-142.

Use the following scripts to setup the cluster:

```
./01-downgrade-kernel.sh
# Wait for cluster to reboot entirely
./02-install-cio.sh
./03-setup-cluster.sh
```
