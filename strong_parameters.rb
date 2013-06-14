# strong_parameters
require File.expand_path('../gem_install_bundle_and_commit', __FILE__)

gem_install_bundle_and_commit 'strong_parameters'


initializer 'strong_parameters.rb', 'ActiveRecord::Base.send(:include, ActiveModel::ForbiddenAttributesProtection)'
git add: "."
git commit: %Q{ -m 'activate strong_parameters on all ActiveRecord models' }


gsub_file 'config/application.rb', /config.active_record.whitelist_attributes = true/, 'config.active_record.whitelist_attributes = false'
git add: "."
git commit: %Q{ -m 'disable the default rails 3.2 whitelisting of parameters' }
