# based on http://gabebw.wordpress.com/2011/03/21/temp-files-in-rspec/
module UsesTempFiles
  def self.included(example_group)
    example_group.extend(self)
  end

  def in_directory_with_file(file)
    before do
      @pwd = Dir.pwd
      @tmp_dir = File.join(File.dirname(__FILE__), 'tmp')
      FileUtils.mkdir_p(@tmp_dir)
      Dir.chdir(@tmp_dir)

      FileUtils.mkdir_p(File.dirname(file))
      FileUtils.touch(file)
    end

    define_method(:content_for_file) do |content|
      f = File.new(File.join(@tmp_dir, file), 'a+')
      f.write(content)
      f.flush # VERY IMPORTANT
      f.close
    end

    define_method(:content_from_file) do
      IO.read(File.join(@tmp_dir, file))
    end

    after do
      Dir.chdir(@pwd)
      FileUtils.rm_rf(@tmp_dir)
    end
  end
end