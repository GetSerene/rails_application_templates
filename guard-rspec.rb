require File.expand_path('../lib/gem_install_bundle_and_commit', __FILE__)

# crashes when require: :false
# gem_install_bundle_and_commit 'guard-rspec', group: :development, require: :false
gem_install_bundle_and_commit 'guard-rspec', group: :development

run 'bundle exec guard init rspec'
git add: 'Guardfile'
git commit: %Q{-m 'guard init rspec'}

gsub_file 'Guardfile', 
  /guard :rspec, cmd: "bundle exec rspec" do/,
  'guard :rspec, cmd: "bin/rspec" do'
git add: 'Guardfile'
git commit: %Q{-m 'guard rspec use binstub'}
