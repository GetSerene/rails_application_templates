Here is a decent recipe:
````
rails new PROJECTNAME --skip-bundle
cd PROJECTNAME
rake rails:template LOCATION=~/Code/Trust40/rails_application_templates/ruby-version_and_gemset.rb; cd ..; cd -
rake rails:template LOCATION=~/Code/Trust40/rails_application_templates/vanilla_rails.rb
rake rails:template LOCATION=~/Code/Trust40/rails_application_templates/pg.rb
rake rails:template LOCATION=~/Code/Trust40/rails_application_templates/rspec-rails.rb
rake rails:template LOCATION=~/Code/Trust40/rails_application_templates/haml-rails.rb
rake rails:template LOCATION=~/Code/Trust40/rails_application_templates/strong_parameters.rb
rake rails:template LOCATION=~/Code/Trust40/rails_application_templates/newrelic_rpm.rb
rake rails:template LOCATION=~/Code/Trust40/rails_application_templates/timecop.rb
rake rails:template LOCATION=~/Code/Trust40/rails_application_templates/fabrication.rb
rake rails:template LOCATION=~/Code/Trust40/rails_application_templates/rails-footnotes.rb
rake rails:template LOCATION=~/Code/Trust40/rails_application_templates/devise-for-user.rb
````