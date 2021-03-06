name 'beats'
maintainer 'jp@noemail'
maintainer_email 'jp@noemail'
license 'GPL-3.0'
description 'Installs/Configures beats'
long_description 'Installs/Configures beats'
version '1.1.3'
chef_version '< 13' if respond_to?(:chef_version)

%w[ubuntu centos freebsd].each do |os|
  supports os
end

issues_url 'https://github.com/jayme/beats-cookbook/issues'
source_url 'https://github.com/jayme/beats-cookbook'
