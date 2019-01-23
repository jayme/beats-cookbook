include Beats::Helpers

resource_name :service_manager_upstart

provides :service, platform_family: 'debian' do |_node|
  Chef::Platform::ServiceHelpers.service_resource_providers.include?(:upstart) &&
    !Chef::Platform::ServiceHelpers.service_resource_providers.include?(:systemd)
end

default_action :start

action :start do
  service 'filebeat' do
    provider Chef::Provider::Service::Upstart
    supports status: true
    action [:enable, :start]
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
