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
    name: '~aaaamazing PVE Server - No Sleepers - Noob friendly - rust.rurd4me.com',
    maxplayers: 50,
    port: 28055,
    identity: 'server',
    seed: 696969,
    worldsize: 4000,
    rcon_port: 5718,
    rcon_password: lazy { secure_password },
    rcon_ip: '0.0.0.0'
  })
end

# Install, configure and start the server service
nssm 'RustMultiplayerServer' do
  program 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'
  args "-noexit #{ node['rust']['install_directory'] }start.ps1"
  params(
    DisplayName: 'RustMultiplayerServer',
    Description: 'Service in charge of the Rust multiplayer server.',
    AppDirectory: node['rust']['install_directory'],
    AppStdout: "#{ node['rust']['install_directory'] }service-stdout.log",
    AppStderr: "#{ node['rust']['install_directory'] }service-stderr.log",
    AppRotateFiles: 1,
    AppThrottle: 1500,
    AppExit: 'Default Restart',
    AppRestartDelay: 1000
  )
  action :install
  #notifies :restart, 'service[RustMultiplayerServer]', :delayed
end

windows_firewall_rule 'RustServer-TCP' do
  localport '28055'
  protocol 'TCP'
  firewall_action :allow
end

windows_firewall_rule 'RustServer-UDP' do
  localport '28055'
  protocol 'UDP'
  firewall_action :allow
end

windows_firewall_rule 'RustServer-RCON-TCP' do
  localport '5718'
  protocol 'TCP'
  firewall_action :allow
end

windows_firewall_rule 'RustServer-RCON-UDP' do
  localport '5718'
  protocol 'UDP'
  firewall_action :allow
end
