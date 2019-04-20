$node_count = 3

Vagrant.configure("2") do |config|
	config.vm.provider "virtualbox" do |vbox|
		vbox.gui = false
        vbox.memory=2048
        vbox.cpus=2
        vbox.check_guest_additions=false
    config.vm.box_check_update=false
    config.vm.box="cuky23/centos75"
	vbox.customize ["modifyvm", :id, "--cableconnected1", "on"]
	vbox.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
	vbox.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
    end

	(1..$node_count).each do |i|
		config.vm.define "node#{i}" do |node|
		  node.vm.network "public_network", :adapter=>2 , type: "dhcp", :bridge => "Dell Wireless 1704 802.11b/g/n (2.4GHz)"
			#node.vm.network "public_network", ip: "192.168.1.#{24+i}"
			node.vm.hostname = "node#{i}"
		end
	end
end
