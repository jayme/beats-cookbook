# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
include Beats::Helpers

resource_name :metricbeat
provides :metricbeat
default_action :create

property :beat, String, default: 'metricbeat'

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
    install = beats_install(new_resource.name, &block)
    copy_properties_to(install)
    configure = configure(new_resource.name, &block)
    copy_properties_to(configure)
    install
    configure
  end

  def svc_manager(&block)
    svc = beats_service_manager(new_resource.beat, &block)
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
