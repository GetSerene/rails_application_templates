require File.expand_path('../spec_helper', __FILE__)
require 'gem_install_bundle_and_commit'

describe "gem_in_lines?" do
  describe "when the gem is installed" do
    it "detects the gem" do
      expect(gem_in_lines? 'pg', ["gem 'pg'"]).to be_true
    end

    it "detects the gem regardless of differences in quotation marks" do
      expect(gem_in_lines? "'pg'", ['gem "pg"']).to be_true
    end
  end
end
