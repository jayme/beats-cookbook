# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
include Beats::Helpers

resource_name :beats
provides :beats
default_action :create

def copy_properties_to(to, *properties)
  properties = self.class.properties.keys if properties.empty?
  properties.each do |p|
    if to.class.properties.include?(p) && property_is_set?(p)
      to.send(p, send(p))
    end
  end
end

action_class do
  def init(&block)
    configure = beats_configure(new_resource.name, &block)
    copy_properties_to(configure)
    install = beats_install(new_resource.name, &block)
    copy_properties_to(install)
    configure
    install
  end

  def svc_manager(&block)
    case node['platform_family']
    when 'freebsd'
      chef_gem 'chef-gems' do
        package_name 'chef-provider-service-daemontools'
        action :install
      end
      svc = service_daemontools(new_resource.name, &block)
    when 'debian', 'rhel'
      svc = service_manager(new_resource.name, &block)
    end
    copy_properties_to(svc)
    svc
  end
end

action :create do
  init
  svc_manager do
    action :start
  end
end

action :delete do
  svc_manager do
    action :stop
  end
end