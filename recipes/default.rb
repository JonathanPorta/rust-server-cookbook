#
# Cookbook Name:: rust
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'rust::steamcmd'
include_recipe 'nssm'

# Install and update the rust server files
rust_steamcmd '258550' do
  app_id
  action :install
  path 'c:/rust-server/'
end

include_recipe 'rust::oxide'

# Drop off the moderator/owner config
cookbook_file 'server/cfg/users.cfg' do
  path 'c:/rust-server/server/server/cfg/users.cfg'
end

# Create a start script for the server
template 'c:/rust-server/start.ps1' do
  source 'rust-server.ps1.erb'
  variables({
    install_path: 'c:/rust-server/',
    name: '~aaaamazing PVE Server - No Sleepers - Noob friendly - rust.rurd4me.com',
    maxplayers: 50,
    port: 28055,
    identity: 'server',
    seed: 696969,
    worldsize: 4000,
    rcon_port: 5718,
    rcon_password: '',
    rcon_ip: ''
  })
end

# Install, configure and start the server service
nssm 'RustMultiplayerServer' do
  program 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'
  args '-noexit c:/rust-server/start.ps1'
  params(
    DisplayName: 'RustMultiplayerServer',
    Description: 'Service in charge of the Rust multiplayer server.',
    AppDirectory: 'c:/rust-server/',
    AppStdout: 'c:/rust-server/service-stdout.log',
    AppStderr: 'c:/rust-server/service-stderr.log',
    AppRotateFiles: 1,
    AppThrottle: 1500,
    AppExit: 'Default Restart',
    AppRestartDelay: 1000
  )
  action :install
  notifies :restart, 'service[RustMultiplayerServer]', :immediately
end
