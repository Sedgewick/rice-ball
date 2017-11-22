<link rel="stylesheet" href="/css/markdown.css">
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.1.0/styles/tomorrow-night.min.css">
<script src="http://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.1.0/highlight.min.js"></script>    
<script>hljs.initHighlightingOnLoad();</script>

# 代碼庫之「SQLite」


## 1. 如何新建數據庫？

~~~ruby
require 'sqlite3'

begin
    
    db = SQLite3::Database.new ":memory:"
    puts db.get_first_value 'SELECT SQLITE_VERSION()'
    
rescue SQLite3::Exception => e 
    
    puts "Exception occurred"
    puts e
    
ensure
    db.close if db
end
~~~

`:memory:`意思是「 in-memory 數據庫」。


## 2. 如何新建數據表？

~~~ruby
db.execute <<-SQL
  create table movies_list (
    id varchar(12) PRIMARY KEY,
    title varchar(50),
    original_title varchar(50),
    my_rating varchar(10),
    watched_date varchar(10)
  );
SQL
~~~

SQLite 3 的數據類型有點讓人困惑。


## 3. 如何插入數據？

~~~ruby
movies_list.each do |m|
  db.execute("INSERT INTO movies_list (id, title, original_title, my_rating, watched_date)
              VALUES (?, ?, ?, ?, ?)", m)
end
~~~


## 4. 如何讀取數據？

~~~ruby
db.execute( "select * from movies_list" ) do |row|
  p row
end
~~~


----

有時間可以看看這篇「[SQLite Ruby tutorial](http://zetcode.com/db/sqliteruby/)」。