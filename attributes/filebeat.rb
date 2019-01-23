# filebeat configurations
default['beats']['filebeat']['conf_dir'] = '/etc/filebeat'
default['beats']['filebeat']['conf_file'] = ::File.join(node['beats']['filebeat']['conf_dir'], 'filebeat.yml')

default['beats']['filebeat']['config']['name'] = node['fqdn']
default['beats']['filebeat']['config']['filebeat.modules'] = [
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
