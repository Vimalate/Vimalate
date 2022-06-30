## 打包分析

在 package.json 中添加命令 ```"report": "vue-cli-service build --report"```

然后命令行执行 ```npm run report```，就会在dist目录下生成一个 report.html 文件，右键浏览器中打开即可看到打包分析报告。

下面我们可以针对报告中的问题逐一进行优化

## 路由懒加载

vue 中使用

```js
component: () => import("views/home/Home.vue"),
```

## vue.config.js  修改 productionSourceMap 为 false

```js
productionSourceMap: false
```

## 首屏请求优化

vue 脚手架默认开启了 preload 与 prefetch，当我们项目很大时，这个就成了首屏加载的最大元凶了

- preload 与 prefetch 都是一种资源预加载机制；
- preload 是预先加载资源，但并不执行，只有需要时才执行它；
- prefetch 是意图预获取一些资源，以备下一个导航/页面使用；
- preload 的优先级高于 prefetch。

原先项目首页近六百个请求，设置后降到一百左右，减少了http的连接，当然也减少了首屏加载时间。

```js
//vue.config.js
chainWebpack(config) {
  config.plugins.delete('preload') // 删除默认的preload
  config.plugins.delete('prefetch') // 删除默认的prefetch
}
```

## 配置使用 CDN 方式引入资源库

```js
//vue.config.js
  configureWebpack: config => {
    config.resolve = {
      // 使用 CDN 的包不用打包到文件中
      externals: {
        // 这里的 element-ui 是 import xx from yy 中的 yy 包名。ELEMENT 是文件导出的全局变量名字
        'element-ui': 'ELEMENT',
      },
    },
  },
  chainWebpack: config => {
    // 添加 CDN 参数到 htmlWebpackPlugin 配置中
    config.plugin('html').tap(args => {
      args[0].cdn = {
        js: [
          'https://xx.com/CDN/js/index-element-ui@2.13.0.js',
        ],
        css: [
          'https://xx.com/CDN/css/element-ui2.13.0/index.css',
        ],
      };
      return args;
    });
  },
```

**然后在 index.html 中挂载 CDN：**

```js
<!DOCTYPE html>
<html lang="zh">
  <head>
    <% for (var i in htmlWebpackPlugin.options.cdn&&htmlWebpackPlugin.options.cdn.css) { %>
    <link href="<%= htmlWebpackPlugin.options.cdn.css[i] %>" rel="preload" as="style">
    <link href="<%= htmlWebpackPlugin.options.cdn.css[i] %>" rel="stylesheet">
    <% } %>
    <!-- 使用 CDN 加速的 JS 文件，配置在 vue.config.js 下 -->
    <% for (var i in htmlWebpackPlugin.options.cdn&&htmlWebpackPlugin.options.cdn.js) { %>
    <script src="<%= htmlWebpackPlugin.options.cdn.js[i] %>" type="text/javascript"></script>
    <% } %>
  </head>
  <body>
    <div id="app"></div>
  </body>
</html>
```

## 开启 gzip 压缩

安装依赖

```js
npm install compression-webpack-plugin --save-dev
```

```js
//vue.config.js
const CompressionPlugin = require('compression-webpack-plugin');
 
module.exports = {
  configureWebpack: config => {
    config.plugins = [
      ...config.plugins,
      // 开启 gzip 压缩
      new CompressionPlugin({
        filename: '[path][base].gz',
        algorithm: 'gzip',
       test: /\.js$|\.html$|\.css$|\.jpg$|\.jpeg$|\.png/, // 需要压缩的文件类型
        threshold: 10240,
        minRatio: 0.8
      })
    ]
  }
}
```

 nginx 相应进行配置：

 ```
 http {
 
    gzip on; # 开启 gzip 压缩
    gzip_static on; # 若存在静态 gz 文件，则使用该文件
    gzip_min_length 10k; # 设置允许压缩的页面最小字节数
    gzip_buffers 16 8k; # 设置用于处理请求压缩的缓冲区数量和大小
    gzip_comp_level 1; # 设置压缩级别 1-9，数字越大，压缩后的大小越小，也越占用CPU，花费时间越长
	# 对特定的 MIME 类型生效, 其中'text/html’被系统强制启用
    gzip_types application/javascript text/css font/ttf font/x-woff;
    gzip_vary on; # 是否在 http header中 添加 Vary:Accept-Encoding, on | off
    gzip_http_version 1.1; # 在 http/1.1 的协议下不开启压缩
}
```


[vue 开发中必备的 cli 配置](https://blog.csdn.net/qq_39025670/article/details/110951945)