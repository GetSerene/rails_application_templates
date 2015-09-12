# puma
require File.expand_path('../lib/gem_install_bundle_and_commit', __FILE__)

gem_install_bundle_and_commit 'puma'

create_file 'config/puma.rb', <<-HERE
# config/puma.rb
workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
HERE

git add: "config/puma.rb"
git commit: %Q{ -m 'configure puma' }
