<link rel="stylesheet" href="/css/markdown.css">
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.1.0/styles/tomorrow-night.min.css">
<script src="http://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.1.0/highlight.min.js"></script>    
<script>hljs.initHighlightingOnLoad();</script>

# 代碼庫之「讀寫文件」


## 1. 如何讀取文件？

~~~ruby
File.open("a.txt", "r") {|f|
  p f.read
}
~~~

更多見[ File 文檔](http://ruby-doc.org/core-2.4.2/File.html)。


## 2. 如何提取目錄？

~~~ruby
Dir.glob("./views/code/*.md").each do |md|
  # ...
end
~~~

[`glob()`文檔](http://ruby-doc.org/core-2.4.2/Dir.html#method-c-glob)。


## 3. 如何讀取 .csv 文件？

~~~ruby
CSV.foreach("path/to/file.csv") do |row|
  # use row here...
end
~~~

詳見[ CSV 文檔](http://ruby-doc.org/stdlib-2.4.2/libdoc/csv/rdoc/CSV.html)


## 4. 如何讀取 .json 文件？

~~~ruby
require 'json'

my_hash = JSON.parse('{"hello": "goodbye"}')
puts my_hash["hello"] => "goodbye"
~~~

詳見[ JSON 文檔](http://ruby-doc.org/stdlib-2.4.2/libdoc/json/rdoc/JSON.html)
