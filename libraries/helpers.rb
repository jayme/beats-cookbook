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
        property :beat_user, String, default: 'beats'
        property :beat_group, String, default: 'beats'
        property :beat, String, default: 'filebeat'
      end
    end
  end
end
