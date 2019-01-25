# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
include Beats::Helpers

resource_name :packetbeat_configure
provides :packetbeat_configure
default_action :configure

property :packetbeat_config_file, String, default: lazy { node['beats']['packetbeat']['conf_file'] }
property :packetbeat_config, Hash, default: lazy { node['beats']['packetbeat']['config'] }

action :configure do
  require 'yaml'
    template new_resource.packetbeat_config_file.to_s do
      mode   0o644
      cookbook 'beats'
      variables content: JSON.parse(new_resource.packetbeat_config.to_json).to_yaml
      source 'beats.yml.erb'
  end
end
