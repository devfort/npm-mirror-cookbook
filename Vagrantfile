# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "npm-mirror-berkshelf"
  config.vm.box = "devfort-ubuntu-13.04-provisionerless-120gb"

  config.vm.network :forwarded_port, guest: 5984, host: 5984

  config.omnibus.chef_version = :latest
  config.berkshelf.enabled = true
  config.vm.provision :chef_solo do |chef|
    chef.json = {
      'npm_mirror' => {
        'user' => 'vagrant'
      }
    }

    chef.run_list = [
      "recipe[npm-mirror::default]",
    ]
  end
end
