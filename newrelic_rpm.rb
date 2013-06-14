gem 'newrelic_rpm'
require 'bundler'
Bundler.with_clean_env do
  run 'bundle install'
end

git add: "."
git commit: %Q{ -m 'install newrelic_rpm' }
