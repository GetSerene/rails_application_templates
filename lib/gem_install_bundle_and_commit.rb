require 'bundler'

def gem_install_bundle_and_commit(*args)
  gem(*args)
  Bundler.with_clean_env do
    run 'bundle install'
  end

  git add: "Gemfile"
  git add: "Gemfile.lock"
  git commit: %Q{ -m 'install #{args.first}' }
end
