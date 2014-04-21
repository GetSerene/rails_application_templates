require File.expand_path('../lib/gem_install_bundle_and_commit', __FILE__)

gem_install_bundle_and_commit 'devise_invitable'

generate 'devise_invitable:install'
git add: 'config/initializers/devise.rb'
git add: 'config/locales/devise_invitable.en.yml'
git commit: %Q{ -m 'rails generate devise_invitable:install' }

generate 'devise_invitable User'
git add: 'app/models/user.rb'
git add: 'db/migrate/*devise_invitable_add_to_users.rb'
git commit: %Q{ -m 'rails generate devise_invitable User' }

rake 'db:migrate'
run 'bundle exec annotate'
git add: 'db/schema.rb'
git add: 'app/models/user.rb'
git add: 'spec/fabricators/user_fabricator.rb'
git add: 'spec/models/user_spec.rb'
git commit: %Q{ -m 'rake db:migrate for devise-for-user migration' }
