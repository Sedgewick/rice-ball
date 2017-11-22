<link rel="stylesheet" href="/css/markdown.css">
<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.1.0/styles/tomorrow-night.min.css">
<script src="http://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.1.0/highlight.min.js"></script>    
<script>hljs.initHighlightingOnLoad();</script>

# 代碼庫之「 CSS 的那些高級技巧」

## Tips:

### 1. `:before`偽元素

可以在元素之前插入點什麼。文檔看[這](http://www.w3school.com.cn/cssref/pr_pseudo_before.asp)。

對應的有`:after`偽元素，文檔看[這](http://www.w3school.com.cn/cssref/pr_pseudo_after.asp)。


### 2. `nth-child(n)`選擇器

`n`可以是數字、關鍵詞（比如：`odd`或`even`，從 1 開始計數）或公式（比如：`3n+1`，`n`從 0 開始計算）。文檔看[這](http://www.w3school.com.cn/cssref/selector_nth-child.asp)。

還有一個叫`nth-of-type(n)`的選擇器，沒搞懂她倆之間關係是啥。文檔看[這](http://www.w3school.com.cn/cssref/selector_nth-of-type.asp)。


### 3. `display: table`

[這篇](http://www.frontopen.com/331.html)講得還可以吧。

除了規避了`<table>`標籤的語意困境，據說還會有響應式佈局方面的好處：

~~~html
<style>
	.boxes {
		width:50%;
		margin:0 auto;
		font-family: Arial;
		font-variant: small-caps;
	}
	.box {
		display:inline-block;
		width:24%;
		text-align:center;
		line-height:15em;
		color:#fff;
	}
	.one { background:#333;	}
	.two { 
		background:#fff;
		color:#333;
	}
	.three { background:#aaa; }
	.four { background:#dc002e; }

	/* 768px */
	@media screen and (max-width:48em) {
		.boxes { 
			display:table;
			width:100%;
		}
		.box {
			display:block;
			width:100%;
		}
		.three { display:table-caption; }
		.four { display:table-header-group; }
		.one { display:table-footer-group; }
	}
</style>

<div class="boxes">
	<div class="one box">Box One</div>
	<div class="two box">Box Two</div>
	<div class="three box">Box Three</div>
	<div class="four box">Box Four</div>
</div>
~~~

當你把頁面壓窄，佈局會變：

<style>
	.boxes {
		width:50%;
		margin:0 auto;
		font-family: Arial;
		font-variant: small-caps;
	}
	.box {
		display:inline-block;
		width:24%;
		text-align:center;
		line-height:15em;
		color:#fff;
	}
	.one { background:#333;	}
	.two { 
		background:#fff;
		color:#333;
	}
	.three { background:#aaa; }
	.four { background:#dc002e; }

	/* 768px */
	@media screen and (max-width:48em) {
		.boxes { 
			display:table;
			width:100%;
		}
		.box {
			display:block;
			width:100%;
		}
		.three { display:table-caption; }
		.four { display:table-header-group; }
		.one { display:table-footer-group; }
	}
</style>

<div class="boxes">
	<div class="one box">Box One</div>
	<div class="two box">Box Two</div>
	<div class="three box">Box Three</div>
	<div class="four box">Box Four</div>
</div>

抄的這篇[「CSS stacking with display:table」](http://www.iandevlin.com/blog/2013/06/css/css-stacking-with-display-table/)。

有點奇怪的是：指定`display: table-cell`以後`margin`屬性會消失🧐


----

CSS 真是強大啊！！！