# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
include Beats::Helpers

resource_name :filebeat_install
provides :filebeat_install
default_action :install

property :version, String, default: '6.5.4'
property :apt_repo, String, default: 'https://artifacts.elastic.co/packages/6.x/apt'
property :apt_repo_key, String, default: 'https://packages.elastic.co/GPG-KEY-elasticsearch'
property :yum_repo, String, default: 'https://artifacts.elastic.co/packages/6.x/yum'
property :yum_repo_key, String, default: 'https://packages.elastic.co/GPG-KEY-elasticsearch'

action :install do
  case node['platform_family']

  when 'rhel'
    yum_repository 'beats' do
      description 'elasticsearch'
      baseurl new_resource.yum_repo
      gpgkey new_resource.yum_repo_key
      action :create
    end

  when 'debian'
    package 'apt-transport-https'

    apt_repository 'elasticsearch' do
      uri new_resource.apt_repo
      distribution ''
      components %w[stable main]
      key new_resource.apt_repo_key.to_s
    end

    apt_update 'beats'

  end

  package 'filebeat'
end
