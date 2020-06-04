<!--
 * @Author: your name
 * @Date: 2020-04-03 01:45:05
 * @LastEditTime: 2020-06-04 15:04:36
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vuepress-blog\docs\blog\HTML-Library\HTML-Study.md
--> 
# HTML基础
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

## 
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