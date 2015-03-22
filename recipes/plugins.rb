#
# Cookbook Name:: rust
# Recipe:: plugins
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# chathandler:
cookbook_file 'chathandler.lua' do
  source 'oxide/plugins/chathandler.lua'
  path 'c:/rust-server/server/server/oxide/plugins/chathandler.lua'
end

cookbook_file 'chathandler.json' do
  source 'oxide/config/chathandler.json'
  path 'c:/rust-server/server/server/oxide/config/chathandler.json'
end

# playrust.io:
cookbook_file 'Oxide.Ext.RustIO.dll' do
  source 'oxide/plugins/Oxide.Ext.RustIO.dll'
  path 'c:/rust-server/RustDedicated_Data/Managed/Oxide.Ext.RustIO.dll'
end

cookbook_file 'rustio.json' do
  source 'oxide/config/rustio.json'
  path 'c:/rust-server/server/server/oxide/config/rustio.json'
end

cookbook_file 'users.cfg' do
  source 'server/cfg/users.cfg'
  path 'c:/rust-server/server/server/cfg/users.cfg'
end
