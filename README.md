Here is a decent recipe:
````
rails new PROJECTNAME
cd PROJECTNAME
rake rails:template LOCATION=~/Code/rails_application_templates/vanilla_rails.rb
rake rails:template LOCATION=~/Code/rails_application_templates/pg.rb
rake rails:template LOCATION=~/Code/rails_application_templates/rspec-rails.rb
rake rails:template LOCATION=~/Code/rails_application_templates/haml-rails.rb
rake rails:template LOCATION=~/Code/rails_application_templates/strong_parameters.rb
````