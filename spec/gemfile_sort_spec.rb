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
      expect(gemfile_sort ["gem rails", 'gem pry', "gem debugger"]).to eql(["gem debugger", 'gem pry', "gem rails"])
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
  end
end