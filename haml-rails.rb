# haml
require File.expand_path('../lib/gem_install_bundle_and_commit', __FILE__)

gem_install_bundle_and_commit 'haml-rails', '>= 0.5.3'

inject_into_file "config/environments/development.rb", <<-HERE
  config.generators do |g|
    g.template_engine :haml
  end
HERE , before: 'end'
