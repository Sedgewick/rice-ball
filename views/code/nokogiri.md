# 代碼庫之「 Nokogiri 庫」

解析網頁當然選 Nokogiri 😁

## 1. 怎麼撿出 HTML 文本的特定元素？

[官方文檔](http://www.nokogiri.org/tutorials/searching_a_xml_html_document.html)其實寫得還不如這篇「[Parsing HTML with Nokogiri](http://ruby.bastardsbook.com/chapters/html-parsing/)」易懂。有空可以把這篇「[Writing a Web Crawler](http://ruby.bastardsbook.com/chapters/web-crawling/)」看了。

Nokogiri 庫最好用的地方在於支持 CSS 方式選擇元素，但要注意錯誤處理：

~~~ruby
require 'nokogiri'

doc = Nokogiri::HTML(open("https://example.com/"))

doc.css('div.item-show').each do |link|
  begin
    rating = '★' * link.css('div.date span').first['class'][6].to_i
  rescue => e
    case e
    when NoMethodError
      # ...
    else
      raise e
    end
  end
end
~~~
