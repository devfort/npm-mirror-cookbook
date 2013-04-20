# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "npm-mirror"
  
  config.vm.forward_port 5984, 5984

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["chef/cookbooks", "chef/opscode-cookbooks"]
    chef.add_recipe "npm-mirror"
  end
end
