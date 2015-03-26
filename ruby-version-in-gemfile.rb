require File.expand_path('../lib/gem_install_bundle_and_commit', __FILE__)

if File.exist?('.ruby-version') && IO.read('.ruby-version') =~ /^([Rr]uby[- ])?(\d+\.\d+.\d+)(-p\d+)?$/
  version = $2
else
  version = "2.2.1"
end

inject_into_file "Gemfile", "ruby '#{version}'\n", :after => "source 'https://rubygems.org'\n"
git add: "Gemfile"
git commit: %Q{ -m 'add ruby \'#{version}\' into Gemfile' }
