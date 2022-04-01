---
sidebar: auto
actionLink: /web/qiankun
---

# 微前端框架-乾坤（qiankun）

## 1、简介

framework-qiankun  是一个基于qiankun + sanhui 的微前端实现库，旨在帮助大家能更简单、无痛的构建一个生产可用微前端架构系统。解决iframe不能解决的问题, 如：

1. url 不同步。浏览器刷新 iframe url 状态丢失、后退前进按钮无法使用。
2. UI 不同步，DOM 结构不共享。想象一下屏幕右下角 1/4 的 iframe 里来一个带遮罩层的弹框，同时我们要求这个弹框要浏览器居中显示，还要浏览器 resize 时自动居中.
3. 全局上下文完全隔离，内存变量不共享。iframe 内外系统的通信、数据同步等需求，主应用的 cookie 要透传到根域名都不同的子应用中实现免登效果。
4. 慢。每次子应用进入都是一次浏览器上下文重建、资源重新加载的过程。



## 2、代码下载

- 主应用下载： [framework-qiankun-v2.0.0-SNAPSHOT.rar](/static/framework-qiankun-v2.0.0-SNAPSHOT.rar)

  <!--注：基础框架包已调整为子应用-->

下载代码包直接运行即可看效果，主应用内嵌`建协云个人端`、`建协云企业端`、`子应用`部分页面。

下载应用用于开发时请删掉 `src/layout/Index.vue`里面的如下代码

