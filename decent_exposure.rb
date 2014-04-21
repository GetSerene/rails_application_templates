require File.expand_path('../lib/gem_install_bundle_and_commit', __FILE__)

gem_install_bundle_and_commit 'decent_exposure'


inject_into_file 'app/controllers/application_controller.rb', :after => "class ApplicationController < ActionController::Base\n" do
  <<-STRONG_PARAMS_CONFIG_STR
  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end
  STRONG_PARAMS_CONFIG_STR
end
git add: 'app/controllers/application_controller.rb'
git commit: %Q{ -m 'use DecentExposure::StrongParametersStrategy' }
