# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
include Beats::Helpers

resource_name :beats_configure
provides :beats_configure
default_action :configure

property :filebeat_config_file, String, default: lazy { node['beats']['filebeat']['conf_file'] }
property :filebeat_config, Hash, default: lazy { node['beats']['filebeat']['config'] }
property :metricbeat_config_file, String, default: lazy { node['beats']['metricbeat']['conf_file'] }
property :metricbeat_config, Hash, default: lazy { node['beats']['metricbeat']['config'] }
property :packetbeat_config_file, String, default: lazy { node['beats']['packetbeat']['conf_file'] }
property :packetbeat_config, Hash, default: lazy { node['beats']['packetbeat']['config'] }

action :configure do
  require 'yaml'

  if new_resource.filebeat
    template new_resource.filebeat_config_file.to_s do
      mode   0o644
      cookbook 'beats'
      variables content: JSON.parse(new_resource.filebeat_config.to_json).to_yaml
      source 'beats.yml.erb'
    end
  end

  if new_resource.metricbeat
    template new_resource.metricbeat_config_file.to_s do
      mode   0o644
      cookbook 'beats'
      variables content: JSON.parse(new_resource.metricbeat_config.to_json).to_yaml
      source 'beats.yml.erb'
    end
  end

  if new_resource.packetbeat
    template new_resource.packetbeat_config_file.to_s do
      mode   0o644
      cookbook 'beats'
      variables content: JSON.parse(new_resource.packetbeat_config.to_json).to_yaml
      source 'beats.yml.erb'
    end
  end

end
