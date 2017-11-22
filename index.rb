require 'open-uri'
require 'kramdown'
require 'sinatra'
require "time"
require 'erb'
require 'json'
require "pp"
require_relative 'lib/fanfou.rb'

class String
  def to_markdown
     self.gsub(/<code>(.+?)<\/code>/) { "`#{$1}`" }
         .gsub(/<sup>.+?\[(\d+)\]<\/a><\/sup>/) { "[^fn#{$1}]" }
         .gsub(/<h(\d)>(.+?)<\/h\1>/) { '#' * $1.to_i + ' ' + $2 }
         .gsub(/<em>(.+?)<\/em>/) { "**#{$1}**" }
         .gsub(/<hr>/, '----')
         .gsub(/<li>\n?(.+?)<\/li>/m) { "- #{$1}\n"}
         .gsub(/<\/?ol>/, '')
         .gsub(/<pre><code>(.+?)<\/code><\/pre>/m) { "\n#{$1.gsub(/^/, '    ')}" }
         .gsub(/<img src="(.+?)"\s+alt="(.+?)">/) { "![#{$2}](http:#{$1})"}
         .gsub(/<div class="image-caption">.+?<\/div>/, '')
         .gsub(/<div.+?>|<\/div>|<br>|<\/?ul>/, '')
         .gsub(/<a href="(.+?)".+?>(.+?)<\/a>/) { "[#{$2}](#{$1})" }
         .gsub(/\s*<p>|<\/p>/, '')
         .gsub('&lt;', '<')
         .gsub('&gt;', '>')
         .gsub(/-(.+)\[↩\]\(#fnref(\d+)\)/) { "[^fn#{$2}]: #{$1}" }
  end
end

configure do
  (start = Time.now) && (ff = FanFou.new('Sedgewick')) && (puts "Started: #{Time.now - start} sec.")
  set :ff => ff
  set :conversations => ff.conversations
  set :statuses_pool => ff.statuses_pool
  
  (start = Time.now) && (ff_nimr = FanFou.new("小蔫蔫")) && (puts "Started: #{Time.now - start} sec.")
  set :ff_nimr => ff_nimr
  set :conversations_nimr => ff_nimr.conversations
  set :statuses_pool_nimr => ff_nimr.statuses_pool
end


get '/' do
  erb :index
end

get '/code' do
  url = "http://api.fanfou.com/statuses/user_timeline.json?id=Sedgewick"
  @statuses = JSON.parse(open(url).read)
  
  erb :code
end

get '/fanfou' do
  settings.ff.update_database
  settings.ff.gen_conversations
  @conversations = settings.conversations
  @statuses_pool = settings.statuses_pool
  
  erb :fanfou
end

get '/fanfou_nimr' do
  settings.ff_nimr.update_database
  settings.ff_nimr.gen_conversations
  @conversations_nimr = settings.conversations_nimr
  @statuses_pool_nimr = settings.statuses_pool_nimr
  
  erb :fanfou_nimr
end

get '/log' do
  markdown :log, :layout_engine => :erb
end

get '/ideas' do
  @conversations = settings.conversations
  @statuses_pool = settings.statuses_pool
  erb :ideas
end

get '/niu' do
  @conversations = settings.conversations
  @statuses_pool = settings.statuses_pool
  erb :niu
end

get '/nimr' do
  @conversations = settings.conversations
  @statuses_pool = settings.statuses_pool
  erb :nimr
end

get '/search' do
  @conversations = settings.conversations
  @statuses_pool = settings.statuses_pool
  
  @word = params[:word]
  erb :search
end

get '/chart' do
  @conversations = settings.conversations
  @statuses_pool = settings.statuses_pool
  
  @word = params[:word]
  erb :chart
end

get '/sleep' do
  @conversations = settings.conversations
  @statuses_pool = settings.statuses_pool
  
  @year = params[:year]
  erb :sleep
end

get '/calendar' do
  @conversations = settings.conversations
  @statuses_pool = settings.statuses_pool
  
  erb :calendar
end

get '/stat' do
  @conversations = settings.conversations
  @statuses_pool = settings.statuses_pool
  
  @word = params[:word]
  erb :stat
end

get '/book' do
  @conversations = settings.conversations
  @statuses_pool = settings.statuses_pool
  
  erb :book
end

get '/movies' do
  erb :movies
end

get '/movies_heat_map' do
  erb :movies_heat_map
end

get '/books' do
  erb :books
end

get '/books_heat_map' do
  erb :books_heat_map
end

get '/search_blog' do
  @word = params[:word]
  erb :search_blog
end

get '/search_all' do
  @word = params[:word]
  @conversations = settings.conversations
  @statuses_pool = settings.statuses_pool
  
  erb :search_all
end

get '/code/:topic' do
  markdown :"/code/#{params['topic']}" # 必須在 /views 目錄下？！
end

get '/search_code' do
  @word = params[:word]
  
  erb :search_code
end

get '/search_all_by_time' do
  @word = params[:word]
  @conversations = settings.conversations
  @statuses_pool = settings.statuses_pool
  
  erb :search_all_by_time
end

get '/read-it-later' do
  @u  = params['u']
  @tl = params['tl']
  @tm = Time.at(params['tm'].to_i/1000)
  
  erb :read_it_later
end

get '/read-it-later/delete' do
  @id  = params['id']
  
  erb :read_it_later_delete
end

get '/read-it-later/star-toggle' do
  @id  = params['id']
  
  erb :read_it_later_star_toggle
end

get '/read-it-later/edit' do
  @id  = params['id']
  
  erb :read_it_later_edit
end

post '/read-it-later/update/:id' do
  id = params['id']
  title = params['title']
  url = params['url']
  note = params['note']
  
  db = SQLite3::Database.open(Dir.pwd + "/data/bookmarks.db")
  db.execute("UPDATE bookmarks SET title = :title WHERE ID = :id", {"title" => title, "id" => id})
  db.execute("UPDATE bookmarks SET url = :url WHERE ID = :id", {"url" => url, "id" => id})
  db.execute("UPDATE bookmarks SET note = :note WHERE ID = :id", {"note" => note, "id" => id})
  db.close
  
  redirect '/read-it-later'
end