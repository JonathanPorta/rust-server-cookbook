#
# Cookbook Name:: rust
# Recipe:: steamcmd
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'windows'

# Install steamcmd
windows_zipfile node['steamcmd']['install_directory'] do
  source node['steamcmd']['pkg_url']
  action :unzip
  not_if {::File.exists?("#{ node['steamcmd']['install_directory'] }steamcmd.exe")}
end

windows_path node['steamcmd']['install_directory'] do
  action :add
end

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

# Create a windows service for the start script
require 'chef/application/windows_service_manager'
ruby_block 'create service' do
  block do
    Chef::Application::WindowsServiceManager.new(
      service_name: "RustMultiplayerServer",
      service_display_name: "RustMultiplayerServer",
      service_description: 'Service configuration for the Rust multiplayer server.',
      service_file_path: "c:/rust-server/start.ps1",
    ).run(%w{-a install})
  end
end

# Install and enable the service
service 'RustMultiplayerServer' do
  action [:enable, :start]
end
