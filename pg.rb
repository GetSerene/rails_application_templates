# postgresql
require File.expand_path('../lib/gem_install_bundle_and_commit', __FILE__)

gem_install_bundle_and_commit 'pg'

remove_file 'config/database.default.yml'
create_file 'config/database.default.yml', <<-CONFIG
development:
  adapter: postgresql
  encoding: unicode
  database: #{app_name}_development
  pool: 5
  username: <%= `whoami` %>
  password:

test:
  adapter: postgresql
  encoding: unicode
  database: #{app_name}_test
  pool: 5
  username: <%= `whoami` %>
  password:
  min_messages: WARNING
CONFIG

git add: "."
git rm: "config/database.yml"
git commit: %Q{ -m 'rm database.yml, create database.default.yml for pg' }

unless IO.read('.gitignore').match /database.yml/
  append_file '.gitignore', "config/database.yml\n"
  git add: "."
  git commit: %Q{ -m 'ignore database.yml' }
end

gem_install_bundle_and_commit 'silent-postgres'

if yes? 'link database.yml to database.default.yml?'

  `ln -fs database.default.yml config/database.yml`

  if yes? 'create all the databases?'
    run 'rake db:create:all'
  end
end
