resource_name :service_manager_freebsd

#provides :service_manager, os: 'freebsd' do |_node|
#  Chef::Platform::ServiceHelpers.service_resource_providers.include?(:freebsd)
#end
provides :service_manager, os: 'freebsd'

default_action :start

action :start do
  service "#{new_resource.beat}" do
    provider Chef::Provider::Service::Init::Freebsd
    supports status: true
    action [:start]
  end
end

action :stop do
  service "#{new_resource.beat}" do
    provider Chef::Provider::Service::Init::Freebsd
    supports status: true
    action [:stop]
  end
end

action :restart do
  action_stop
  action_start
end
