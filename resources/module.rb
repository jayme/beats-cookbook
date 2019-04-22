resource_name :beat_module
provides :beat_module
default_action :configure

base_config = '/etc'
case node['platform']
when 'freebsd'
  base_config = '/usr/local/etc/beats'
end
property :beat, String, default: 'filebeat'
property :beat_module, String, default: 'default'
property :beat_module_config, Array, default: lazy { node['beats'][beat.to_s]['modules'][beat_module.to_s]['config'] }
property :beat_path, String, default: lazy { "/usr/share/#{beat}" }
property :beat_config_path, String, default: lazy { "#{base_config}/#{beat}" }
property :beat_data_path, String, default: lazy { "/var/lib/#{beat}" }
property :beat_log_path, String, default: lazy { "/var/log/#{beat}" }

action :configure do
  require 'yaml'

  directory "#{beat_config_path}/modules.d/"

  template new_resource.beat_module.to_s do
    mode   0o644
    cookbook 'beats'
    variables content: JSON.parse(beat_module_config.to_json).to_yaml
    source 'beats.yml.erb'
    path "#{beat_config_path}/modules.d/#{beat_module}.yml"
  end
end
