Here is a decent recipe:
````
rails new PROJECTNAME --skip-bundle
cd PROJECTNAME
rake rails:template LOCATION=~/Code/Trust40/rails_application_templates/vanilla_rails.rb
rake rails:template LOCATION=~/Code/Trust40/rails_application_templates/ruby_version_and_gemset.rb
cd ..
cd - 
rake rails:template LOCATION=~/Code/Trust40/rails_application_templates/pg.rb
rake rails:template LOCATION=~/Code/Trust40/rails_application_templates/rspec-rails.rb
rake rails:template LOCATION=~/Code/Trust40/rails_application_templates/haml-rails.rb
rake rails:template LOCATION=~/Code/Trust40/rails_application_templates/strong_parameters.rb
````