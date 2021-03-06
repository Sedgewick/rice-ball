require 'json'

DEBUG = false

class MD5s
  attr_reader :md5s
  
  def initialize
    @ignored_dirs = %W<. .. .git .gitignore .DS_Store .sass-cache #{__FILE__} md5s.json bookmarks.db bookmarks.log douban.db fanfou.db>
    # __FILE__ : the name of the current file
    # 這裏的路徑是有問題的，待除！
    
    @md5s = []
  end
  
  def get_md5(file)
    md5 = `md5 #{file}`
    md5.scan(/(?<==\s)[\w\d]+/).first
  end
  
  def get_all_md5(directory)
    Dir.foreach(directory) do |subdir|
      dir = directory + '/' + subdir
      next if @ignored_dirs.include? subdir
      if /\s/ =~ subdir
        new_dir = directory + '/' + subdir.gsub!(/\s/, '_')
        File.rename(dir, new_dir)
        dir = new_dir
      end
      
      if /\./ =~ subdir
        DEBUG && puts("file: #{dir}")
        @md5s << {
                   file_name: dir,
                   md5: get_md5(dir)
                 }
      else
        DEBUG && puts("dir:  #{dir}")
        get_all_md5(dir)
      end
    end
    @md5s
  end
  
  def check_diff
    @updated_files = []
    f = File.open('md5s.json', 'r').read
    json = JSON.parse(f)
    @md5s.each do |file|
      fname = file[:file_name]
      old_file = json.select { |e| e['file_name'] == fname }
      if old_file == []
        @updated_files << fname
      else
        old_md5 = old_file.first['md5']
        unless old_md5 == file[:md5]
          DEBUG && puts("#{fname} UPDAT!")
          @updated_files << fname
        end
      end
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
        @md5s.delete_if { |d| d[:file_name] == dir } # Fix BUG: 當本次選擇不同步，則下次將不會被更新，因為新 MD5 值已經寫入文件了。
      else
        answers = ["wrong answer😒", "丫在調戲我嗎🤯", "能不能認真點😤"]
        puts answers[rand(answers.size)]
      end
    end
    
    File.open('./md5s.json', 'w') do |f|
      f.write @md5s.to_json
    end
    
  end
end


marks = MD5s.new
marks.update