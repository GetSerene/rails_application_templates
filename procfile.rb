create_file 'Procfile', <<-HERE
web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
HERE

git add: "Procfile"
git commit: %Q{ -m 'Procfile that starts unicorn' }
