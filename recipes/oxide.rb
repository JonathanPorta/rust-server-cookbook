#
# Cookbook Name:: rust
# Recipe:: oxide
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'windows'

# Stop the service before we apply the oxide patch
service 'RustMultiplayerServer' do
  action :stop
end

# Install oxide mod
windows_zipfile node['rust']['install_directory'] do
  source node['oxide']['pkg_url']
  action :unzip
  overwrite true
  notifies :restart, 'service[RustMultiplayerServer]', :immediately
end
