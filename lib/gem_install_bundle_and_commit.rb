require 'bundler'
require File.expand_path('../gemfile_sort', __FILE__)

def gem_install_bundle_and_commit(*args)
  gem(*args)
  sort_and_save_gemfile
  Bundler.with_clean_env do
    run 'bundle install'
  end

  git add: "Gemfile"
  git add: "Gemfile.lock"
  git commit: %Q{ -m 'install #{args.first}' }
end
