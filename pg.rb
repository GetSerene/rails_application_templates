# postgresql
gem 'pg'
run 'bundle install'

git add: "."
git commit: %Q{ -m 'install pg' }

remove_file 'config/database.yml'
create_file 'config/database.yml', <<-CONFIG
development:
  adapter: postgresql
  encoding: unicode
  database: #{app_name}_development
  pool: 5
  username: #{`whoami`}
  password:

test:
  adapter: postgresql
  encoding: unicode
  database: #{app_name}_test
  pool: 5
  username: #{`whoami`}
  password:
CONFIG

git add: "."
git commit: %Q{ -m 'create default database.yml for pg' }

run 'rake db:create:all'