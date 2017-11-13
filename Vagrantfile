# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

unless Vagrant.has_plugin?("vagrant-vbguest")
  raise 'vagrant-vbguest is not installed! Run  "vagrant plugin install vagrant-vbguest"'
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    #config.vm.box = "ubuntu/trusty64"
    config.vm.box = "debian/stretch64"
    #config.vm.synced_folder ".", "/vagrant"
    config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

    # Mount shared folder using NFS
    #config.vm.synced_folder ".", "/vagrant",
    #    id: "core",
    #    :nfs => true,
    #    :mount_options => ['nolock,vers=3,udp,noatime']

    # Do some network configuration
    config.vm.network "private_network", ip: "192.168.100.100"

    # Assign a quarter of host memory and all available CPU's to VM
    # Depending on host OS this has to be done differently.
    config.vm.provider :virtualbox do |vb|
        host = RbConfig::CONFIG['host_os']

        if host =~ /darwin/
            cpus = `sysctl -n hw.ncpu`.to_i
            mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4

        elsif host =~ /linux/
            cpus = `nproc`.to_i
            mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4

        # Windows...
        else
            cpus = 4
            mem = 2048
        end

        vb.customize ["modifyvm", :id, "--memory", mem]
        vb.customize ["modifyvm", :id, "--cpus", cpus]
    end
   
    config.vm.post_up_message = "Webserver: http://192.168.100.100:3000"
    config.vm.provision :shell, :path => "bootstrap.sh", privileged: false
    config.vm.provision :shell, :path => "bootstrap_always.sh", run: 'always', privileged: false



end
