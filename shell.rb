require 'json'
require 'pp'

class MD5s
  attr_reader :md5s
  
  def initialize
    @ignored_dirs = %w<. .. .git .gitignore .DS_Store .sass-cache __FILE__>
    # __FILE__ : the name of the current file
    
    @md5s = []
  end
  
  def get_md5(file)
    md5 = `md5 #{file}`
    md5.scan(/(?<==\s)[\w\d]+/).first
  end
  
  def get_all_md5(directory)
    Dir.foreach(directory) do |subdir|
      if /\./ =~ subdir
        next if @ignored_dirs.include? subdir
        # p "file: #{subdir}"
        dir = directory + '/' + subdir
        md5s << {
                  :file_name => dir,
                  :md5 => get_md5(dir)
                }
      else
        # p "dir: #{subdir}"
        get_all_md5(directory + '/' + subdir)
      end
    end
  end
  
  def check_diff
    @updated_files = []
    f = File.open('md5s.json', 'r').read
    json = JSON.parse(f)
    json.each do |file|
      fname = file['file_name']
      now_md5 = get_md5(fname)
      unless now_md5 == file['md5']
        # puts "#{fname} UPDAT!"
        file['md5'] = now_md5
        @updated_files << fname
      end
    end
    
    File.open('./md5s.json', 'w') do |f|
      f.write @md5s.to_json
    end
    
    @updated_files
  end
  
  def update
    self.get_all_md5('.')
    self.check_diff
    
    @updated_files.each do |dir|
      file = dir.gsub(/^\.\//, '')
      puts "#{file} is changed. Do you need scp it ? (yes/no)"
      input = STDIN.gets.chomp
      case input
      when /y|yes/
        puts "scp #{file} root@www.caitlin.xin:/data/pope/#{file}"
        `scp #{file} root@www.caitlin.xin:/data/pope/#{file}`
        puts "#{file} is UPDATED!"
      when /n|no/
        puts "😒"
      else
        puts "wrong answer😒"
      end
    end
  end
end


marks = MD5s.new
marks.update