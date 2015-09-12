create_file 'Procfile', <<-HERE
web: bundle exec puma -C config/puma.rb
HERE

git add: "Procfile"
git commit: %Q{ -m 'Procfile that starts puma' }
