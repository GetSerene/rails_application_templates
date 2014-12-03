### Prerequisites
* git
* ruby 2.1.x (preferably via rbenv or rvm)
* rails 4.2.x
* postgres
  * should be running
  * psql from the commandline should just work (using your username from whoami)
  * otherwise you'll have to update the pg recipe to have the correct username and password for your postgres

Here is a recipe we use when starting a new GetSerene rails project:
````
mkdir -p ~/Code/GetSerene
cd ~/Code/GetSerene
git clone https://github.com/GetSerene/rails_application_templates.git # or if you've forked the rails_application_templates repo ... the url of your fork
export RAILS_TEMPLATES_ROOT=~/Code/GetSerene/rails_application_templates
rails -v # should return Rails 4.2.x ... although this recipe may work for rails 3.2.x as well (just be sure to use the strong_paramaters step)
ruby -v  # should return ruby 2.1.x ... although this recipe may work for ruby 1.9.3 as well
rails new PROJECTNAME --skip-bundle --database=postgresql --skip-test-unit
cd PROJECTNAME
rvm use 2.1.2
bundle install
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/vanilla_rails.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/ruby-version-in-gemfile.rb"
cd ..; cd - # definitely works for rvm ... not sure about rbenv
# clean up the Gemfile by hand
# rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/pry-rails.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/pg.rb"      # or use mysql2 on the next line
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/mysql2.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/rspec-rails.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/haml-rails.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/strong_parameters.rb # only needed for rails 3"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/newrelic_rpm.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/timecop.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/faker.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/fabrication.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/annotate.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/rails-footnotes.rb"
# rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/byebug.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/decent_exposure.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/unicorn.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/procfile.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/dotenv.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/heroku.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/devise-for-user.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/devise-invitable-for-user.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/bootstrap-sass.rb"
````

Here is a recipe we use when starting a new GetSerene rails-api project:
````
mkdir -p ~/Code/GetSerene/serene
cd ~/Code/GetSerene/serene
git clone https://github.com/GetSerene/rails_application_templates.git # or if you've forked the rails_application_templates repo ... the url of your fork
export RAILS_TEMPLATES_ROOT=~/Code/GetSerene/serene/rails_application_templates
rails-api -v # should return Rails 4.2.x ... although this recipe works for rails 3.2.x as well (just be sure to use the strong_paramaters step)
ruby -v  # should return ruby 2.1.x ... although this recipe works for ruby 1.9.3 as well
bundle -v # should return bundler 1.6.x
rails-api new PROJECTNAME --skip-bundle --database=postgresql --skip-test-unit
cd PROJECTNAME
rvm use 2.1.2
bundle install
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/vanilla_rails_api.rb"
# clean up the Gemfile by hand
# rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/pry-rails.rb"
rake rails:template LOCATION="$RAILS_TEMPLATES_ROOT/pg.rb"
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