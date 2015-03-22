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

# playrust.io:
cookbook_file 'Oxide.Ext.RustIO' do
  source 'oxide/plugins/Oxide.Ext.RustIO'
  path 'c:/rust-server/RustDedicated_Data/Managed/Oxide.Ext.RustIO'
end
