require 'bundler'
require File.expand_path('../gemfile_sort', __FILE__)

def gem_in_lines?(*args, lines)
  gemname = args.first.gsub(/['"]/, '')
  return lines.find_index{|line| line.include? gemname}
end

def gem_installed?(*args)
  gem_in_lines?(*args, IO.readlines('Gemfile')) &&
  gem_in_lines?(*args, IO.readlines('Gemfile.lock'))
end

def gem_install_bundle_and_commit(*args)
  return if gem_installed?(*args)
  gem(*args)
  sort_and_save_gemfile
  Bundler.with_clean_env do
    run 'bundle install'
  end

  git add: "Gemfile"
  git add: "Gemfile.lock"
  git commit: %Q{ -m 'install #{args.first}' }
end
