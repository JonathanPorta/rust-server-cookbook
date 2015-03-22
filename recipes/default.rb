#
# Cookbook Name:: rust
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# include_recipe 'rust::chocolatey'
include_recipe 'rust::steamcmd'
include_recipe 'nssm'

# Install and update the rust server files
rust_steamcmd '258550' do
  app_id
  action :install
  path 'c:/rust-server/'
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

nssm 'RustMultiplayerServer' do
  program 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'
  args '-noexit c:/rust-server/start.ps1'
  action :install
end

#
# require 'chef/application/windows_service_manager'
# ruby_block 'create service' do
#   block do
#     Chef::Application::WindowsServiceManager.new(
#       service_name: "RustMultiplayerServer",
#       service_display_name: "RustMultiplayerServer",
#       service_description: 'Service configuration for the Rust multiplayer server.',
#       service_file_path: "c:/rust-server/start.ps1",
#     ).run(%w{-a install})
#   end
# end
# Create a windows service for the start script
# execute 'RustMultiplayerServer.service' do
#   command 'sc.exe create RustMultiplayerServer binPath="powershell.exe -noexit c:/rust-server/start.ps1" DisplayName=RustMultiplayerServer'
#   action :run
# end
#
# # Install and enable the service
# service 'RustMultiplayerServer' do
#   action [:enable, :start]
# end
