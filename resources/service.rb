# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
#include Beats::Helpers

#resource_name :service_systemd

#provides :service, os: 'linux' do |_node|
#  Chef::Platform::ServiceHelpers.service_resource_providers.include?(:systemd)
#end

#default_action :start
