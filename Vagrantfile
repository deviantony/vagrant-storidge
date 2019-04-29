# Number of nodes inside the Storidge cluster
STORIDGE_CLUSTER_NODES = ENV['VAGRANT_STORIDGE_CLUSTER_NODES'].nil? ? 3 : ENV['VAGRANT_STORIDGE_CLUSTER_NODES'].to_i
# Memory associated to each Storidge (MB)
STORIDGE_NODE_MEM = ENV['VAGRANT_STORIDGE_NODE_MEM'].nil? ? '1024': ENV['VAGRANT_STORIDGE_NODE_MEM']
# Number of data disks per Storidge node
STORIDGE_DISK_COUNT = ENV['VAGRANT_STORIDGE_DISK_COUNT'].nil? ? 3 : ENV['VAGRANT_STORIDGE_DISK_COUNT'].to_i
# Storidge data disks size in GB
STORIDGE_DATA_DISK_SIZE = ENV['VAGRANT_STORIDGE_DATA_DISK_SIZE'].nil? ? 2 : ENV['VAGRANT_STORIDGE_DATA_DISK_SIZE'].to_i

# SCRIPT_STORIDGE_SETUP = <<SCRIPT
# ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa;
# cp /root/.ssh/id_rsa.pub /shared;
# curl -fsSL ftp://download.storidge.com/pub/ce/cio-ce | bash;
# SCRIPT

PROVISION_SCRIPT = <<SCRIPT
ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa;
cp /root/.ssh/id_rsa.pub /shared;
SCRIPT

Vagrant.configure(2) do |config|

  (1..STORIDGE_CLUSTER_NODES).each do |i|

    config.vm.define "storidge-#{i}" do |node|
      node.vm.box = "ubuntu/xenial64"
      node.vm.hostname = "storidge-#{i}"
      node.vm.network :private_network, ip: "10.0.9.#{i + 9}"
      node.vm.provision "shell", inline: PROVISION_SCRIPT
      node.vm.synced_folder ".", "/vagrant", disabled: true
      node.vm.synced_folder "storidge-#{i}", "/shared", create: true
      node.vm.provider "virtualbox" do |vb|

        vb.memory = STORIDGE_NODE_MEM
        (1..STORIDGE_DISK_COUNT).each do |j|
          unless File.exist?("disks/storidge-#{i}_disk#{j}.vdi")
            vb.customize ["createhd", "--filename", "disks/storidge-#{i}_disk#{j}.vdi", "--size", STORIDGE_DATA_DISK_SIZE * 1024]
          end
          vb.customize ["storageattach", :id,  "--storagectl", "SCSI", "--port", j + 1, "--device", 0, "--type", "hdd", "--medium", "disks/storidge-#{i}_disk#{j}.vdi"]
        end

      end

    end

  end

end
