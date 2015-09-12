#
# Cookbook Name:: rust
# Recipe:: plugins
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

directory node['oxide']['plugin_directory'] do
  recursive true
end

directory node['oxide']['plugin_config_directory'] do
  recursive true
end

### 0friendsapi:
cookbook_file '0friendsAPI.lua' do
  source 'oxide/plugins/0friendsAPI.lua'
  path "#{ node['oxide']['plugin_directory'] }0friendsAPI.lua"
end

cookbook_file '0friendsAPI.json' do
  source 'oxide/config/0friendsAPI.json'
  path "#{ node['oxide']['plugin_config_directory'] }0friendsAPI.json"
end

### AutoDoorCloser:
cookbook_file 'AutoDoorCloser.cs' do
  source 'oxide/plugins/AutoDoorCloser.cs'
  path "#{ node['oxide']['plugin_directory'] }AutoDoorCloser.cs"
end

cookbook_file 'AutoDoorCloser.json' do
  source 'oxide/config/AutoDoorCloser.json'
  path "#{ node['oxide']['plugin_config_directory'] }AutoDoorCloser.json"
end

### DeathNotes:
cookbook_file 'DeathNotes.cs' do
  source 'oxide/plugins/DeathNotes.cs'
  path "#{ node['oxide']['plugin_directory'] }DeathNotes.cs"
end

cookbook_file 'DeathNotes.json' do
  source 'oxide/config/DeathNotes.json'
  path "#{ node['oxide']['plugin_config_directory'] }DeathNotes.json"
end

### FriendlyFire:
cookbook_file 'FriendlyFire.cs' do
  source 'oxide/plugins/FriendlyFire.cs'
  path "#{ node['oxide']['plugin_directory'] }FriendlyFire.cs"
end

cookbook_file 'FriendlyFire.json' do
  source 'oxide/config/FriendlyFire.json'
  path "#{ node['oxide']['plugin_config_directory'] }FriendlyFire.json"
end

### GatherManager:
cookbook_file 'GatherManager.cs' do
  source 'oxide/plugins/GatherManager.cs'
  path "#{ node['oxide']['plugin_directory'] }GatherManager.cs"
end

cookbook_file 'GatherManager.json' do
  source 'oxide/config/GatherManager.json'
  path "#{ node['oxide']['plugin_config_directory'] }GatherManager.json"
end

### helptext:
cookbook_file 'helptext.lua' do
  source 'oxide/plugins/helptext.lua'
  path "#{ node['oxide']['plugin_directory'] }helptext.lua"
end

cookbook_file 'helptext.json' do
  source 'oxide/config/helptext.json'
  path "#{ node['oxide']['plugin_config_directory'] }helptext.json"
end

### m-Teleportation:
cookbook_file 'm-Teleportation.lua' do
  source 'oxide/plugins/m-Teleportation.lua'
  path "#{ node['oxide']['plugin_directory'] }m-Teleportation.lua"
end

cookbook_file 'm-Teleportation.json' do
  source 'oxide/config/m-Teleportation.json'
  path "#{ node['oxide']['plugin_config_directory'] }m-Teleportation.json"
end

### PlayerTrade:
cookbook_file 'PlayerTrade.cs' do
  source 'oxide/plugins/PlayerTrade.cs'
  path "#{ node['oxide']['plugin_directory'] }PlayerTrade.cs"
end

cookbook_file 'PlayerTrade.json' do
  source 'oxide/config/PlayerTrade.json'
  path "#{ node['oxide']['plugin_config_directory'] }PlayerTrade.json"
end

### RemoverTool:
cookbook_file 'RemoverTool.cs' do
  source 'oxide/plugins/RemoverTool.cs'
  path "#{ node['oxide']['plugin_directory'] }RemoverTool.cs"
end

cookbook_file 'RemoverTool.json' do
  source 'oxide/config/RemoverTool.json'
  path "#{ node['oxide']['plugin_config_directory'] }RemoverTool.json"
end

### playrust.io:
cookbook_file 'Oxide.Ext.RustIO.dll' do
  source 'oxide/plugins/Oxide.Ext.RustIO.dll'
  path 'c:/rust-server/RustDedicated_Data/Managed/Oxide.Ext.RustIO.dll'
end

cookbook_file 'rustio.json' do
  source 'oxide/config/rustio.json'
  path "#{ node['oxide']['plugin_config_directory'] }rustio.json"
end

### StackSizeController:
cookbook_file 'StackSizeController.cs' do
  source 'oxide/plugins/StackSizeController.cs'
  path "#{ node['oxide']['plugin_directory'] }StackSizeController.cs"
end

cookbook_file 'StackSizeController.json' do
  source 'oxide/config/StackSizeController.json'
  path "#{ node['oxide']['plugin_config_directory'] }StackSizeController.json"
end
