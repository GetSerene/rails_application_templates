gsub_file 'config/environments/development.rb',
  /config.action_mailer.raise_delivery_errors = false/,
  "config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }"

git add: "."
git commit: %Q{ -m 'default url options in dev' }
