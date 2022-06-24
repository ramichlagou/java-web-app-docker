# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|

#   config.vm.provision "shell", path: "bootstrap.sh"

  # Kubernetes master1 Server
  config.vm.define "master1" do |master1|
    master1.vm.box = "centos/7"
    master1.vm.hostname = "master1.alphorm.form"
    master1.vm.network "private_network", ip: "172.16.0.100"
    master1.vm.provider "virtualbox" do |v|
      v.name = "master1"
      v.memory = 5048
      v.cpus = 4
      # Prevent VirtualBox from interfering with host audio stack
      v.customize ["modifyvm", :id, "--audio", "none"]
    end
    # master1.vm.provision "shell", path: "bootstrap_master.sh"
  end
  config.vm.define "jenkins1" do |jenkins1|
    jenkins1.vm.box = "centos/7"
    jenkins1.vm.hostname = "jenkins1"
    jenkins1.vm.network "private_network", ip: "172.16.0.102"
    jenkins1.vm.provider "virtualbox" do |v|
      v.name = "jenkins1"
      v.memory = 5048
      v.cpus = 4
      # Prevent VirtualBox from interfering with host audio stack
      v.customize ["modifyvm", :id, "--audio", "none"]
    end
  end

  NodeCount = 1

  # Kubernetes Worker Nodes
  (1..NodeCount).each do |i|
    config.vm.define "worker1#{i}" do |workernode|
      workernode.vm.box = "centos/7"
      workernode.vm.hostname = "worker#{i}.alphorm.form"
      workernode.vm.network "private_network", ip: "172.16.0.10#{i}"
      workernode.vm.provider "virtualbox" do |v|
        v.name = "worker1#{i}"
        v.memory = 5024
        v.cpus = 4
        # Prevent VirtualBox from interfering with host audio stack
        v.customize ["modifyvm", :id, "--audio", "none"]
      end
    #  workernode.vm.provision "shell", path: "bootstrap_worker.sh"
    end
  end

end