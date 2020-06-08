<!--
 * @Author: Vimalakirti
 * @Date: 2020-06-08 20:04:05
 * @LastEditTime: 2020-06-08 23:51:31
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