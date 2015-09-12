require File.expand_path('../lib/gem_install_bundle_and_commit', __FILE__)

gem_install_bundle_and_commit_append 'newrelic_rpm'

remove_file 'config/newrelic.default.yml'
create_file 'config/newrelic.default.yml', <<-DONE_WITH_YAML
#
# This file configures the New Relic Agent.  New Relic monitors Ruby, Java,
# .NET, PHP, Python and Node applications with deep visibility and low
# overhead.  For more information, visit www.newrelic.com.
#
# Generated September 11, 2015
#
# This configuration file is custom generated for Serene Inc.
#
# For full documentation of agent configuration options, please refer to
# https://docs.newrelic.com/docs/agents/ruby-agent/installation-configuration/ruby-agent-configuration

common: &default_settings
  # Required license key associated with your New Relic account.
  # This template doesn't install a valid license key, you need to replace it with yours!
  # Better yet, sign in to your newrelic account and from account settings
  # download a clean newrelic.yml configuration file and save it in config/
  # instead of linking to this file.
  license_key: badbadbadbadbadbadbadbadbadbadbadbadbadb

  # Your application name. Renaming here affects where data displays in New
  # Relic.  For more details, see https://docs.newrelic.com/docs/apm/new-relic-apm/maintenance/renaming-applications
  app_name: My Application

  # To disable the agent regardless of other settings, uncomment the following:
  # agent_enabled: false

  # Logging level for log/newrelic_agent.log
  log_level: info


# Environment-specific settings are in this section.
# RAILS_ENV or RACK_ENV (as appropriate) is used to determine the environment.
# If your application has other named environments, configure them here.
development:
  <<: *default_settings
  app_name: My Application (Development)

  # NOTE: There is substantial overhead when running in developer mode.
  # Do not use for production or load testing.
  developer_mode: true

test:
  <<: *default_settings
  # It doesn't make sense to report to New Relic from automated test runs.
  monitor_mode: false

staging:
  <<: *default_settings
  app_name: My Application (Staging)

production:
  <<: *default_settings
DONE_WITH_YAML

git add: "config/newrelic.default.yml"
git commit: %Q{ -m 'newrelic.default.yml ... works in dev but not prod' }

unless IO.read('.gitignore').match /newrelic.yml/
  append_file '.gitignore', 'config/newrelic.yml'
  git add: "."
  git commit: %Q{ -m 'ignore newrelic.yml' }
end

if yes? 'link newrelic.yml to newrelic.default.yml?'

  `ln -fs newrelic.default.yml config/newrelic.yml`

end