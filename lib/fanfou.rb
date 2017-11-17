require 'sqlite3'

class FanFou
  attr_reader :statuses_pool, :conversations
  
  def initialize
    (start = Time.now) && update_database && (puts "UPDATED: #{Time.now - start} sec.")
    (start = Time.now) && gen_conversations && (puts "GEN: #{Time.now - start} sec.")
  end
  
  def update_database
    db = SQLite3::Database.open(Dir.pwd + "/data/fanfou.db")
    ids = db.execute( "select id from statuses" ).flatten

    stop_index = -1
    new_statuses = []
    page = 1
    loop do
      this_page_statuses = grab_statuses(page)
      # puts "page #{page}"
      this_page_statuses.each_with_index do |status, index|
        if ids.include? status['id']
          puts "got it at #{index}"
          stop_index = index
          break
        end
      end
  
      new_statuses += this_page_statuses
      break unless stop_index == -1
      page += 1
    end
    
    c = stop_index + 20 * (page - 1)
    if c > -1
      new_statuses[0...c].each do |status|
        record = [
                  status['id'],
                  status['rawid'],
                  (Time.parse(status["created_at"]) + 3600 * 8).to_s[0..-7],
                  status['text'],
                  status['in_reply_to_status_id'],
                  status['in_reply_to_user_id'],
                  status['favorited'].to_s,
                  (status['photo'] || {'thumburl' => nil, 'largeurl' => nil})['largeurl'],
                  (status['photo'] || {'thumburl' => nil, 'largeurl' => nil})['thumburl']
                 ]
        db.execute("INSERT INTO statuses (id, raw_id, created_at, content, in_reply_to_status_id, in_reply_to_user_id, favorited, photo_url_large, photo_url_thumb)
                    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", record)
      end
    end

    puts "added #{ (stop_index + 20 * (page - 1)) } statuses:"
    pp new_statuses[0...(stop_index + 20 * (page - 1))]
    
    @statuses_pool = {}
    db.execute("SELECT * FROM statuses ORDER BY created_at DESC") do |row|
      @statuses_pool["#{row[0]}"] = {
                                      'raw_id' => row[1],
                                      'created_at' => row[2],
                                      'text' => row[3],
                                      'in_reply_to_status_id' => row[4],
                                      'in_reply_to_user_id' => row[5],
                                      'favorited' => (row[6] == 'true')? true : false,
                                      'photo_url_large' => row[7],
                                      'photo_url_thumb' => row[8]
                                    }
    end
    db.close
    
    @statuses_pool
  end
  
  def gen_conversations
    watched_ids = []
    @conversations = []

    @statuses_pool.each do |k, v|
      next if watched_ids.include? k
      group = [k]
      unless v["in_reply_to_status_id"].empty?
        reply_id = v["in_reply_to_status_id"]
        until reply_id.empty?
          if @statuses_pool[reply_id].nil?
            # puts "#{reply_id} is NOT ME!!!"
            break
          else
            watched_ids << reply_id
            group.unshift reply_id
            reply_id = @statuses_pool[reply_id]["in_reply_to_status_id"]
          end
        end
      end
      
      @conversations << group
      watched_ids << k

    end
    
    @conversations
  end
  
  
  def grab_statuses(page)
    resp = open("http://api.fanfou.com/statuses/user_timeline.json?id=Sedgewick&page=#{page}")
    JSON.parse(resp.read)
  end
  
end