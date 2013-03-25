# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "npm-mirror"
  # config.vm.box_url = "http://domain.com/path/to/above.box"
  config.vm.customize [
    "modifyvm", :id,
    "--name",   "npm-mirror"
  ]
  
  config.vm.forward_port 5984, 5984, :auto =>true

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["chef/cookbooks", "chef/opscode-cookbooks"]
    chef.add_recipe "npm-mirror"
    
    # You may also specify custom JSON attributes:
    chef.json = {}
  end
end
