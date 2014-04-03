require 'fileutils'

def sort_and_save_gemfile(make_backup=false)
  unless File.exist?("Gemfile")
    puts "#{__FILE__}:#{__LINE__} #{__method__} Gemfile doesn't exist!"
    exit -1
  end

  if make_backup
    backup_gemfile_name = "Gemfile-#{Time.now.strftime("%Y-%m-%d-%H:%M:%S-%Z")}"
    puts "cp Gemfile #{backup_gemfile_name}"
    FileUtils.cp("Gemfile", backup_gemfile_name)
  end
  lines = IO.read('Gemfile')
  newlines = gemfile_sort(lines)
  File.open('Gemfile', 'w') do |f|
    f.write newlines.join("\n")
  end
end

def gemfile_sort(lines)
  output_lines = []
  gems_to_sort = []
  new_lines = lines.dup
  stored_context = []
  new_lines.each do |line|
    case line
    when /^#/
      stored_context << line
    when /^gem/
      sort_key = line.gsub(/'"/, '') # remove the quotation marks because we don't want them to count
      gems_to_sort << [sort_key, stored_context + [line]]
      stored_context = []
    else
      output_lines += stored_context + [line]
      stored_context = []
    end
  end
  output_lines += stored_context
  gems_to_sort.sort.each do |gem_lines|
    sort_key, lines_to_add = gem_lines
    output_lines += lines_to_add
  end
  output_lines.flatten
end
