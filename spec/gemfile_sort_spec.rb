require File.expand_path('../spec_helper', __FILE__)
require 'gemfile_sort'

describe "gemfile_sort" do
  let(:gemless_lines) {["source 'https://rubygems.org", "Ruby 2.1.1", "", "# gem rails"]}
  it "doesn't change a file with no gem commands" do
    expect(gemfile_sort gemless_lines).to eql(gemless_lines)
  end

  describe "with at least some gem commands" do
    it "sorts gem commands" do
      expect(gemfile_sort ["gem rails", "gem pry"]).to eql(["gem pry", "gem rails"])
    end

    it "ignores the quotation marks when sorting, but preserves them in the output" do
      expect(gemfile_sort ["gem 'rails'", 'gem "pry"', "gem 'debugger'"]).to eql(["gem 'debugger'", 'gem "pry"', "gem 'rails'"])
    end

    it "doesn't change the original source lines array" do
      orig = ["gem rails", "gem pry"]
      expect do
        gemfile_sort orig
      end.not_to change{orig}
    end

    it "leaves comments that come right before gems before the gem" do
      expect(gemfile_sort ["# pry is great", "gem pry", "# I love rails!", "gem rails"])
    end

    it "leaves dotenv-rails in the first position" do
      lines_to_sort = ["# gotta initialize the environment first", "gem 'dotenv-rails'", 'gem "pry"', "gem 'debugger'"]
      sorted_lines  = ["# gotta initialize the environment first", "gem 'dotenv-rails'", "gem 'debugger'", 'gem "pry"']
      expect(gemfile_sort lines_to_sort).to eql(sorted_lines)
    end

    it "removes duplicate gems" do
      expect(gemfile_sort ["gem rails", "gem rails"]).to eq ["gem rails"]
    end

    it "never leaves more than two consecutive lines of whitespace" do
      expect(gemfile_sort ["# comment", "", "", "", "gem pry"]).to eq ["# comment", "", "", "gem pry"]
    end
  end
end

describe "remove_excessive_whitespace" do
  it "leaves two empty lines intact" do
    expect(remove_excessive_whitespace ["\n", "\n"]).to eq ["\n", "\n"]
  end

  it "turns three empty lines into two" do
    expect(remove_excessive_whitespace ["\n", "\n", "\n"]).to eq ["\n", "\n"]
  end

  it "turns many empty lines into two" do
    expect(remove_excessive_whitespace ["\n", "\n", "\n", "\n", "\n", "\n", "\n", "\n"]).to eq ["\n", "\n"]
  end
end

describe "add_group_hash_to_line" do
  it "leaves a newline on the end of the line" do
    expect( add_group_hash_to_line "gem 'pry'\n", ":group => :development" ).to eq("gem 'pry', :group => :development\n")
  end

  it "doesn't insert a newline on the end of a line that doesn't already have one" do
    expect( add_group_hash_to_line "gem 'pry'", ":group => :development" ).to eq("gem 'pry', :group => :development")
  end
end

describe "expand_groups" do
  describe "for a group of gems having a single symbol as their context" do
    let(:grouped_lines) do
      [ "group :doc do\n",
        "  # bundle exec rake doc:rails generates the API under doc/api.\n",
        "  gem 'sdoc', require: false\n",
        "end"
      ]
    end

    it "strips leading whitespace from every line" do
      lines_that_start_with_whitespace = expand_groups(grouped_lines).select {|line| line =~ /^\s/}
      expect( lines_that_start_with_whitespace ).to be_empty
    end

    it "uses :group => symbol" do
      expect( expand_groups(grouped_lines).join ).to include(":group => :doc")
    end

    it "preserves context comments" do
      expect( expand_groups(grouped_lines) ).to include("# bundle exec rake doc:rails generates the API under doc/api.\n")
    end

    it "removes the group do ... end block" do
      expanded_and_joined = expand_groups(grouped_lines).join
      expect( expanded_and_joined ).not_to include("group :doc do")
      expect( expanded_and_joined ).not_to include("end")
    end
  end

  it "preserves a list of groups with each gem" do
    grouped_lines = [
      "group :development, :test do",
      "  gem 'rspec-rails', '~> 2.0'",
      "  gem 'quiet_assets'",
      "end"
    ]
    expanded_lines = [
      "gem 'rspec-rails', '~> 2.0', :groups => [ :development, :test ]",
      "gem 'quiet_assets', :groups => [ :development, :test ]"
    ]
    expect( expand_groups grouped_lines ).to eq expanded_lines
  end
end
