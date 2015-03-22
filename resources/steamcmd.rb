actions :install, :update
default_action :install

attribute :app_id, name_attribute: true, kind_of: Fixnum, required: true

attribute :path, kind_of: String, required: true
attribute :beta, kind_of: String
# attribute :validate, kind_of: [ TrueClass, FalseClass ], default: true

attr_accessor :exists
