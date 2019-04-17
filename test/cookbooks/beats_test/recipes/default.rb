#
# Cookbook:: beats
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#

if %w(debian ubuntu).include?(node['platform'])
  filebeat 'default'
  metricbeat 'default'
  packetbeat 'default'
else
  filebeat 'default'
  metricbeat 'default'
end

beat_module 'default'
