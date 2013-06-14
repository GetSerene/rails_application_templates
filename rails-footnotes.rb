require File.expand_path('../gem_install_bundle_and_commit', __FILE__)

gem_install_bundle_and_commit 'rails-footnotes', '>= 3.7.9', :group => :development

generate 'rails_footnotes:install'
git add: '.rails_footnotes'
git add: 'config/initializers/rails_footnotes.rb'
git commit: %Q{ -m 'rails generate rails_footnotes:install' }