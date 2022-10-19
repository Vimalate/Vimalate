## 使用 CancelToken

```js
const CancelToken = axios.CancelToken;
const source = CancelToken.source();

axios.interceptors.request.use(
    config => {
        config.cancelToken = source.token; // 全局添加cancelToken
            return config;
        },
        err => {
            return Promise.reject(err);
        }
   );
/** 设置响应拦截 **/
axios.interceptors.response.use(
    response => {
        // 登录失效101
        if ( response.data.code===101) {
            source.cancel(); // 取消其他正在进行的请求
            setTimeout(() => { // 重新赋值,保证后续操作的请求可正常发送
              source = axios.CancelToken.source()
            }, 1000)
           // some coding
        }
        return response;
    },
    error => {
        if (axios.isCancel(error)) { // 取消请求的情况下，终端Promise调用链
            return new Promise(() => {});
        } else {
            return Promise.reject(error);
        }
    }
);
```