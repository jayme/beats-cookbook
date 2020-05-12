resource_name :beats_service_manager_systemd

provides :beats_service_manager, os: 'linux' do |_node|
  Chef::Platform::ServiceHelpers.service_resource_providers.include?(:systemd)
end

default_action :start

action :start do
  service new_resource.beat.to_s do
    provider Chef::Provider::Service::Systemd
    supports status: true
    action [:start]
  end
end

action :stop do
  service new_resource.beat.to_s do
    provider Chef::Provider::Service::Systemd
    supports status: true
    action [:stop]
  end
end

action :restart do
  action_stop
  action_start
  subscribes :reload, "template[#{new_resource.beat_config_path}/#{new_resource.beat}.yml]", :immediately
end
