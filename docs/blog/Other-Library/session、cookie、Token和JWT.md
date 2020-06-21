<!--
 * @Author: Vimalakirti
 * @Date: 2020-06-21 00:26:25
 * @LastEditTime: 2020-06-22 03:33:45
 * @Description: 
 * @FilePath: \vuepress-blog\docs\blog\Other-Library\session、cookie、Token和JWT.md
--> 
众所周知，**HTTP 是一种无状态协议**，即每次客户端发送请求时，对于服务端来说接收到的都是一个全新的请求，因此服务器并不知道客户端的历史请求记录。

简单的，用户登陆一个购物商城，往自己购物车中加入了商品，那么就面临一个问题，要区分都有哪些人登陆过商城，哪些人往自己的购物车中放商品。因此网站需要管理这些会话。

而cookie，session, token就是用来管理会话的手段。

## Cookie
cookie 是一个非常具体的东西，指的就是浏览器里面能永久存储的一种数据，仅仅是浏览器实现的一种数据存储功能。

- cookie 存储在客户端：cookie是由服务器生成发送到客户端，客户端以key-value形式保存在本地的一小块数据，在下一次请求同一网站时会把该cookie发送给服务端。
- cookie为不可跨域的：每个 cookie 都会绑定单一的域名，无法在别的域名下获取使用，一级域名和二级域名之间是允许共享使用的（靠的是 domain）。

### Cookie 中的重要参数
| 参数 | 说明 | 后端 |
| :------: | :------: | :------: |
| Domain | 指定 cookie 所属域名，默认是当前域名 | ```cookie.setDomain("")``` |
| Max-Age | 设置cookie的过期时间，单位为秒 | ```cookie.setMaxAge(10)``` |
| Path | 指定 cookie 在哪个路径（路由）下生效，默认是 '/' | ```cookie.setPath("")```|
| HttpOnly | 如果给某个 cookie 设置了 httpOnly 属性，则无法通过 JS 脚本 读取到该 cookie 的信息，但还是能通过 Application 中手动修改 cookie，所以只是在一定程度上可以防止 XSS 攻击，不是绝对的安全 | ```cookie.setHttpOnly(true)```|
| Secure | 告诉浏览器此Cookie只能在Https安全协议中传输,如果是Http则禁止传输 | ```cookie.setSecure(true)```|

### 使用 cookie 时存在的问题
- 不要存储敏感数据，比如用户密码，账户余额，因为存储在客户端，容易被客户端篡改，使用前需要验证合法性
- 能存储的数据量不能超过 4kb
- 一个浏览器针对一个网站最多存 20 个Cookie，浏览器一般只允许存放 300 个Cookie
- 移动端对 cookie 的支持不是很好，而 session 需要基于 cookie 实现，所以移动端常用的是 token

## Session
session翻译过来就是会话的意思，这就像是我们日常聊天中，我们如何知道对方是谁呢，我们一般会给对方加个备注（是老王还是二狗子）。

session也是类似的道理。服务器要知道当前发请求给自己的是谁。为了做这种区分，服务器就要给每个客户端分配不同的“身份标识”，然后客户端每次向服务器发请求的时候，都带上这个“身份标识”，服务器就知道这个请求来自于谁了。至于客户端怎么保存这个“身份标识”，可以有很多种方式，对于浏览器客户端，大家都默认采用 cookie 的方式。

- session 是另一种记录服务器和客户端会话状态的机制
- **session 是基于 cookie 实现的**。session 存储在服务器端，可以理解为一个状态列表，他拥有一个唯一识别符号sessionId，通常存放于cookie中

