actions :install, :update
default_action :install

attribute :app_id, name_attribute: true, kind_of: String, required: true

attribute :path, kind_of: String, required: true
attribute :beta, kind_of: String, required: false, default: nil

attr_accessor :exists
