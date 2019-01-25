# metricbeat configurations
default['beats']['metricbeat']['conf_dir'] = '/etc/metricbeat'
default['beats']['metricbeat']['conf_file'] = ::File.join(node['beats']['metricbeat']['conf_dir'], 'metricbeat.yml')

default['beats']['metricbeat']['config']['name'] = node['fqdn']

default['beats']['metricbeat']['config']['metricbeat.config.modules']['path'] = '${path.config}/conf.d/*.yml'
default['beats']['metricbeat']['config']['metricbeat.config.modules']['reload.enabled'] = 'false'

default['beats']['metricbeat']['config']['output.elasticsearch']['hosts'] = ['beats.localdomain']
default['beats']['metricbeat']['config']['output.elasticsearch']['template.overwrite'] = 'false'
