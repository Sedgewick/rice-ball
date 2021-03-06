<link rel="stylesheet" href="/css/markdown.css">

# [「飯糰🍙」](/)更新日誌

> 照我記得起來的寫吧，記不太清了☹️

1. 應該是十一月六號下午開始萌生建個網站的想法💡 當時是想給妞妞佔個域名，但`kang.xin`是個溢價域名，後面放棄了。那時候連`ssh`登陸都不會。
2. 到了晚上九點🕘，終於把服務器架好了。用的 Sinatra ，挺簡單的。
3. 七號上午九點🕘前後，學會了用`scp`傳文件。現在同步文件方便多了。
4. 不到十點🕙，搞定了「無密碼登錄」。
5. 十點🕙，做了個「飯否」的數據抓下來顯示的功能。
6. 之後，整個七號都在弄`OAuth`登陸，棄！
7. 八號下午兩點🕑，上線了「搜索🔍」功能。
8. 九號下午三點🕒，上線了「搜索詞熱力地圖」。樣式抄的 GitHub 的，學了一晚上的 SVG 畫圖。
9. 九號晚上十一點🕚，添加了「在線雜誌」。
10. 十號上午十一點🕚，為「晚睡熱力地圖」添加了最晚睡的連結。
11. 十一號凌晨一點🕐，上線了「我的豆瓣電影🎬」。
12. 十一號下午兩點🕑，準備抓「豆瓣讀書」的數據，被豆瓣封殺😒
13. 十一號下午四點🕓，簡化合併了部分頁面。
14. 十二號上午十點🕙，上線了「我的豆瓣讀書📖」。
15. 十二號上午十點二十三🕥，上線了「我的豆瓣讀書熱力圖📖」。
16. 十二號下午五點半🕠，上線了「簡書搜索🔍」。
17. 十二號晚上十點半🕥，完成了搜索🔍的聚合。
18. 十四號凌晨一點🕐，編寫了文檔「正則表達式」。
19. 十四號下午一點半🕜，上線了「代碼搜索🔍」。
20. 十四號下午兩點🕑，編寫了文檔「讀寫文件」「 Nogokiri 庫」「 Sinatra 」。
21. 十四號晚上八點🕗，重構了`index.rb`，把讀取文件等耗時部分抽取出來，寫到`fanfou.rb`裏了。
22. 十五號下午五點二十🕠，上線了「按日期搜索🔍」。
23. 十五號晚上八點🕗，用 SQLite 改寫了「飯否」後端，可以在啟動時更新。
24. 十七號下午三點🕒，用 SQLite 改寫了「豆瓣讀書」後端，但還不能實時更新。
25. 十七號下午六點🕕，用 SQLite 改寫了「豆瓣電影」後端，但還不能實時更新。
26. 十七號晚上九點🕘，同步到 [GitHub](https://github.com/Sedgewick/rice-ball) 上了。
27. 十七號晚上十點半🕥，「豆瓣電影」現在可以自動更新了。
28. 十九號下午四點半🕟，上線了「簡易稍後讀」。
29. 十九號晚上七點半🕢，給「稍後讀」添加了刪除按鈕🔘。
30. 十九號晚上十一點四十🕦，將「稍後讀」納入了搜索，但目前只能搜索 title 。
31. 二十號下午五點🕔，給「書籤」（原「稍後讀」）添加了「標心❤️」功能。
32. 二十號晚上八點半🕣，將妮妹的飯否納入了搜索，並調整了飯嘮的顯示樣式。
33. 二十二號下午六點🕕，為「書籤」添加了「編輯」功能。
34. 二十二號晚上十點🕙，為 MarkDown 格式訂製了 CSS 樣式。
35. 二十五號晚上九點半🕤，為「書籤」添加了部分 API （目前僅有 GET ）。並用 Vue.js 改寫了「書籤」頁面([/read-it-later/m](/read-it-later/m))。
36. 二十六號晚上七點半🕢，用 Flex 佈局改寫了「書籤·移動版」，並增加了手機版響應。


----

## 「飯糰🍙」上線功能：

|-----------------+------------+-----------------+----------------|
| 功能             | 鏈接       | 說明             | 上線時間        |
|:----------------|:-----------|:----------------|:--------------:|
| lite 飯否        | [/code](/code)                      | 自動抓取最新的 20 條飯嘮。不能聚合對話。      | 2017/11/07  |
| 我的飯否          | [/fanfou](/fanfou)                  | 抓取我的飯否的全部記錄。沒有實現分頁，因此存在效率問題。 | 2017/11/07 |
| 妮妹的飯否        | [/fanfou_nimr](/fanfou_nimr)        | 抓取妮妹飯否的全部記錄。沒有實現分頁，因此存在效率問題。 | 2017/11/20 |
|-----------------+------------+-----------------+----------------|
| 搜索             | [/search_fanfou](/search_fanfou)                  | 搜索「具有特定關鍵詞/匹配某個模式」的飯嘮。會將匹配字句高亮顯示，並統計出現次數。 | 2017/11/08 |
| 搜索「妞妞」      | [/niu](/niu)                         | 搜索「和妞妞相關」飯嘮的定製頁面。待後期完善⋯⋯ | 2017/11/08  |
| 搜索「妮妹」      | [/nimr](/nimr)                       | 搜索「和妮妹相關」飯嘮的定製頁面。待後期完善⋯⋯ | 2017/11/08  |
| 搜索「創意」      | [/ideas](/ideas)                     | 搜索「和創意相關」飯嘮的定製頁面。待後期完善⋯⋯ | 2017/11/08  |
| 簡書搜索         | [/search_blog](/search_blog)                   | 搜索我在簡書的文章，並給出跳轉鏈接，但不支持實時更新。  | 2017/11/12 |
| **聚合搜索**     | [/search](/search)           | 可以同時搜索出我在簡書的文章 & 在飯否的飯嘮，並給出跳轉鏈接。同時支持「高級搜索」，即添加不同的標籤頭，可進行不同的搜索（「fanfou:」搜索飯嘮，「blog:」搜索簡書，「stat:」給出詞條統計，「map:」給出熱力統計）。   | 2017/11/12 |
| 代碼庫搜索      | [/search_code](/search_code)          | 在代碼庫中搜索相關文檔。 | 2017/11/14  |
| 按日期搜索      | [/search_all_by_time](/search_all_by_time)          | 按日期搜索飯嘮或文章。 | 2017/11/15  |
| 書籤搜索      | [/search_bookmark](/search_bookmark)          | 搜索和關鍵字有關的書籤。 | 2018/01/06  |
|-----------------+------------+-----------------+----------------|
| 詞條統計         | [/chart](/chart)                     | 在「匹配某個模式」的飯嘮中，統計各實例的出現次數，並給出跳轉鏈接。 | 2017/11/08 |
|-----------------+------------+-----------------+----------------|
| 熱力地圖         | [/stat](/stat)                       | 展示「某個模式」的出現熱度。 | 2017/11/09 |
| 晚睡指數         | [/calendar](/calendar)               | 根據飯嘮的時間紀錄，展示晚睡情況。點擊可查看當日最晚飯嘮。在[/stat](/stat)中搜「[夜貓子](/calendar)」可跳轉到該頁面。 | 2017/11/09 |
| 觀影熱力圖       | [/movies_heat_map](/movies_heat_map) | 在[/stat](/stat)中搜「[::movies::](/movies_heat_map)」可跳轉到「歷年觀影熱力圖」頁面。 | 2017/11/11 |
| 讀書熱力圖       | [/books_heat_map](/books_heat_map) | 在[/stat](/stat)中搜「[::books::](/books_heat_map)」可跳轉到「歷年開卷熱力圖」頁面。 | 2017/11/12 |
|-----------------+------------+-----------------+----------------|
| 在線雜誌         | [/book](/book)                       | 不清晰，棄！  | 2017/11/09 |
|-----------------+------------+-----------------+----------------|
| 豆瓣電影         | [/movies](/movies)                   | 表格呈現看過的電影。  | 2017/11/11 |
| 豆瓣讀書         | [/books](/books)                     | 表格呈現讀過的書。但還不能實時更新。  | 2017/11/12 |
|-----------------+------------+-----------------+----------------|
| 稍後讀         | [/read-it-later](/read-it-later)       | 點擊書籤[^bookmark]，即可標記該網頁。  | 2017/11/19 |
| 書籤訪問記錄    | [/read-it-later/log](/read-it-later/log)       | 記錄了對書籤的訪問信息 & 搜索記錄。  | 2018/01/06 |
|-----------------+------------+-----------------+----------------|
{: rules="groups"}

[^bookmark]:
	注：書籤🔖內容為：
	
	- 本地測試版：
	
	~~~javascript 
	javascript:function iprl5()%7Bvar d%3Ddocument,z%3Dd.createElement(%27scr%27%2B%27ipt%27),b%3Dd.body,l%3Dd.location%3Btry%7Bif(!b)throw(0)%3Bd.title%3D%27(Saved) %27%2Bd.title%3Bz.setAttribute(%27src%27,%27http%3A%2F%2Flocalhost%3A4567%2Fread-it-later%3Fu%3D%27%2BencodeURIComponent(l.href)%2B%27%26tl%3D%27%2BencodeURIComponent(d.title)%2B%27%26tm%3D%27%2B%28new Date().getTime()))%3Bb.appendChild(z)%3B%7Dcatch(e)%7Balert(%27Please wait until the page has loaded.%27)%3B%7D%7Diprl5()%3Bvoid(0)
	~~~
	
	- 服務器版：
	
	~~~javascript
	javascript:function iprl5()%7Bvar d%3Ddocument,z%3Dd.createElement(%27scr%27%2B%27ipt%27),b%3Dd.body,l%3Dd.location%3Btry%7Bif(!b)throw(0)%3Bd.title%3D%27(Saved) %27%2Bd.title%3Bz.setAttribute(%27src%27,%27http%3A%2F%2F39.108.95.90%3A4567%2Fread-it-later%3Fu%3D%27%2BencodeURIComponent(l.href)%2B%27%26tl%3D%27%2BencodeURIComponent(d.title)%2B%27%26tm%3D%27%2B%28new Date().getTime()))%3Bb.appendChild(z)%3B%7Dcatch(e)%7Balert(%27Please wait until the page has loaded.%27)%3B%7D%7Diprl5()%3Bvoid(0)
	~~~

