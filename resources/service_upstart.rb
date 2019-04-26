resource_name :beats_service_manager_upstart

provides :beats_service_manager, platform_family: 'debian' do |_node|
  Chef::Platform::ServiceHelpers.service_resource_providers.include?(:upstart) &&
    !Chef::Platform::ServiceHelpers.service_resource_providers.include?(:systemd)
end

default_action :start

action :start do
  template new_resource.beat do
    source 'upstart.conf.erb'
    cookbook 'beats'
    owner 'root'
    group 'root'
    mode '0755'
    path "/etc/init/#{new_resource.beat}.conf"
    variables(service: new_resource.beat)
  end

  service 'filebeat' do
    provider Chef::Provider::Service::Upstart
    supports status: true
    action %i[enable start]
  end
end

action :stop do
  service 'filebeat' do
    provider Chef::Provider::Service::Upstart
    supports status: true
    action :stop
  end
end

action :restart do
  action_stop
  action_start
end
