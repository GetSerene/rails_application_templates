require File.expand_path('../lib/gem_install_bundle_and_commit', __FILE__)

gem_install_bundle_and_commit 'bootstrap-sass'

gem_install_bundle_and_commit 'rails_layout', groups: [:development]

generate 'layout:install bootstrap3'
git rm:  'app/assets/stylesheets/application.css'
git add: 'app/assets/stylesheets/application.css.scss'
git rm:  'app/views/layouts/application.html.erb'
git add: 'app/views/layouts/application.html.haml'
git add: 'app/assets/stylesheets/framework_and_overrides.css.scss'
git add: 'app/assets/javascripts/application.*'
remove_file 'app/views/layouts/_navigation_links.html.erb'
create_file 'app/views/layouts/_navigation_links.html.haml', '-# add navigation links to this file'
git add: 'app/views/layouts/*.html.haml'
git commit: %Q{ -m 'rails generate layout:install bootstrap3' }

generate 'layout:navigation'
git add: '.'
git commit: %Q{-m 'rails generate layout:navigation'}

generate 'layout:devise bootstrap3'
git add: '.'
git commit: %Q{-m 'rails generate layout:devise bootstrap3'}

