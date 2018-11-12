# -*- mode: ruby -*-
# vi: set ft=ruby :
required_plugins = %w(vagrant-box-updater vagrant-disksize vagrant-docker-compose vagrant-hostsupdater vagrant-scp vagrant-puppet-install vagrant-vbguest vagrant-alpine vagrant-vyos)
plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting."
  end
end

$coreos_channel = "alpha"

# Definitions
Vagrant.configure(2) do |config|
  config.ssh.insert_key = false
  config.vm.hostname = "puppetmaster.contoso.ltd"
  config.vm.box = "coreos-%s" % $coreos_channel
  config.vm.box_version = ">= 1758.0.0"
  config.vm.box_url = "http://%s.release.core-os.net/amd64-usr/current/coreos_production_vagrant.json" % $coreos_channel
  
  config.vm.provider :virtualbox do |v|
    v.customize ["modifyvm", :id, "--name", "puppetmaster.contoso.ltd" + ".docker.vm"]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    v.check_guest_additions = false
    v.functional_vboxsf     = false
    v.gui                   = false
    v.memory                = 2048
    v.cpus                  = 1
  end

  ## Avoid plugin conflicts
  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end
  config.vm.network :private_network, ip: "192.168.0.15"
  config.hostsupdater.aliases = ["puppet.contoso.ltd", "puppetdb.contoso.ltd", "puppetexplorer.contoso.ltd", "puppetboard.contoso.ltd"]
#  config.vm.network "forwarded_port", guest: 3306, host: 3306
  config.vm.synced_folder ".", "/home/core/puppet-infrastructure", :nfs => true, :mount_options => ['nolock,vers=3,udp,noatime,actimeo=1']
  config.vm.provision :docker

  config.vm.provision :docker_compose,
    compose_version: "1.23.1",
    executable_install_path: "/home/core/docker-compose-1.11.2",
    executable_symlink_path: "/home/core/docker-compose",
    yml: "/home/core/puppet-infrastructure/docker-compose.yml",
    rebuild: false,
    run: "always"
end