![](https://gitee.com/lj107571/imgformd/raw/master/image-20210926154203063.png)

## 3、中台基础框架转为微前端

### 3.1 主应用

1. 安装qiankun

   ````
   $ yarn add qiankun # 或者 npm i qiankun -S
   ````

2. 新建`src/utils/bus.js`代码如下

   ```
   export default new Vue()
   ```

3. 新建 `src/qiankun/index.js` 代码如下

   ```
   import { registerMicroApps, start } from 'qiankun';
   import bus from '@/utils/bus'
   import store from '@/store'
   
   // 将bus挂载在Vue原型，保持父子应用一致
   Vue.prototype.$bus = bus
   
   registerMicroApps([
     {
       name: 'JXYQY', 
       entry: process.env.VUE_APP_JXYQY_WEB,
       container: '#qiankun_jxyqy',
       activeRule: '/jxyqy',
     },
     {
       name: 'JXY', 
       entry: process.env.VUE_APP_JXY_WEB,
       container: '#qiankun_jxy',
       activeRule: '/jxy',
       props: {
         bus,
         systemCode: store.state.systemCode
       }
     }
   ]);
   
   export default start
   ```

5. 新建`src/views/admin/jxy/Index.vue`文件，用于匹配建协云个人端

   ```
   <template>
     <div class="jxy">
       <div id="qiankun_jxy" v-show="!id"></div>
     </div>
   </template>
   
   <script>
   import start from '@/qiankun/index'
   export default {
     data () {
       return {
         id: '',
         type: ''
       }
     },
     mounted () {
       // 启动微前端
       if (!window.qiankunStarted) {
         window.qiankunStarted = true;
         start();
       }
       // 监听代办
       this.$bus.$on('qiankun-backlog', (e) => {
         // 点击代办触发
       })
     },
     beforeDestroy () { // 销毁监听
       this.$bus.$off('qiankun-backlog')
     }
   }
   </script>
   ```

6. 新建`src/views/admin/jxyqy/Index.vue`文件，用于匹配建协云企业端

   ```
   <template>
     <div id="qiankun_jxyqy"></div>
   </template>
   
   <script>
   import start from '@/qiankun/index'
   export default {
     mounted () {
       // 启动微前端
       if (!window.qiankunStarted) {
         window.qiankunStarted = true;
         start();
       }
     }
   }
   </script>
   ```
   
7. 配置上两个文件的路由如下：

   ```
   const Layout = () => import('@/layout/Index')
   
   export default [
     {
       path: '/login',
       meta: { title: '登录', isLogin: false},
       component: SANHUI.Login
     },
     {
       path: '/',
       meta: { title: '布局'},
       name: 'layout',
       component: () => import('@/layout/Index'),
       children: [
         {
           path: '/userInfo',
           meta: { title: '个人信息', isMenu: false},
           component: SANHUI.UserInfo
         },
         ...module,
         {
           path: '/405',
           meta: { title: '405', isLogin: false},
           component: SANHUI.Error405
         },
         {
           path: '/jxy/*',
           meta: { title: '建协云', isMenu: false},
           component: () => import('@/views/admin/jxy/Index')
         },
         {
           path: '/jxyqy/*',
           meta: { title: '建协云企业端', isMenu: false},
           component: () => import('@/views/admin/jxyqy/Index')
         }
       ]
     },
     {
       path: '*',
       meta: { title: '404', isLogin: false},
       component: SANHUI.Error404
     }
   ]
   ```

7. 配置getAccessToken，应用嵌入重新拿token

   在`src/layout/Index.vue`中加入getAccessToken方法，代码如下：

   ​		其中 `ACCESS_TOKEN ` 为 `/getAccessToken` 具体请参考 `中台2.1框架/网页端框架`

   ```
   <template>
     <sh-layout ref="layout" @getAccessToken="getAccessToken">
       <RightNav></RightNav>
     </sh-layout>
   </template>
   
   <script>
   import RightNav from './components/RightNav'
   import { ACCESS_TOKEN } from '@/apis/global'
   export default {
     components: {
       ShLayout: SANHUI.Layout,
       RightNav
     },
     methods: {
       getAccessToken () {
         this.$get(ACCESS_TOKEN)
       }
     }
   }
   </script>
   
   ```







### 3.2 子应用

1. 在配置文件`vue.config.js`中添加 如下代码：

   ```
   // 在devServer中添加允许跨域
   headers: {
   	'Access-Control-Allow-Origin': '*',
   },
   
   // 在configureWebpack/output中添加
   library: `$[name].[hash]`,
   libraryTarget: 'umd', // 把微应用打包成 umd 库格式
   jsonpFunction: `webpackJsonp_[name]`,
   ```

2. 在`src/router/index.js`中修改如下代码：

   ```
   // 注释如下代码
   // const router = new VueRouter({
   //   mode: 'history',
   //   base: process.env.BASE_URL,
   //   routes
   // })
   
   // // 路由守卫
   // router.beforeEach((to, from, next) => {
   //   Vue.prototype.$beforeRouter(to, from, next, process.env, Vue)
   // })
   
   // 抛出routes
   export default routes
   
   ```

3. 在`src/main.js`中修改如下代码

   修改：

   ```
   // import router from './router'
   import routes from './router'
   ```

   删除：

   ```
   
   const vm = new Vue({
     router,
     store,
     render: h => h(App)
   }).$mount('#app')
   
   export default vm
   ```

   添加：（<!--注意：/app为业务系统自定义路由前缀，如建协云为 /jxy-->）

   ```
   // 微前端 - 子应用配置
   let router = null;
   let instance = null;
   
   if (window.__POWERED_BY_QIANKUN__) {
     __webpack_public_path__ = window.__INJECTED_PUBLIC_PATH_BY_QIANKUN__;
   }
   
   
     //下面的 /jxy  与主应用  registerMicroApps 中的  activeRule 字段对应
   function render(props = {}) {
     const { container } = props;
     router = new VueRouter({
       base: window.__POWERED_BY_QIANKUN__ ? '/jxy' : '/',  // 抛出路由加前缀
       mode: 'history',
       routes,
     });
     router.beforeEach((to, from, next) => {
       Vue.prototype.$beforeRouter(to, from, next, process.env, Vue)
     })
     
   
     instance = new Vue({
       router,
       store,
       render: h => h(App),
     }).$mount(container ? container.querySelector('#app') : '#app');
   }
   
   if (!window.__POWERED_BY_QIANKUN__) {
     render();
   }
   export default instance
   
   
   export async function bootstrap() {
     console.log('[vue] vue app bootstraped');
   }
   
   export async function mount(props) {
     //props 包含主应用传递的参数  也包括为子应用 创建的节点信息
     if (props.systemCode) {
       store.state.systemCode = props.systemCode
     }
     render(props);
   }
   
   export async function unmount() {
     instance.$destroy();
     instance = null;
     router = null;
   }
   
   ```
   
4. 新建`src/router/module/other.js`把要嵌入主应用的页面重新抛出

   ```
   export default  {
     path: '/other',
     meta: { title: '布局', isLogin: false},
     component: () => import('@/layout/components/OtherBlankLayout'),
       children: [
       {
         path: '/other/index',
         meta: { title: '首页'},
         component: () => import('@/views/admin/index/Index')
       },
       {
         path: '/other/page',
         meta: { title: '页面1'},
         component: () => import('@/views/admin/page/Index')
       },
       {
         path: '/other/page2',
         meta: { title: '页面2'},
         component: () => import('@/views/admin/page2/Index')
       }
     ]
   }
   ```
   
5. 修`layout/components/OtherBlankLayout.vue`代码如下 (更多请参考：[网页端框架 4-2-抛出嵌入页](/access/web/#_4-2-抛出嵌入页))

   ```
   if (code) { // iframe 嵌入
   	this.getUserInfo(code)
   } else {  // 微前端嵌入
   	this.getUserInfo()
   }
   ```
   
   
   
5. 在<!--所有-->共享资源的script标签加ignore，如

   ```
   <script src="/sanhcdn/vue/dist/vue.min.js" ignore></script>
   ....
   ```
   
   如下：
   
  ![](https://gitee.com/lj107571/imgformd/raw/master/image-20211122102715924.png)

### 3.3 建协云菜单

- 个人端：全部以`/jxy/other/...` 开头，例如： 代办事项：`/jxy/other/backlogList`

- 企业端：全部以`/jxyqy/other/...`开头，例如： 菜单管理：`/jxy/other/selfMenu`

  路由后缀与 [iframe嵌入/4-1-嵌入组织中心、待办](/access/web/#_4-1-嵌入组织中心、待办)保持一致



## 4、服务器配置

### 4.1 nginx 部署

在nginx.config配置：

```
// 允许资源跨域
add_header Access-Control-Allow-Origin *;
add_header Access-Control-Allow-Methods 'GET, POST, OPTIONS';
add_header Access-Control-Allow-Headers 'DNT,X-Mx-ReqToken,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Authorization';

if ($request_method = 'OPTIONS') {
	return 204;
}
// 解决路由history模式下刷新丢失问题
try_files $uri $uri/ /index.html;

```

### 4.2 jenkins 部署

- 在代码里修改`Dockerfile`文件

  ```
  FROM nginx:1.17.3-alpine
  
  MAINTAINER zfe
  
  ENV TZ=Asia/Shanghai
  RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
  
  WORKDIR /
  
  ADD dist/  /usr/share/nginx/html/
  
  ARG PROFILE_ACTIVE
  ENV PROFILE_ACTIVE_ENV $PROFILE_ACTIVE
  
  COPY nginx.conf /etc/nginx/conf.d/default.conf
  
  CMD sed -i "28i\\    gzip_static on;\\n    gzip_proxied expired no-cache no-store private auth; \n" /etc/nginx/nginx.conf && nginx -g 'daemon off;'
  ```

- 在代码根目录新增`nginx.conf`文件

  ```
  server {
      listen       80;
      server_name  localhost;
  
      #charset koi8-r;
      #access_log  /var/log/nginx/host.access.log  main;
  
      location / {
          add_header Access-Control-Allow-Origin *;
          add_header Access-Control-Allow-Methods 'GET, POST, OPTIONS';
          add_header Access-Control-Allow-Headers 'DNT,X-Mx-ReqToken,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Authorization';
  
          if ($request_method = 'OPTIONS') {
              return 204;
          }
          root   /usr/share/nginx/html;
          try_files $uri $uri/ /index.html;
          index  index.html index.htm;
      }
  
      error_page   500 502 503 504  /50x.html;
      location = /50x.html {
          root   /usr/share/nginx/html;
      }
  }
  ```

## 5、应用之间互调

如：代办 （<!--代办配的systemCode要和系统的sysemtCode一致时才会触发微前端，不然则以浏览器标签页的形式打开代办-->）

- 在建协云中

  ```
  // 点击代办-触发事件总线
  this.$bus.$emit('qiankun-backlog', param)
  // 监听代办-刷新列表
  this.$bus.$on('qiankun-backlog-loadList', (e) => {
  	this.loadList()
  })
  ```

- 在业务系统中

  ```
  // 监听代办事件触发
  this.$bus.$on('qiankun-backlog', (e) => {
     // e 代办传过来的参数
  })
  // 触发代办列表刷新
  this.$bus.$emit('qiankun-backlog-loadList')
  
  ```

- 最后在beforeDestroy中销毁监听

  ```
  // 业务系统
    beforeDestroy () { // 销毁监听
      this.$bus.$off('qiankun-backlog')
    }
  // 建协云
    beforeDestroy () { // 销毁监听
      this.$bus.$off('qiankun-backlog-loadList')
    }
  ```

- 微前端待办打开需要配置systemCode与主应用一致

## 6、其他问题

### 6.1 静态资源加载错误

把引入路径改为绝对路径，如

```
<script src="/sanhcdn/vue/dist/vue.min.js"></script>
```



### 6.2 vue-pdf 微前端调用报错

在源码里面的`vuePdfNoSss.vue`里面把

```js
var PdfjsWorker = require('worker-loader!pdfjs-dist/es5/build/pdf.worker.js');		
```

改为

```js
var PdfjsWorker = require('pdfjs-dist/es5/build/pdf.worker.js');
```

在vue.config.js的module.export中添加

```js

chainWebpack: (config) => {
    config.module
    .rule('worker')
    .test(/\.worker\.js$/)
    .use('worker-loader')
    .loader('worker-loader')
    .options({
    inline: true,
    fallback: false
    }).end();
}
```

package.json里添加

```js
"dependencies": {
  ...
  "pdfjs-dist": "2.7.570",
  "vue-resize-sensor": "^2.0.0",
  "worker-loader": "^2.0.0"
}
```


引用方式改为
```js
import pdf from './pdf/vuePdfNoSss'
```


### 6.3 子应用打开会改变主应用项目title

在子应用中：

- 删除`/store/index.js`的

  ```
  state: {
  	projectName: '项目名称'
  	...
  },
  mutations: {
  	projectInfor(state, payload) {
      	state.projectInfor = payload
      },
      ...
  }
  ```

- 删除`main.js`里的

  ```
  document.title = store.state.projectName
  ```

- 在`.env`文件中新增

  ```
  VUE_APP_PROJRCT_NAME = '项目名称'
  ```

- 在`index.html`中新增

  ```
  <title><%= VUE_APP_PROJRCT_NAME %></title>
  ```

  ## 项目中使用了百度地图等组件，会出现在子应用中无法使用

  excludeAssetFilter：(assetUrl: string) => boolean - 可选，指定部分特殊的动态加载的微应用资源（css/js) 不被qiankun 劫持处理

更新qiankun版本至2.0.17,在start中添 excludeAssetFilter，在主应用中引入script标签

建议将地图放到主应用加载，微应用也引入这个地图 js（独立运行时使用），但是给 script 标签加上 ignore 属性

```js
  start({ 
    excludeAssetFilter: (assetUrl) => { 
      const whiteList = [];
      const whiteWords = ['baidu', 'map'];
      if (whiteList.includes(assetUrl)) { return true } 
      return whiteWords.some(w => { return assetUrl.includes(w)})
    }
  })
```



![](https://gitee.com/lj107571/imgformd/raw/master/20220225145649.png)


## qiankun框架中微应用之间如何跳转

1.  通过history.pushState()方式进行跳转

```js
<button onClick={() => {
    window.history.pushState({
       user: {......}
     }, '', '/app1')}
}>跳转</button>
 ```
2.  将主应用的路由实例传递给子应用，子应用使用主应用实例进行跳转











