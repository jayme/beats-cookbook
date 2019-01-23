# packetbeat configurations

default['beats']['packetbeat']['conf_dir'] = '/etc/packetbeat'
default['beats']['packetbeat']['conf_file'] = ::File.join(node['beats']['packetbeat']['conf_dir'], 'packetbeat.yml')

default['beats']['packetbeat']['config']['name'] = node['fqdn']
default['beats']['packetbeat']['config']['packetbeat.interfaces.device'] = 'any'

default['beats']['packetbeat']['config']['packetbeat.protocols.dns']['ports'] = %w[53]

default['beats']['packetbeat']['config']['packetbeat.protocols.icmp']['enabled'] = true

default['beats']['packetbeat']['config']['packetbeat.protocols.http']['ports'] = %w[80 8080 8000 5000 8002]
default['beats']['packetbeat']['config']['packetbeat.protocols.http']['send_headers'] = %w[User-Agent Cookie Set-Cookie]
default['beats']['packetbeat']['config']['packetbeat.protocols.http']['real_ip_header'] = 'X-Forwarded-For'

default['beats']['packetbeat']['config']['packetbeat.protocols.mysql']['ports'] = %w[3306]
# default['beats']['packetbeat']['config']['packetbeat.protocols.redis']['ports'] = %w(6379)
# default['beats']['packetbeat']['config']['packetbeat.protocols.psql']['ports'] = %w(5432)

# default['beats']['packetbeat']['config']['packetbeat.protocols.memcache']['ports'] = %w(11211)

# default['beats']['packetbeat']['config']['packetbeat.protocols.mongo']['ports'] = %w(27017)
# default['beats']['packetbeat']['config']['packetbeat.protocols.mongo']['max_docs'] = 10
# default['beats']['packetbeat']['config']['packetbeat.protocols.mongo']['max_doc_length'] = 5000
# default['beats']['packetbeat']['config']['packetbeat.protocols.mongo']['send_request'] = false
# default['beats']['packetbeat']['config']['packetbeat.protocols.mongo']['send_response'] = false

hosts = default['beats']['config']['output.elasticsearch']['hosts']
default['beats']['packetbeat']['config']['output.elasticsearch']['hosts'] = hosts
default['beats']['packetbeat']['config']['output.elasticsearch']['template.overwrite'] = 'false'
