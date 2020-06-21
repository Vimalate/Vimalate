<!--
 * @Author: Vimalakirti
 * @Date: 2020-06-21 00:26:25
 * @LastEditTime: 2020-06-21 01:47:33
 * @Description: 
 * @FilePath: \vuepress-blog\docs\blog\Other-Library\session、cookie、Token和JWT.md
--> 
## Cookie
众所周知，HTTP 是一种无状态协议，即每次客户端发送请求时，对于服务端来说接收到的都是一个全新的请求，因此服务器并不知道客户端的历史请求记录。

简单的，用户登陆一个购物商城，往自己购物车中加入了商品，那么就面临一个问题，要区分都有哪些人登陆过商城，哪些人往自己的购物车中放商品。网站需要管理这些会话。

而cookie，session, token就是用来管理会话的手段。

HTTP Cookie（也叫 Web Cookie或浏览器 Cookie）是服务器发送到用户浏览器并保存在本地的一小块数据，它会在浏览器下次向同一服务器再发起请求时被携带并发送到服务器上。通常，它用于告知服务端两个请求是否来自同一浏览器，如保持用户的登录状态。Cookie 使基于无状态的 HTTP 协议记录稳定的状态信息成为了可能。


参考：[傻傻分不清之 Cookie、Session、Token、JWT](https://juejin.im/post/5e055d9ef265da33997a42cc)、[你真的了解 Cookie 和 Session 吗](https://juejin.im/post/5cd9037ee51d456e5c5babca)
