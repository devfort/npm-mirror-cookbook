# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "npm-mirror-berkshelf"
  config.vm.box = "npm-mirror"
  # TODO: Find a suitable basebox for Vagrant (we need dozens of gigs!)
  # TODO: VM box URL
  # config.vm.box_url = ""

  config.vm.network :forwarded_port, guest: 5984, host: 5984

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
