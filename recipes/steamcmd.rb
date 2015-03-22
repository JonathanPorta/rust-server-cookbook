#
# Cookbook Name:: endpoint
# Recipe:: steamcmd
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'windows'

remote_file 'steamcmd_package' do
  path 'c:/tmp/steamcmd.zip'
  source node['steamcmd']['pkg_url']
end

windows_zipfile node['steamcmd']['install_directory'] do
  source 'c:/tmp/steamcmd.zip'
  action :unzip
end
