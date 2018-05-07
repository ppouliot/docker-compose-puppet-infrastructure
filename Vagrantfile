# -*- mode: ruby -*-
# vi: set ft=ruby :
required_plugins = %w(vagrant-docker-compose vagrant-scp vagrant-puppet-install vagrant-vbguest)
plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting."
  end
end

## Variables
$app_name = "puppetmaster.contoso.ltd"
$coreos_channel = "alpha"
$coreos_ip = "192.168.0.15"
$coreos_memory = 1024

# Definitions
Vagrant.configure(2) do |config|
  config.ssh.insert_key = false
  config.vm.hostname = $app_name
  config.vm.box = "coreos-%s" % $coreos_channel
  config.vm.box_version = ">= 1758.0.0"
  config.vm.box_url = "http://%s.release.core-os.net/amd64-usr/current/coreos_production_vagrant.json" % $coreos_channel
  
  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--name", $app_name + ".docker.vm"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    v.check_guest_additions = false
    v.functional_vboxsf     = false
    v.gui                   = false
    v.memory                = 1024
    v.cpus                  = 1
  end

  ## Avoid plugin conflicts
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end
  config.vm.network :private_network, ip: $coreos_ip
#  config.vm.network "forwarded_port", guest: 3306, host: 3306
  config.vm.provision :docker

  config.vm.provision :docker_compose,
    yml: "/vagrant/docker-compose.yml",
    rebuild: false,
    run: "always"
end
