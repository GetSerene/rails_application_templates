require 'fileutils'

def sort_and_save_gemfile(option_overrides = {})
  options = {
    make_backup: false,
    gemfile_name: 'Gemfile'
  }.merge(option_overrides)
  unless File.exist?(options[:gemfile_name])
    puts "#{__FILE__}:#{__LINE__} #{__method__} #{options[:gemfile_name]} doesn't exist!"
    exit -1
  end

  if options[:make_backup]
    backup_gemfile_name = "#{options[:gemfile_name]}-#{Time.now.strftime("%Y-%m-%d-%H:%M:%S-%Z")}"
    puts "cp #{options[:gemfile_name]} #{backup_gemfile_name}"
    FileUtils.cp("#{options[:gemfile_name]}", backup_gemfile_name)
  end
  lines = IO.readlines(options[:gemfile_name])
  newlines = gemfile_sort(lines)
  File.open(options[:gemfile_name], 'w') do |f|
    f.write newlines.join("")
  end
end

def gemfile_sort(lines, keep_first = ['dotenv-rails'])
  output_lines = []
  gems_to_sort = []
  new_lines = lines.dup
  stored_context = []
  new_lines.each do |line|
    case line
    when /^#/
      stored_context << line
    when /^gem/
      if keep_first.find_index {|keeper| line.include? keeper}
        output_lines += stored_context + [line]
        stored_context = []
        next
      end
      sort_key = line.gsub(/['"]/, '') # remove the quotation marks because we don't want them to count
      gems_to_sort << [sort_key, stored_context + [line]]
      stored_context = []
    else
      output_lines += stored_context + [line]
      stored_context = []
    end
  end
  output_lines += stored_context unless stored_context.empty?
  gems_to_sort.sort.uniq.each do |gem_lines|
    sort_key, lines_to_add = gem_lines
    output_lines += lines_to_add
  end
  output_lines.flatten
end
