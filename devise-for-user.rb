require File.expand_path('../lib/gem_install_bundle_and_commit', __FILE__)

gem_install_bundle_and_commit 'devise'

generate 'devise:install'
git add: 'config/initializers/devise.rb'
git add: 'config/locales/devise.en.yml'
git commit: %Q{ -m 'rails generate devise:install' }

generate 'devise User'
git add: 'config/routes.rb'
git add: 'app/models/user.rb'
git add: 'db/migrate/*devise_create_users.rb'
git add: 'spec/models/user_spec.rb'
git commit: %Q{ -m 'rails generate devise User' }

rake 'db:migrate'
git add: 'db/schema.rb'
git commit: %Q{ -m 'rake db:migrate for devise migration' }
