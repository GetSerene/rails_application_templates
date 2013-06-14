create_file '.ruby-version', "ruby-1.9.3-p429"
create_file '.ruby-gemset', app_name

git :init
git add: '.ruby-version'
git add: '.ruby-gemset'
git commit: %Q{ -m '.ruby_version and .ruby_gemset' }

run 'cd ..; cd -; bundle install'
