# Memory associated to each Storidge (MB)
STORIDGE_NODE_MEM = "512"
# Number of data disks per Storidge node
STORIDGE_DISK_COUNT = 3
# Storidge data disks size
STORIDGE_DATA_DISK_SIZE = 2 * 1024


SCRIPT_STORIDGE_SETUP = <<SCRIPT
curl -fsSL ftp://download.storidge.com/pub/ce/cio-ce | bash;
INIT_COMMAND=$(cioctl create --ip 10.0.9.10 | grep "cioctl init" | awk '{$1=$1};1');
${INIT_COMMAND};
SCRIPT

Vagrant.configure(2) do |config|
  config.vm.define "storidge1" do |config|
    config.vm.box = "ubuntu/xenial64"
    config.vm.hostname = "storidge1"
    config.vm.network "private_network", ip: "10.0.9.10"
    config.vm.provision "shell", inline: SCRIPT_STORIDGE_SETUP
    config.vm.synced_folder ".", "/vagrant", disabled: true


    config.vm.provider "virtualbox" do |vb|
      vb.memory = STORIDGE_NODE_MEM

      (1..STORIDGE_DISK_COUNT).each do |i|
        unless File.exist?("storidge1_disk#{i}.vdi")
          vb.customize ["createhd", "--filename", "storidge1_disk#{i}.vdi", "--size", STORIDGE_DATA_DISK_SIZE]
        end
        vb.customize ["storageattach", :id,  "--storagectl", "SCSI", "--port", i + 1, "--device", 0, "--type", "hdd", "--medium", "storidge1_disk#{i}.vdi"]
      end
    end
  end
end
