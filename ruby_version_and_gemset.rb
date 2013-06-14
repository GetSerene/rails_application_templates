create_file '.ruby_version', "1.9.3-p429"
create_file '.ruby_gemset', app_name

git add: '.ruby_version'
git add: '.ruby_gemset'
git commit: %Q{ -m '.ruby_version and .ruby_gemset' }
