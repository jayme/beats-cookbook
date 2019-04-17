resource_name :configure
provides :configure
default_action :configure

base_config = '/etc'
case node['platform']
when 'freebsd'
  base_config = '/usr/local/etc/beats/'
end
property :config, Hash, default: lazy { node['beats']["#{new_resource.beat}"]['config'] }
property :beat_path, String, default: lazy { "/usr/share/#{new_resource.beat}" }
property :beat_config_path, String, default: lazy { "#{base_config}/#{new_resource.beat}" }
property :beat_data_path, String, default: lazy { "/var/lib/#{new_resource.beat}" }
property :beat_log_path, String, default: lazy { "/var/log/#{new_resource.beat}" }

action :configure do
  require 'yaml'
  template "#{new_resource.beat_config_path}/#{new_resource.beat}.yml" do
    mode   0o644
    cookbook 'beats'
    variables content: JSON.parse(new_resource.config.to_json).to_yaml
    source 'beats.yml.erb'
  end
end
