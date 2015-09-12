require File.expand_path('../lib/gem_install_bundle_and_commit', __FILE__)

if File.exist?('.ruby-version')
  if IO.read('.ruby-version') =~ /^([Rr]uby[- ])(\d+\.\d+.\d+)(-p\d+)?$/
    # for rvm's .ruby-version
    version = %q{IO.read('.ruby-version').gsub(/^([Rr]uby[- ])?(\d+\.\d+.\d+)(-p\d+)?$/, '\\2\\3').strip}
  else
    # for rbenv's .ruby-version
    version = %q{IO.read('.ruby-version').strip}
  end
else
  version = "'2.2.3'"
end

inject_into_file "Gemfile", "ruby #{version}\n", :after => "source 'https://rubygems.org'\n"
git add: "Gemfile"
git commit: %Q{ -m 'add ruby #{version} into Gemfile' }
