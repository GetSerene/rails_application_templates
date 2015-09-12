version = "2.2.3"
run "rbenv local #{version}"
# create_file '.ruby-version', "#{version}"

git add: '.ruby-version'
git commit: %Q{ -m '.ruby-version via `rbenv local #{version}`' }
