# haml
gem 'haml-rails', '>= 0.3.4', :group => :development
require 'bundler'
Bundler.with_clean_env do
  run 'bundle install'
end

git add: "."
git commit: %Q{ -m 'install haml' }
