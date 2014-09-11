# doorkeeper
require File.expand_path('../lib/gem_install_bundle_and_commit', __FILE__)

gem_install_bundle_and_commit 'doorkeeper'

generate 'doorkeeper:install'
git add: "."
git commit: %Q{ -m 'generate doorkeeper:install' }

generate 'doorkeeper:migration'
git add: "."
git commit: %Q{ -m 'generate doorkeeper:migration' }

rake 'db:migrate'
git add: "."
git commit: %Q{ -m 'rake db:migrate' }

rake 'db:migrate', env: :test