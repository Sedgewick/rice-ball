<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.1.0/styles/tomorrow-night.min.css">
<script src="http://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.1.0/highlight.min.js"></script>    
<script>hljs.initHighlightingOnLoad();</script>

# 代碼庫之「 Ruby 的正則表達式」


## 1. 怎麼定義正則表達式？

用`/.../`或`%r{...}`就夠了，沒必要用`Regexp::new`；有時會用到[`options`](http://ruby-doc.org/core-2.4.2/Regexp.html#class-Regexp-label-Options)：

- `/pat/i` - 忽略大小寫；
- `/pat/m` - 多行查找；
- `/pat/o` - 可以執行一次`#{}`，這點相當有用，因為模式未必是固定的，比如在請求搜索中；
- `/pat/x` - 忽略模式中的空格和註釋，但貌似不能忽略範圍量詞中的空格：

<pre>
	<code class="ruby">
/\d{3,6}/x =~ '123456'		#=> 0
/\d{3, 6}/x =~ '123456'		#=> nil
	</code>
</pre>

## 2. 元字符有哪些？

也就是，哪些字符需要轉義？`(`, `)`, `[`, `]`, `{`, `}`, `.`, `?`, `+`, `*`，以上。這點其實很重要，因為在處理 HTML 這類時很容易迷惑「是不是需要轉義」。


## 3. 怎麼寫出正確的正則表達式？

余晟老師在[這篇](http://www.infoq.com/cn/news/2011/04/regular-expressions-4)裏已經講得很清楚了：就是「與或非」。



----

## Tips:

### 1. 如何匹配全角空格？

用`\p{Z}`就好了，詳見 @余晟 老師[這篇](http://www.infoq.com/cn/news/2011/03/regular-expressions-unicode-2)裏講到的 Unicode Property 。


### 2. 高級技巧之「環視」

簡單來說，就是「向前看」(lookahead)和「向後看」(lookbehind)。當然，這裏的「向前」「向後」都是站在字符串的角度，也就是順著閱讀方向（即「從左到右」）為正向。這是相當有用的技巧，比初學者想像的還要有用。

- `(?=pat)` - Positive lookahead assertion: 確保前面有東西，而且就是那東西；
- `(?!pat)` - Negative lookahead assertion: 確保前面就算有東西，也不是那東西；
- `(?<=pat)` - Positive lookbehind assertion: 確保後面有東西，而且就是那東西；
- `(?<!pat)` - Negative lookbehind assertion: 確保後面就算有東西，也不會是那東西；

最好的例子就是匹配`<p>`和`</p>`之間具有某個模式的一段話：

~~~ruby
pat = '\d+'
'<p>this is a num 123.</p>'.scan(/(?<=<p>).*(#{pat}).*(?=<\/p>)/x)  #=> [["3"]]
~~~


### 3. 到底是`pat =~ str`，還是`str =~ pat`？傻傻分不清☹️

順序沒關係的，`Regexp`和`String`都定義了`=~`模式匹配操作符。不信，看[這](http://ruby-doc.org/core-2.4.2/Regexp.html#class-Regexp-label-3D-7E+operator)。

但！建議還是把模式放`=~`左邊：`pat =~ str`。好處見 Tip 4 。


### 4. 隱藏技巧之「named capture groups」

捕獲組可以命名的喔，而且會自動生成同名的局部變量。

~~~ruby
/\$(?<dollars>\d+)\.(?<cents>\d+)/ =~ "$3.67" #=> 0
dollars #=> "3"
~~~

注意⚠️：只有模式在`=~`左邊的時候，命名的捕獲組才會生成同名的局部變量。[文檔](http://ruby-doc.org/core-2.4.2/Regexp.html#class-Regexp-label-Capturing)在這。

----

總之，大家多看看[主文檔](http://ruby-doc.org/core-2.4.2/Regexp.html)吧。
