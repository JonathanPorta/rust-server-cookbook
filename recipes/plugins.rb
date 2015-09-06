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

# # chathandler:
# cookbook_file 'chathandler.lua' do
#   source 'oxide/plugins/chathandler.lua'
#   path "#{ node['oxide']['plugin_directory'] }chathandler.lua"
# end
#
# cookbook_file 'chathandler.json' do
#   source 'oxide/config/chathandler.json'
#   path "#{ node['oxide']['plugin_config_directory'] }chathandler.json"
# end

# playrust.io:
cookbook_file 'Oxide.Ext.RustIO.dll' do
  source 'oxide/plugins/Oxide.Ext.RustIO.dll'
  path 'c:/rust-server/RustDedicated_Data/Managed/Oxide.Ext.RustIO.dll'
end

cookbook_file 'rustio.json' do
  source 'oxide/config/rustio.json'
  path "#{ node['oxide']['plugin_config_directory'] }rustio.json"
end

# # deathnotes:
# cookbook_file 'deathnotes.py' do
#   source 'oxide/plugins/deathnotes.py'
#   path "#{ node['oxide']['plugin_directory'] }deathnotes.py"
# end
#
# cookbook_file 'deathnotes.json' do
#   source 'oxide/config/deathnotes.json'
#   path "#{ node['oxide']['plugin_config_directory'] }deathnotes.json"
# end
#
# # friendsapi:
# cookbook_file '0friendsAPI.lua' do
#   source 'oxide/plugins/0friendsAPI.lua'
#   path "#{ node['oxide']['plugin_directory'] }0friendsAPI.lua"
# end
#
# cookbook_file '0friendsAPI.json' do
#   source 'oxide/config/0friendsAPI.json'
#   path "#{ node['oxide']['plugin_config_directory'] }0friendsAPI.json"
# end
#
# # friendsfriendlyfire:
# cookbook_file 'friendsfriendlyfire.lua' do
#   source 'oxide/plugins/friendsfriendlyfire.lua'
#   path "#{ node['oxide']['plugin_directory'] }friendsfriendlyfire.lua"
# end
#
# cookbook_file 'friendsfriendlyfire.json' do
#   source 'oxide/config/friendsfriendlyfire.json'
#   path "#{ node['oxide']['plugin_config_directory'] }friendsfriendlyfire.json"
# end
#
# # pvpswitch:
# cookbook_file 'pvpswitch.lua' do
#   source 'oxide/plugins/pvpswitch.lua'
#   path "#{ node['oxide']['plugin_directory'] }pvpswitch.lua"
# end
#
# cookbook_file 'pvpswitch.json' do
#   source 'oxide/config/pvpswitch.json'
#   path "#{ node['oxide']['plugin_config_directory'] }pvpswitch.json"
# end
