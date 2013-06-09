# rspec-rails
gem 'rspec-rails', '~> 2.0', :group => [:development, :test]
run 'bundle install'

git add: "."
git commit: %Q{ -m 'install rspec-rails' }

generate 'rspec:install'
git add: "."
git commit: %Q{ -m 'generate rspec:install' }

