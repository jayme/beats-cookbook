# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
include Beats::Helpers

resource_name :filebeat_configure
provides :filebeat_configure
default_action :configure

property :filebeat_config_file, String, default: lazy { node['beats']['filebeat']['conf_file'] }
property :filebeat_config, Hash, default: lazy { node['beats']['filebeat']['config'] }
property :filebeat_module, String, default: 'default'
property :filebeat_modules_path, String, default: lazy { node['beats']['filebeat']['modules']['path'] }
property :filebeat_modules_config, Array, default: lazy { node['beats']['filebeat']['modules']["#{filebeat_module}"]['config'] }

action :configure do
  require 'yaml'
  template new_resource.filebeat_config_file.to_s do
    mode   0o644
    cookbook 'beats'
    variables content: JSON.parse(new_resource.filebeat_config.to_json).to_yaml
    source 'beats.yml.erb'
  end
  template "#{new_resource.filebeat_module}" do
    mode   0o644
    cookbook 'beats'
    variables content: JSON.parse(new_resource.filebeat_modules_config.to_json).to_yaml
    source 'beats.yml.erb'
    path "#{new_resource.filebeat_modules_path}/#{new_resource.filebeat_module}.yml"
  end
end
