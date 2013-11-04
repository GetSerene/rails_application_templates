### Prerequisites
* postgres
  * should be running
  * psql from the commandline should just work (using your username from whoami)
  * otherwise you'll have to update the pg recipe to have the correct username and password for your postgres

Here is a recipe we use when starting a new SereneMachine project:
````
mkdir -p ~/Code/SereneMachine
cd ~/Code/SereneMachine
git clone https://github.com/SereneMachine/rails_application_templates.git # or if you've forked the rails_application_templates repo ... the url of your fork
rails -v # should return Rails 4.0.x ... although this recipe works for rails 3.2.x as well (just be sure to use the strong_paramaters step)
ruby -v  # should return ruby 2.0.x ... although this recipe works for ruby 1.9.3 as well
rails new PROJECTNAME --skip-bundle --database=postgresql --skip-test-unit
cd PROJECTNAME
rake rails:template LOCATION=~/Code/SereneMachine/rails_application_templates/ruby-version_and_gemset.rb;
cd ..; cd - # you are using rbenv or rvm right?
bundle install
rake rails:template LOCATION=~/Code/SereneMachine/rails_application_templates/vanilla_rails.rb
rake rails:template LOCATION=~/Code/SereneMachine/rails_application_templates/pg.rb
rake rails:template LOCATION=~/Code/SereneMachine/rails_application_templates/rspec-rails.rb
rake rails:template LOCATION=~/Code/SereneMachine/rails_application_templates/haml-rails.rb
rake rails:template LOCATION=~/Code/SereneMachine/rails_application_templates/strong_parameters.rb # only needed for rails 3
rake rails:template LOCATION=~/Code/SereneMachine/rails_application_templates/newrelic_rpm.rb
rake rails:template LOCATION=~/Code/SereneMachine/rails_application_templates/timecop.rb
rake rails:template LOCATION=~/Code/SereneMachine/rails_application_templates/fabrication.rb
rake rails:template LOCATION=~/Code/SereneMachine/rails_application_templates/rails-footnotes.rb
rake rails:template LOCATION=~/Code/SereneMachine/rails_application_templates/debugger.rb
rake rails:template LOCATION=~/Code/SereneMachine/rails_application_templates/ruby-version-in-gemfile.rb
rake rails:template LOCATION=~/Code/SereneMachine/rails_application_templates/unicorn.rb
rake rails:template LOCATION=~/Code/SereneMachine/rails_application_templates/procfile.rb
rake rails:template LOCATION=~/Code/SereneMachine/rails_application_templates/heroku.rb
rake rails:template LOCATION=~/Code/SereneMachine/rails_application_templates/devise-for-user.rb
````