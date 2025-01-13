Vagrant.configure("2") do |config|
  config.vm.define "server" do |server|
    server.vm.hostname = "ybel-hacS"
    server.vm.box = "bento/ubuntu-24.04"
    server.vm.network :private_network, ip: "192.168.56.110"
    server.vm.provider :vmware_desktop do |v|
      v.allowlist_verified = true # tell vagrant to work only with verified versions of vmware fusion
      v.gui = false
      v.vmx["numvcpus"] = "1"
      v.vmx["memsize"] = "512"
    end
  end

  config.vm.define "serverWorker" do |serverWorker|
    serverWorker.vm.hostname ="ybel-hacSW"
    serverWorker.vm.box = "bento/ubuntu-24.04"
    serverWorker.vm.network :private_network, ip: "192.168.56.111"
    serverWorker.vm.provider :vmware_desktop do |v|
      v.allowlist_verified = true
      v.gui = false
      v.vmx["numvcpus"] = "1"
      v.vmx["memsize"] = "512"
    end
  end
end