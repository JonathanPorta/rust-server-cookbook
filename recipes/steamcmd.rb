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

rust_steamcmd do
  app_id '258550'
  action :install
  path 'c:/rust-server/'
end
