require File.expand_path('../lib/gem_install_bundle_and_commit', __FILE__)

gem_install_bundle_and_commit 'rails_12factor', :groups => [:production]
gem_install_bundle_and_commit 'rails_serve_static_assets'
