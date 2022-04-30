Vagrant.configure("2") do |config|
  config.vm.define "ubuntu" do |a|
    a.vm.box = "ubuntu/jammy64"

    a.vm.network :private_network, ip: "192.168.60.3"
    a.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--cpus", 4]
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--name", "Mimir"]
    end

    # VAGRANT_EXPERIMENTAL=disks vagrant up
    #
    # sudo apt install zfsutils-linux
    # sudo zpool create data mirror /dev/sdc /dev/sdd
    # sudo zfs set mountpoint=/data data
    # sudo zpool add data cache /dev/sde
    config.vm.disk :disk, size: "10GB", name: "zfs1"
    config.vm.disk :disk, size: "10GB", name: "zfs2"
    config.vm.disk :disk, size: "4GB", name: "l2arc"

    config.ssh.forward_agent = true
    config.vm.synced_folder ".", "/home/ubuntu/mimir", owner: "ubuntu"
    config.ssh.extra_args = ["-t", "cd /home/ubuntu/mimir; sudo su ubuntu; tmux -CC new -A -s tmssh"]
  end
end

