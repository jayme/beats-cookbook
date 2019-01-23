name 'beats'
maintainer 'jp@noemail'
maintainer_email 'jp@noemail'
license 'GPL-3.0'
description 'Installs/Configures beats'
long_description 'Installs/Configures beats'
version '1.0.4'
chef_version '>= 12.1' if respond_to?(:chef_version)

%w[ubuntu].each do |os|
  supports os
end

issues_url 'https://github.com/jayme/beats-cookbook/issues'
source_url 'https://github.com/jayme/beats-cookbook'
