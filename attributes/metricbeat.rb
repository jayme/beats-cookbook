# metricbeat configurations
default['beats']['metricbeat']['conf_dir'] = '/etc/metricbeat'
default['beats']['metricbeat']['conf_file'] = ::File.join(node['beats']['metricbeat']['conf_dir'], 'metricbeat.yml')

default['beats']['metricbeat']['config']['name'] = node['fqdn']
default['beats']['metricbeat']['config']['metricbeat.modules'] = [
  {
    'module'     => 'system',
    'metricsets' => %w[cpu load filesystem fsstat memory network process],
    'enabled'    => 'true',
    'period'     => '10s',
    'processes'  => "['.*']",
  },
]

default['beats']['metricbeat']['config']['output.elasticsearch']['hosts'] = ['beats.localdomain']
default['beats']['metricbeat']['config']['output.elasticsearch']['template.overwrite'] = 'false'
