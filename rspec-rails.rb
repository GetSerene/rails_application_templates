# rspec-rails
require File.expand_path('../lib/gem_install_bundle_and_commit', __FILE__)

gem_install_bundle_and_commit 'rspec-rails', :group => [:development, :test]

generate 'rspec:install'
git add: "."
git commit: %Q{ -m 'generate rspec:install' }

