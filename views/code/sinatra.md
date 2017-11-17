# 代碼庫之「 Sinatra 」

## Tips:

### 1. 如何加載靜態文件？

放到`./public/`目錄下就行了。比如：`./public/css/style.css`可以通过`http://example.com/css/style.css`访问。


### 2. 可以更改模版的位置嗎？

貌似只能放在`./views/`目錄下，但可以建子目錄。

~~~ruby
get '/code/:topic' do
  markdown :"/code/#{params['topic']}"
end
~~~


----

- 這裏是[主文檔](https://github.com/sinatra/sinatra)，官網那個訪問太慢[^slow]，不如看這個。
- 這篇「[用 Sinatra 編寫博客應用](http://www.infoq.com/cn/articles/sinatra-intro)」有部分參考價值。
- 這篇介紹 Sinatra 工作原理的「[Let's Build a Sinatra](https://robots.thoughtbot.com/lets-build-a-sinatra)」寫得極讚！這是[中文譯本](https://segmentfault.com/a/1190000004140201)。

[^slow]: 作為一個服務器應用，網站這麼慢，簡直是打臉。