## HTML基础

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