已實現 API :

功能 | action | API
----|--------|-----
獲取所有書籤 | GET | /read-it-later/api/get
添加書籤 | POST | /read-it-later/api/add?url=`bla bla ...`
修改某個書籤的 title | POST | /read-it-later/api/update?id=`bla bla ...`&title=`bla bla ...`
搜索某個關鍵詞 | GET | /read-it-later/api/search?q=`bla bla ...`
刪除某個書籤 | GET | /read-it-later/api/delete?id=`bla bla ...`

## **挖坑：**{: style="color: red"}

- 將 [/fanfou](/fanfou) 改寫為流頁面；
- 製作網站的移動版本；
- 為小朋友的大作製作視差效果；
- 製作「小朋友學算術」頁面，含 Trachtenberg 速算方法；
- 搜索結果的相關度排序；
- 性能調優；
- 成就系統；
- 修復[/fanfou](/fanfou)刷新問題；
- 把個人書評、影評抓下來，納入搜索；
- 實現「&」搜索；

<!-- 

<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js?config=TeX-MML-AM_CHTML">
</script>

$$
\begin{align*}
  & \phi(x,y) = \phi \left(\sum_{i=1}^n x_ie_i, \sum_{j=1}^n y_je_j \right)
  = \sum_{i=1}^n \sum_{j=1}^n x_i y_j \phi(e_i, e_j) = \\
  & (x_1, \ldots, x_n) \left( \begin{array}{ccc}
      \phi(e_1, e_1) & \cdots & \phi(e_1, e_n) \\
      \vdots & \ddots & \vdots \\
      \phi(e_n, e_1) & \cdots & \phi(e_n, e_n)
    \end{array} \right)
  \left( \begin{array}{c}
      y_1 \\
      \vdots \\
      y_n
    \end{array} \right)
\end{align*}
$$

-->

