require File.expand_path('../lib/gem_install_bundle_and_commit', __FILE__)

# gem_install_bundle_and_commit 'guard', group: :development, require: :false
gem_install_bundle_and_commit 'guard-rails', group: :development, require: :false
# gem_install_bundle_and_commit 'guard-rspec', group: :development, require: :false

run 'bundle exec guard init rails'
git add: 'Guardfile'
git commit: %Q{-m 'guard init rails'}