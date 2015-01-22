# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "box-cutter/ubuntu1404-desktop"
  config.persistent_storage.enabled = true
  config.persistent_storage.location = "test.vdi"
  config.persistent_storage.size = 10000
  config.persistent_storage.mountname = 'test'
  config.persistent_storage.filesystem = 'ext4'
  config.persistent_storage.mountpoint = '/test'
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "..", "/andrew"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true

    # Customize the amount of memory on the VM:
    vb.memory = "32768"
    vb.cpus = "8"
    vb.customize ['storageattach', :id, '--storagectl', 'IDE Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', "persist.vdi"]
  end

  config.vm.provision "chef_zero" do |chef|
    chef.cookbooks_path = "cookbooks"
    # chef.nodes_path = "chef/nodes"
    chef.roles_path = "roles"
    chef.add_recipe "devbox::default"
    chef.verbose_logging = true
  end
#   config.vm.provision "shell", inline: <<SHELL
# sudo apt-get update
# sudo apt-get install -y virtualbox-guest-dkms
# # sudo apt-get install -y virtualbox-guest-modules
# sudo apt-get install -y virtualbox-guest-utils
# sudo apt-get install -y virtualbox-guest-x11
# sudo apt-get install -y curl
# sudo apt-get install -y emacs
# sudo apt-get install -y firefox
# sudo apt-get install -y git
# sudo apt-get install -y python
# sudo apt-get install -y python3
# sudo apt-get install -y ipython3
# sudo apt-get install -y ipython
# sudo apt-get install -y r-base r-base-dev
# sudo apt-get install -y xmonad libghc-xmonad-dev libghc-xmonad-contrib-dev
# SHELL
#   config.vm.provision "shell",
#                       inline: "sudo VBoxClient -d"
#   config.vm.provision "shell",
#                       inline: "sudo sed -i 's/DEFAULT_RUNLEVEL=2/DEFAULT_RUNLEVEL=5/g' /etc/init/rc-sysinit.conf"
#   config.vm.provision "shell",
#                       inline: <<SHELL2
# sudo adduser andrew
# git init /home/andrew
# git remote add origin http://github.com/andrew-christianson/dotfiles.git
# cd /home/andrew && git fetch origin && git checkout -f origin/master && git checkout master && git branch --set-upstream-to=origin/master master
# /home/andrew/.cask/bin/cask  upgrade-cask

# cd /home/andrew/.emacs.d && /home/andrew/.cask/bin/cask install

# SHELL2
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline <<-SHELL
  #   sudo apt-get install apache2
  # SHELL
end
