# filebeat configurations
default['beats']['filebeat']['conf_dir'] = '/etc/filebeat'
default['beats']['filebeat']['conf_file'] = ::File.join(node['beats']['filebeat']['conf_dir'], 'filebeat.yml')

default['beats']['filebeat']['config']['name'] = node['fqdn']

default['beats']['filebeat']['config']['filebeat.config.modules']['enabled'] = true
default['beats']['filebeat']['config']['filebeat.config.modules']['path'] = '${path.config}/modules.d/*.yml'

# default['beats']['filebeat']['modules']['path'] = node['beats']['filebeat']['conf_dir'] + '/modules.d'
default['beats']['filebeat']['modules']['path'] = "#{node['beats']['filebeat']['conf_dir']}/modules.d"
default['beats']['filebeat']['modules']['default']['config'] = [
  {
    'module' => 'system',
    'syslog' => {
      'enabled' => true,
    },
  },
  {
    'module' => 'system',
    'auth'   => {
      'enabled' => true,
    },
  },
]

default['beats']['filebeat']['config']['output.elasticsearch']['hosts'] = ['beats.localdomain']
default['beats']['filebeat']['config']['output.elasticsearch']['template.overwrite'] = 'false'