### Session 认证流程
![](https://i.loli.net/2020/06/22/NoYOeS4sBX3vhtk.png)

- 首先，客户端会发送一个http请求到服务器端。
- 服务端接收请求后，创建对应的 session ，并发送一个http响应到客户端，这个响应头，其中就包含 Set-Cookie 头部。该头部包含了sessionId。
- 浏览器接收到服务端返回的 sessionId 后，将此信息存入 cookie ，同时 Cookie 记录此 SessionID 属于哪个域名。
- 当用户第二次发起请求时，请求会自动判断此域名下是否存在 Cookie 信息，如果存在浏览器会自动在请求头中添加 cookie 发送到服务端
- 服务端接收请求，会从 Cookie 中获取 sessionId，再根据 sessionId 查找对应的 Session 信息，如果没有找到说明用户没有登录或者登录失效，如果找到 Session 证明用户已经登录可执行后面操作。

通过上面的流程我们可以知道，session 认证流程是由**服务端session + 客户端 sessionId**完成，所以说  **sessionId 是连接 Cookie 和 Session 的一道桥梁**

### 有了 Cookie 为什么还要 Session

- 使用 session 只需要在客户端保存一个 sessionId，实际上大量数据都是保存在服务端。如果全部用 cookie，数据量大的时候客户端是没有那么多空间的（ 单个 Cookie 保存的数据不能超过 4K，Session 可存储数据远高于 Cookie）。
- 全部在客户端保存，服务端无法验证，这样伪造和仿冒会更加容易。（伪造一个随机的id很难，但伪造另一个用户名是很容易的）
- cookie 只是实现 session 的其中一种方案。虽然是最常用的，但并不是唯一的方法。(禁用cookie后还有其他方法存储，比如放在url中,但放在url中涉及安全性和SEO的影响)
- 全部保存在客户端，那么一旦被劫持，全部信息都会泄露
- 客户端数据量变大，网络传输的数据量也会变大

## 使用 session 存在的问题
- session 存储在服务器里面，当用户同时在线量比较多时，这些 session 会占据较多的内存，需要在服务端定期的去清理过期的 session
- 移动端对 cookie 的支持不是很好，而 session 需要基于 cookie 实现，所以移动端常用的是 token
- 扩展性不好：例如互联网公司为了可以支撑更大的流量，后端往往需要多台服务器共同来支撑前端用户请求，那如果用户在 A 服务器登录了，第二次请求跑到服务 B 就会出现登录失效问题。（解决方法：```Nginx ip_hash 策略、Session 复制、共享 Session```）

## Token
- Token是在客户端频繁向服务端请求数据，服务端频繁的去数据库查询用户名和密码并进行对比，判断用户名和密码正确与否，并作出相应提示，在这样的背景下，Token便应运而生。
- **简单 token 的组成**:uid(用户唯一的身份标识)、time(当前时间的时间戳)、sign（签名，token 的前几位以哈希算法压缩成的一定长度的十六进制字符串）

### token认证流程

![](https://i.loli.net/2020/06/22/BmTjgWclMARo1PQ.png)
1. 客户端使用用户名跟密码请求登录
2. 服务端收到请求，去验证用户名与密码
3. 验证成功后，服务端签发一个 token ，并把它发送给客户端
4. 客户端接收 token 以后会把它存储起来，比如放在  cookie 里或者 localStorage 里
5. 客户端每次发送请求时都需要带着服务端签发的 token（把 token 放到 HTTP 的 Header 里）
6. 服务端收到请求后，需要验证请求里带有的 token ，如验证成功则返回对应的数据

>基于 token 的用户认证是一种服务端无状态的认证方式，服务端不用存放 token 数据。用解析 token 的计算时间换取 session 的存储空间，从而减轻服务器的压力，减少频繁的查询数据库

### Refresh Token
前面讲的 token，都是 acesss token，也就是访问资源接口时所需要的 token，还有另外一种 token——refresh token，refresh token 是专门用来刷新 access token 的 token。

**为什么有了 access token 还要 refresh token 呢？**

因为一般情况下，Refresh Token的有效期会比较长。而Access Token的有效期比较短，当Acesss Token由于过期而失效时，使用Refresh Token就可以获取到新的Token，设想一下如果没有 refresh token 每次刷新 access token 时，都要用户输入登录用户名与密码，会很麻烦。有了 refresh 可以减少这个麻烦，客户端直接用 refresh token 去更新 access token，无需用户进行额外的操作。当然了，如果Refresh Token也失效了，用户就只能重新登录了。

refresh token 及过期时间是存储在服务器的数据库中，只有在申请新的 Acesss Token 时才会验证，不会对业务接口响应时间造成影响，也不需要向 Session 一样一直保持在内存中以应对大量的请求。

![](https://i.loli.net/2020/06/22/aqQCVPLsgkO1DNE.jpg)



参考：
[傻傻分不清之 Cookie、Session、Token、JWT](https://juejin.im/post/5e055d9ef265da33997a42cc)、[你真的了解 Cookie 和 Session 吗](https://juejin.im/post/5cd9037ee51d456e5c5babca)、[有了 Cookie 为什么还要有 Session](https://segmentfault.com/q/1010000016504003)
