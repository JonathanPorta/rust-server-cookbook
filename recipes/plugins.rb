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

# deathnotes:
cookbook_file 'deathnotes.py' do
  source 'oxide/plugins/deathnotes.py'
  path 'c:/rust-server/server/server/oxide/plugins/deathnotes.py'
end

cookbook_file 'deathnotes.json' do
  source 'oxide/config/deathnotes.json'
  path 'c:/rust-server/server/server/oxide/config/deathnotes.json'
end

# friendsapi:
cookbook_file '0friendsAPI.lua' do
  source 'oxide/plugins/0friendsAPI.lua'
  path 'c:/rust-server/server/server/oxide/plugins/0friendsAPI.lua'
end

cookbook_file '0friendsAPI.json' do
  source 'oxide/config/0friendsAPI.json'
  path 'c:/rust-server/server/server/oxide/config/0friendsAPI.json'
end

# friendsfriendlyfire:
cookbook_file 'friendsfriendlyfire.lua' do
  source 'oxide/plugins/friendsfriendlyfire.lua'
  path 'c:/rust-server/server/server/oxide/plugins/friendsfriendlyfire.lua'
end

cookbook_file 'friendsfriendlyfire.json' do
  source 'oxide/config/friendsfriendlyfire.json'
  path 'c:/rust-server/server/server/oxide/config/friendsfriendlyfire.json'
end
