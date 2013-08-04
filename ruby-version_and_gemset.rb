create_file '.ruby-version', "ruby-2.0.0-p247"
create_file '.ruby-gemset', app_name

git :init
git add: '.ruby-version'
git add: '.ruby-gemset'
git commit: %Q{ -m '.ruby_version and .ruby_gemset' }
