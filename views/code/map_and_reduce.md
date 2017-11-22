<link rel="stylesheet" href="/css/markdown.css">
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.1.0/styles/tomorrow-night.min.css">
<script src="http://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.1.0/highlight.min.js"></script>    
<script>hljs.initHighlightingOnLoad();</script>

# 代碼庫之「 Ruby 的 map / reduce 」


## 1. map(...)

`map(...)`很簡單，後面跟一「塊」就行。別名`collect(...)`，詳見[文檔](https://ruby-doc.org/core-2.4.2/Enumerable.html#method-i-map)。

~~~ruby
(1..4).map { |i| i*i }      #=> [1, 4, 9, 16]
(1..4).collect { "cat"  }   #=> ["cat", "cat", "cat", "cat"]
~~~


## 2. reduce(...)

`reduce(...)`有[四種形式](https://ruby-doc.org/core-2.4.2/Enumerable.html#method-i-reduce)：

- `reduce(initial, sym) → obj`
- `reduce(sym) → obj`
- `reduce(initial) { |memo, obj| block } → obj`
- `reduce { |memo, obj| block } → obj`

這裏，`memo`是累加值(accumulator value)。如果不顯式地給`memo`賦初值，那默認把初值設定為集合的第一個元素的值。

別名`inject(...)`，好像很長一段時間 Ruby 都沒有`reduce(...)`。這聽起來很奇怪，要知道 Ruby 是一門語法糖🍬這麼普遍的語言。

~~~ruby
# Sum some numbers
(5..10).reduce(:+)                             #=> 45
# Same using a block and inject
(5..10).inject { |sum, n| sum + n }            #=> 45
# Multiply some numbers
(5..10).reduce(1, :*)                          #=> 151200
# Same using a block
(5..10).inject(1) { |product, n| product * n } #=> 151200
# find the longest word
longest = %w{ cat sheep bear }.inject do |memo, word|
   memo.length > word.length ? memo : word
end
longest                                        #=> "sheep"
~~~

傳入 symbol 那種寫法貌似只支持內置的二元操作。你要想這樣自己寫一個傳進去就不好使：

~~~ruby
def foo(c, d)
  c.size + d.size
end

['abc', 'def', 'hijk'].reduce(0, :foo) # => ArgumentError: wrong number of arguments (given 1, expected 2)
~~~
