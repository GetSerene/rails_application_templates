# mysql
require File.expand_path('../lib/gem_install_bundle_and_commit', __FILE__)

gem_install_bundle_and_commit 'mysql2'

remove_file 'config/database.default.yml'
create_file 'config/database.default.yml', <<-CONFIG
default: &default
  adapter:  mysql2
  encoding: utf8
  pool:     5
  username: root
  password:
  socket:   /tmp/mysql.sock

development:
  <<: *default
  database: #{app_name}_development

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  <<: *default
  database: #{app_name}_test
CONFIG

git add: "."
git rm: "config/database.yml"
git commit: %Q{ -m 'rm database.yml, create database.default.yml for pg' }

unless IO.read('.gitignore').match /database.yml/
  append_file '.gitignore', 'config/database.yml'
  git add: "."
  git commit: %Q{ -m 'ignore database.yml' }
end

if yes? 'link database.yml to database.default.yml?'

  `ln -fs database.default.yml config/database.yml`

  if yes? 'create all the databases?'
    run 'rake db:create:all'
  end
end
