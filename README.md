### Prerequisites
* git
* ruby 2.2.x (via rbenv)
* rails 4.2.x
* postgres
  * should be running
  * psql from the commandline should just work (using your username from whoami)
    * If you get `psql: FATAL: database “<user>” does not exist` don't forget to issue a `createdb` command
  * otherwise you'll have to update the pg recipe to have the correct username and password for your postgres

Here is a recipe we use when starting a new GetSerene rails project:
````
mkdir -p ~/Code/GetSerene
cd ~/Code/GetSerene
git clone https://github.com/GetSerene/rails_application_templates.git # or if you've forked the rails_application_templates repo ... the url of your fork
export RAILS_TEMPLATES_ROOT=~/Code/GetSerene/rails_application_templates
ruby -v  # should return ruby 2.2.x ... although this recipe may work for rubies as early as 1.9.3 as well
rails -v # should return Rails 4.2.x ... although this recipe may work for rails 3.2.x as well (just be sure to use the strong_paramaters step)
# you may need to run rbenv rehash if you've installed rails but are still getting 'Rails is not currently installed'
bundle -v # should return bundler 1.10.x
rails new PROJECTNAME --skip-bundle --database=postgresql --skip-test-unit
cd PROJECTNAME
git init .
bundle install
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/vanilla_rails.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/ruby-version-rbenv.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/ruby-version-in-gemfile.rb"
cd ..; cd - # definitely works for rvm ... not sure about rbenv
# clean up the Gemfile by hand
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/pry-rails.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/pg.rb"      # or use mysql2 on the next line
# link database.yml to database.default.yml? y
# create all the databases? y
bin/rails server # you should see the Rails Welcome page ... before you should get ActiveRecord errors because you don't have any dbs
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/mysql2.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/rspec-rails.rb" # /bin/rake should run your specs (0 examples, 0 failures)
# rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/guard-rails.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/spring-binstubs.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/haml-rails.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/strong_parameters.rb # only needed for rails 3"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/newrelic_rpm.rb"
# sign in to your newrelic account and from account settings
# download a clean newrelic.yml configuration file and save it in config/
bin/rails server
open http://localhost:3000/newrelic # in a different terminal
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/timecop.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/faker.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/fabrication.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/annotate.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/rails-footnotes.rb"
# rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/byebug.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/decent_exposure.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/decent-generators.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/puma.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/puma-procfile.rb"
# rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/unicorn.rb"
# rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/procfile.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/dotenv.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/heroku.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/dev-url-options.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/home-index.rb"
# rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/explicit-root-route.rb"
# need to ensure flash messages are set up
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/devise-for-user.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/devise-invitable-for-user.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/bootstrap-sass.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/html2haml.rb"
for file in app/views/devise/**/*.erb; do bundle exec html2haml -e $file ${file%erb}haml && rm $file; done
git add app/views/devise/
git commit -m 'devise views from erb to haml'
for file in app/views/layouts/*.erb; do bundle exec html2haml -e $file ${file%erb}haml && rm $file; done
git add app/views/layouts
git commit -m 'layout views from erb to haml'
````

Here is a recipe we use when starting a new GetSerene rails-api project:
````
mkdir -p ~/Code/GetSerene
cd ~/Code/GetSerene
git clone https://github.com/GetSerene/rails_application_templates.git # or if you've forked the rails_application_templates repo ... the url of your fork
export RAILS_TEMPLATES_ROOT=~/Code/GetSerene/rails_application_templates
ruby -v  # should return ruby 2.2.x
rails -v # should return Rails 4.2.x ... although this recipe may work for rails 3.2.x as well (just be sure to use the strong_paramaters step)
bundle -v # should return bundler 1.9.x
rails new PROJECTNAME --api --skip-bundle --database=postgresql --skip-test-unit
cd PROJECTNAME
rvm use 2.2.1
bundle install
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/vanilla_rails_api.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/ruby-version-in-gemfile.rb"
# clean up the Gemfile by hand
# rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/pry-rails.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/pg.rb"  # probably just answer yes to link database.yml and create tables
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/rspec-rails.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/newrelic_rpm.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/timecop.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/fabrication.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/byebug.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/unicorn.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/procfile.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/heroku.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/decent_exposure.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/devise-for-user.rb" # probably want to replace this with the id OAUTH provisioner and token authentication
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/devise-invitable-for-user.rb"
````
