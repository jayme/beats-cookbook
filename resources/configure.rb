resource_name :configure
provides :configure
default_action :configure

base_etc = '/etc'
base_share = '/usr/share'
base_data = '/var/lib/'
base_log = '/var/log'
case node['platform']
when 'freebsd'
  base_prefix = '/usr/local'
  base_etc = "#{base_prefix}/etc/beats"
  base_share = "#{base_prefix}/share/beats"
  base_data = '/var/db/beats'
end
property :config, Hash, default: lazy { node['beats'][new_resource.beat.to_s]['config'] }
property :beat_path, String, default: lazy { "#{base_share}/#{new_resource.beat}" }
property :beat_config_path, String, default: lazy { "#{base_etc}/#{new_resource.beat}" }
property :beat_data_path, String, default: lazy { "#{base_data}/#{new_resource.beat}" }
property :beat_log_path, String, default: lazy { "#{base_log}/#{new_resource.beat}" }

action :configure do
  require 'yaml'
  # quick fix for beats-6.6.0 freebsd
  directory "#{new_resource.beat_config_path}/modules.d/" do
    recursive true
  end
  directory "#{new_resource.beat_path}" do
    recursive true
  end
  # 
  template "#{new_resource.beat_config_path}/#{new_resource.beat}.yml" do
    mode   0o644
    cookbook 'beats'
    variables content: JSON.parse(new_resource.config.to_json).to_yaml
    source 'beats.yml.erb'
  end
end
