# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
include Beats::Helpers

resource_name :metricbeat_configure
provides :metricbeat_configure
default_action :configure

property :metricbeat_config_file, String, default: lazy { node['beats']['metricbeat']['conf_file'] }
property :metricbeat_config, Hash, default: lazy { node['beats']['metricbeat']['config'] }

action :configure do
  require 'yaml'
  template new_resource.metricbeat_config_file.to_s do
    mode   0o644
    cookbook 'beats'
    variables content: JSON.parse(new_resource.metricbeat_config.to_json).to_yaml
    source 'beats.yml.erb'
  end
end
