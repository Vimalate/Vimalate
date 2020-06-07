<!--
 * @Author: your name
 * @Date: 2020-04-03 01:45:05
 * @LastEditTime: 2020-06-07 16:17:53
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vuepress-blog\docs\blog\HTML-Library\HTML-Study.md
--> 

## doctype的作用
doctype 是 html5 标准网页声明，且必须声明在文档第一行。用来告知浏览器的解析器以什么文档标准解析这个文档，不同的渲染模式会影响到浏览器对于 CSS 代码甚至 JavaScript 脚本的解析。

文档解析类型：
- BackCompat：怪异模式，浏览器使用自己的怪异模式解析渲染页面。（如果没有声明DOCTYPE，默认就是这个模式）。他会模拟更旧的浏览器的行为
- CSS1Compat：标准模式，浏览器使用W3C的标准解析渲染页面

## HTML语义化的理解
语义化指用恰当语义的 html 标签，让页面有更好的结构与含义。

语义化的好处有：
- 开发者友好：使用语义类标签增强了可读性，开发者也能够清晰地看出网页的结构，也更为便于团队的开发和维护
- 机器友好：带有语义的文字表现力丰富，有利于 seo ，更适合搜索引擎的爬虫爬取有效信息，语义类还可以支持读屏软件，根据文章可以自动生成目录

## script标签中defer和async的区别
- defer：浏览器并行（异步加载脚本）加载js文件，会按照页面上script标签的顺序执行
- async：浏览器并行（异步加载脚本）加载js文件，下载完成立即执行，不会按照页面上script标签的顺序执行

## html5新特性
- ```canvas``` 绘画
- video、audio 媒介
- 本地离线存储 ```localStorage```
- 语义化更好的元素：```article、footer、header、nav、section```
- 表单控件：```calender、date、email```
- 新的技术：```webworker、websocket、Geolocation```

## 行内元素，块级元素，以及空(void)元素
- 行内元素：```span、input、select、a、b```
- 块级元素：```div、ul、li、p、h1...```
- 空元素：```<br> <hr> <img> <input> <link> <meta>```
- 行内元素不能设置宽高，不独占一行
- 块级元素可以设置宽高，独占一行

## viewport
```css
 <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    // width    设置viewport宽度，为一个正整数，或字符串‘device-width’
    // device-width  设备宽度
    // height   设置viewport高度，一般设置了宽度，会自动解析出高度，可以不用设置
    // initial-scale    默认缩放比例（初始缩放比例），为一个数字，可以带小数
    // minimum-scale    允许用户最小缩放比例，为一个数字，可以带小数
    // maximum-scale    允许用户最大缩放比例，为一个数字，可以带小数
    // user-scalable    是否允许手动缩放
```
## script放在body头部就一定会阻塞吗
js属于单线程，渲染线程(GUI)和js引擎线程互斥。当我们加载script标签时，渲染引擎会暂停，因为script标签里内容可能会操作DOM，所以如果你加载script标签又同时渲染页面肯定就冲突了。

>引用```css```时使用```@import```也会

**正常情况**

```<script src="index.js"></script>```
这种情况下 JS 会阻塞浏览器，浏览器必须等待 index.js 加载和执行完毕才能去做其它事情。

**async(异步)**
```<script async src="index.js"></script>```
async 模式下，JS 不会阻塞浏览器做任何其它的事情。它的加载是异步的，当它加载结束，JS 脚本会立即执行。

**defer(延缓)**
```<script defer src="index.js"></script>```
defer模式下，加载是异步的，执行被推迟。他得等到整个文档解析完成，也就是 DOMContentLoaded 事件即将触发时，被标记的defer的js文件才会依次执行

所以在我们的开发过程中，当我们的脚本与DOM元素和其他脚本依赖不强时，使用```async```,当脚本依赖于 DOM 元素和其它脚本的执行结果时，我们会选用 ```defer```。

##  src 和 href 的区别？

href 时指向网络资源所在位置，建立和当前元素（锚点）或当前文档（链接）之间的链接，用于超链接。
src 时指向外部的资源位置，指向的内容将会嵌入到文档中当前标签所在位置；在请求 src 资源时会将其指向的资源下载并应用到文档内，例如 js 脚本，img 图片和 frame 等元素。**当浏览器解析到该元素时，会暂停其他资源的下载和处理，直到将该资源加载、编译、执行完毕**，图片和框架等元素也是如此，类似于将所指向资源嵌入当前标签内。这也是为什么将 js 脚本放在底部而不是头部。

## cookies、session、sessionStorage、localStorage

- cookies : 存储于浏览器，可以设置 cookies 的到期时间，若不设置，关闭浏览器窗口，cookie就会消失。
- session ： 存储于服务端，session 存储特定用户会话所需的属性和配置信息。

- cookie 和 session 区别：

1. cookies 数据存放在客户的浏览器上，session 数据存放在服务器上
   
2. cookie不是很安全，别人可以分析存放在本地的cookie并进行cookie欺骗，考虑到安全应当使用session 
   
3. ession 如果在生效期访内量过大，会占用服务器性能
   
4. session中保存的是对象，cookie中保存的是字符串 

***

- **sessionStorage** ：仅在当前浏览器窗口关闭之前有效
- **localStorage** ：始终有效，窗口或浏览器关闭也一直保存，因此用作持久数据

**不同 ：sessionStorage不在不同的浏览器窗口中共享，即使是同一个页面；localstorage在所有同源窗口中都是共享的；cookie也是在所有同源窗口中都是共享的**

## 用一个div模拟textarea的实现

`textarea` 经常的被我们用来作为文本域功能，但他有一个不足就是不能像普通div标签一样高度可以跟随内容自适应，那么这时我们可以用 div 来进行实现。

使用很简单，一个普通的block元素上加个contenteditable="true"就ok了

`<div contenteditable="true"></div>`

<Vssue/>