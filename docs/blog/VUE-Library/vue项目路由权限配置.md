<!--
 * @Author: Vimalakirti
 * @Date: 2020-06-08 20:04:05
 * @LastEditTime: 2020-07-01 21:52:45
 * @Description: 
 * @FilePath: \vuepress-blog\docs\blog\VUE-Library\vue项目路由权限配置.md
--> 
## 接口访问的权限控制
接口权限就是对用户的校验。正常来说，在用户登录时服务器需要给前台返回一个Token,然后在以后前台每次调用接口时都需要带上这个Token,

然后服务端获取到这个Token后进行比对，如果通过则可以访问。

在axios中可以在拦截器中直接将Token塞入config.headers.Authorization中，作为全局传入。下面是代码部分：
```js
//main.js
import axios from 'axios'

// 实例化Axios，并进行超时设置
const service = axios.create({
    timeout: 5000
})
// baseURL
// axios.defaults.baseURL = 'https://api.github.com';

// http request 拦截器
// 每次请求都为http头增加Authorization字段，其内容为token
service.interceptors.request.use(
    config => {
        if (store.state.user.token) {
            config.headers.Authorization = `token ${store.state.user.token}`;
        }
        return config
    },
    err => {
        return Promise.reject(err)
    }
);
export default service
```
登录：当用户填写完账号和密码后向服务端验证是否正确，验证通过之后，服务端会返回一个token，拿到token之后（我会将这个token存贮到cookie中，保证刷新页面后能记住用户登录状态），前端会根据token再去拉取一个 user_info 的接口来获取用户的详细信息（如用户权限，用户名等等信息）。
权限验证：通过token获取用户对应的 role，动态根据用户的 role 算出其对应有权限的路由，通过 router.addRoutes 动态挂载这些路由。

## 动态路由权限控制方式
1. 登录时获取 token 保存到本地，然后前端获取用户信息时携带 token ，从而获取当前用户的角色信息
2. 前端根据获取到的角色信息计算出相应的路由表拼接到常规路由表后

## 用户登录生成动态路由流程

![](https://gitee.com/lj107571/imgformd/raw/master/20201012110546.png)


## 动态路由生成全过程

![](https://gitee.com/lj107571/imgformd/raw/master/20201012112958.png)

[手摸手，带你用vue撸后台 系列二(登录权限篇)](https://juejin.im/post/591aa14f570c35006961acac)