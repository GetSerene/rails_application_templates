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

def remove_excessive_whitespace(lines)
  consecutive_whitespace = 0
  lines.reject do |line|
    if line !~ /^\s*$/
      consecutive_whitespace = 0
      false
    elsif (consecutive_whitespace += 1) > 2
      true
    else
      false
    end
  end
end

def add_group_hash_to_line(line, groups_hash)
  result = "#{line}, #{groups_hash}"
  if result =~ /\n/
    result.gsub! "\n", ""
    result = "#{result}\n"
  end
  result
end

def expand_groups(lines)
  output_lines = []
  groups_hash = false
  lines.each do |line|
    line = line.gsub /^\s+(\S)/, '\1'
    if groups_hash
      line = case line
      when /^gem/
        add_group_hash_to_line(line, groups_hash)
      when /^end/
        groups_hash = false
        false
      else
        line
      end
    else
      line = case line
      when /^group \s*(.*)\s*do/
        groups = $1.split(",").collect(&:strip)
        groups_hash = (groups.length > 1) ? ":groups => [ #{groups.join ", "} ]" : ":group => #{groups.first}"
        false
      else
        line
      end
    end
    output_lines << line if line
  end
  output_lines
end

def gemfile_sort(lines, keep_first = ['dotenv-rails'])
  output_lines = []
  gems_to_sort = []
  new_lines = lines.dup.collect {|line| line =~ /\n$/m ? line : "#{line}\n"}
  stored_context = []
  expand_groups(new_lines).each do |line|
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
  remove_excessive_whitespace output_lines.flatten
end
