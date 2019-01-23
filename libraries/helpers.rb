#
# Chef Documentation
# https://docs.chef.io/libraries.html
#
#
module Beats
  module Helpers
    def self.included(base)
      base.class_eval do
        property :instance, String, name_property: true
        property :username, String, default: 'beats'
        property :groupname, String, default: 'beats'
        property :filebeat, [true, false], default: true
        property :metricbeat, [true, false], default: true
        property :packetbeat, [true, false], default: true
      end
    end
  end
end
