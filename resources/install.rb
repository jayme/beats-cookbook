# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
include Beats::Helpers

resource_name :beats_install
provides :beats_install
default_action :install

property :version, String, default: '6.5.4'
property :apt_repo, String, default: 'https://artifacts.elastic.co/packages/6.x/apt'
property :apt_repo_key, String, default: 'https://packages.elastic.co/GPG-KEY-elasticsearch'

action :install do
  case node['platform_family']

  when 'rhel'
    yum_repository 'beats' do
      description 'elasticsearch beats'
      baseurl 'https://artifacts.elastic.co/packages/6.x/yum'
      gpgkey 'https://packages.elastic.co/GPG-KEY-elasticsearch'
      action :create
    end

  when 'debian'
    package 'apt-transport-https'

    apt_repository 'beats' do
      uri new_resource.apt_repo
      distribution ''
      components %w[stable main]
      key new_resource.apt_repo_key.to_s
    end

    apt_update 'beats'

  end 

  if new_resource.filebeat
    package 'filebeat'
  end

  if new_resource.metricbeat
    package 'metricbeat'
  end

  if new_resource.packetbeat
    package 'packetbeat'
  end

end
