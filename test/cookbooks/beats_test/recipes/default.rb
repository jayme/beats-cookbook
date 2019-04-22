#
# Cookbook:: beats
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#

filebeat 'default'
metricbeat 'default'
packetbeat 'default' if %w[debian ubuntu].include?(node['platform'])

beat_module 'default'
