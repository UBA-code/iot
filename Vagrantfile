Vagrant.configure("2") do |config|
  config.vm.define "server" do |server|
    server.vm.hostname = "ybel-hacS"
    server.vm.box = "ubuntu/bionic64"
    server.vm.network "private_network", ip: "192.168.56.110"
    server.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus = 1
    end
    
  end

  config.vm.define "serverWorker" do |serverWorker|
    serverWorker.vm.hostname ="ybel-hacSW"
    serverWorker.vm.box = "ubuntu/bionic64"
    serverWorker.vm.network "private_network", ip: "192.168.56.111"
    serverWorker.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus = 1
    end
  end
end