#
# Cookbook Name:: rust
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
include_recipe 'steamcmd::install'
include_recipe 'nssm'

# Ensure that the backup directory exists
directory node['rust']['backups_directory'] do
  recursive true
end

# Backup current server install
windows_zipfile "#{ node['rust']['backups_directory'] }#{ Time.now.strftime("%Y-%m-%d-%H%M") }.zip" do
  source node['rust']['install_directory']
  action :zip
  only_if {::File.exists?(node['rust']['install_directory'])}
end

# Install and update the rust server files
steamcmd '258550' do
  path node['rust']['install_directory']
end

include_recipe 'rust::oxide'
include_recipe 'rust::plugins'

# Ensure that the server's config directory exists
directory node['rust']['config_directory'] do
  recursive true
end

# Drop off the moderator/owner config
cookbook_file 'users.cfg' do
  source 'server/cfg/users.cfg'
  path "#{ node['rust']['config_directory'] }users.cfg"
end

# Create a start script for the server
template "#{ node['rust']['install_directory'] }start.ps1" do
  source 'rust-server.ps1.erb'
  variables({
    install_path: node['rust']['install_directory'],
    name: 'Asiago -> 20X|TP|KITS|INSTACRAFT|LIVEMAP|WIPED 9/6 - rust.rurd4me.com',
    maxplayers: 50,
    port: 28015,
    identity: 'server',
    seed: 85364, # http://map.playrust.io/?Procedural%20Map_6000_85364
    worldsize: 6000,
    rcon_port: 5718,
    rcon_password: lazy { secure_password },
    rcon_ip: '0.0.0.0',
    server_description: 'High spawn + instant craft\n Get started fast. Build something huge. Blow it up. Repeat.',
    server_headerimage: 'http://i.imgur.com/eIIf9Lz.png',
    server_url: 'http://rust.rurd4me.com:28015',
    spawn_max_density: 20,
    spawn_min_density: 0.1,
    spawn_max_rate: 1,
    spawn_min_rate: 0.1,
    craft_instant: 'True'
  })
end

# # Install, configure and start the server service
# nssm 'RustMultiplayerServer' do
#   program 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'
#   args "-noexit #{ node['rust']['install_directory'] }start.ps1"
#   params(
#     DisplayName: 'RustMultiplayerServer',
#     Description: 'Service in charge of the Rust multiplayer server.',
#     AppDirectory: node['rust']['install_directory'],
#     AppStdout: "#{ node['rust']['install_directory'] }service-stdout.log",
#     AppStderr: "#{ node['rust']['install_directory'] }service-stderr.log",
#     AppRotateFiles: 1,
#     AppThrottle: 1500,
#     AppExit: 'Default Restart',
#     AppRestartDelay: 1000
#   )
#   action :install
#   #notifies :restart, 'service[RustMultiplayerServer]', :delayed
# end

# Game server port
windows_firewall_rule 'RustServer-UDP' do
  localport '28015'
  protocol 'UDP'
  firewall_action :allow
end

# Query part - may or may not be needed anymore, couldn't get a definitive answer.
windows_firewall_rule 'RustQuery-UDP' do
  localport '28016'
  protocol 'UDP'
  firewall_action :allow
end

# Playrust.io HTTP for livemap
windows_firewall_rule 'RustLivemap-TCP' do
  localport '28015'
  protocol 'TCP'
  firewall_action :allow
end

# RCON Port
windows_firewall_rule 'RustRCON-TCP' do
  localport '5718'
  protocol 'TCP'
  firewall_action :allow
end
