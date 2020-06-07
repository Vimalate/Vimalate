<!--
 * @Author: Vimalakirti
 * @Date: 2020-06-06 21:30:05
 * @LastEditTime: 2020-06-07 15:23:40
 * @Description: 
 * @FilePath: \vuepress-blog\docs\blog\Other-Library\Git Document Library\webpack面试题.md
--> 

## webpack与grunt、gulp的不同

grunt、gulp 是基于任务运行的工具，他会像流水线一样，通过不同插件对资源进行加工，自动执行指定的任务。

Webpack是基于模块化打包的工具：

Webpack 把一切当成模块，当webpack处理应用程序时，它会递归构建出一个依赖关系图，这其中包括应用程序需要用到的每个模块。然后讲这些模块打包成一个或多个bundle。
##  Loader和Plugin的区别
```Loader```:本质是一个函数，对接收的内容进行转换，返回转换后的结果。由于webpack只认识js，所以Loader相当于一个翻译官的角色。对接收内容进行预处理。

```Plugin```:即插件，基于事件流框架 ```Tapable```,插件用来扩展webpack的功能。在webpack运行的生命周期会广播许多事件。Plugin能够监听这些事件，在合适的时机通过webpack提供的api改变输出结果。

## 有哪些常见的Loader
- ```file-loader```:把文件输出到一个文件夹中，在代码中通过相对URL去引用输出的文件。
- ```source-map-loader```:和file-loader 相似，区别是用户可以设置一个阈值，大于阈值会交给 file-loader 处理，小于阈值时返回文件 base64 形式编码 (处理图片和字体)
- ```image-loader```:加载并且压缩图片
- ```babel-loader```:ES6转换为ES5
- ```css-loader```:加载css,支持模块化，压缩，文件导入等特性
- ```sass-loader```：将SCSS/SASS代码转换成CSS
- ```style-loader```:把css代码注入到JavaScript中，通过DOM操作去加载css
- ```eslint-loader```：通过 ESLint 检查 JavaScript 代码
- ```vue-loader```：加载 Vue.js 单文件组件
  
## 有哪些常见的Plugin
- ```define-plugin```:定义环境变量
- ```ignore-plugin```:忽略部分文件
- ```html-webpack-plugin```:简化html创建（依赖于 html-plugin）
- ```terser-webpack-plugin```:压缩ES6代码
- ```webpack-parallel-uglify-plugin```: 多核压缩,提高压缩速度
- ```webpack-bundle-analyzer```:可视化webpack输出文件的体积
- ```mini-css-extract-plugin```: CSS提取到单独的文件中,支持按需加载
  
## Webpack构建流程
Webpack 的运行流程是一个串行的过程，从启动到结束会依次执行以下流程：
1.  初始化：从配置文件和shell语句中读取与合并参数，得出最终的参数
2.  开始编译：用上一步得到的参数初始化```Complier``` 对象，加载所有配置的插件。执行对象的run方法开始编译。
3.  确定入口：根据配置的entry找出所有的入口文件。
4.  编译模块：从入口文件出发，对所有配置的loader对模块进行翻译，再找出依赖的模块递归此本步骤知道所有依赖文件进行了本步骤的处理
5.  完成模板编译：经过上一步骤后，得到了每个模块被翻译后的最终内容以及他们之间依赖的关系。
6.  输出资源：根据入口和模块之间的依赖关系，组装成一个个包含多个模块的 Chunk，再把每个 Chunk 转换成一个单独的文件加入到输出列表，这步是可以修改输出内容的最后机会；
7.  出完成：在确定好输出内容后，根据配置确定输出的路径和文件名，把文件内容写入到文件系统。

**简单版本**

- 初始化：启动构建，读取合并配置参数，加载plugin，实例化Complier
- 编译：从entry出发，针对每个Moudle串行调用对应的loader去翻译，在找到Moudle依赖的Moudle，递归的进行编译处理
- 输出：对编译后的Moudle组合成chunk，把chunk转换成文件，输出到本地

## Webpack 的热更新原理
简单来说就是这个机制可以使我们不用刷新浏览器而将变更的模块替换从旧的模块

HMR的核心就是客户端从服务端拉去更新后的文件，准确的说是 chunk diff (chunk 需要更新的部分)，实际上 WDS 与浏览器之间维护了一个 Websocket，当本地资源发生变化时，WDS 会向浏览器推送更新，并带上构建时的 hash，让客户端与上一次资源进行对比。客户端对比出差异后会向 WDS 发起 Ajax 请求来获取更改内容(文件列表、hash)，这样客户端就可以再借助这些信息继续向 WDS 发起 jsonp 请求获取该chunk的增量更新。

后续的部分(拿到增量更新之后如何处理？哪些状态该保留？哪些又需要更新？)由 HotModulePlugin 来完成，提供了相关 API 以供开发者针对自身场景进行处理，像react-hot-loader 和 vue-loader 都是借助这些 API 实现 HMR。

## webpack打包原理
将所有依赖打包成一个bundle.js,通过代码分割成单元片段按需加载

## 如何用webpack来优化前端性能
用webpack优化前端性能是指优化webpack的输出结果，让**打包的最终结果在浏览器运行快速高效。**

- cdn加速：在构建过程中，将引用的静态资源路径修改为CDN上对应的路径。可以利用webpack对于output参数和各loader的publicPath参数来修改资源路径
- 压缩代码：删除多余的代码、注释、简化代码的写法等等方式。可以利用webpack的UglifyJsPlugin和ParallelUglifyPlugin来压缩JS文件， 利用cssnano（css-loader?minimize）来压缩css
- Tree shaking: 将代码中永远不会走到的片段删除掉。可以通过在启动webpack时追加参数--optimize-minimize来实现
- Code Splitting: 将代码按路由维度或者组件分块(chunk),这样做到按需加载,同时可以充分利用浏览器缓存
- 提取公共第三方库:  SplitChunksPlugin插件来进行公共模块抽取,利用浏览器缓存可以长期缓存这些无需频繁变动的公共代码

## 提高webpack的打包速度
- happypack: 利用进程并行编译loader,利用缓存来使得 rebuild 更快,遗憾的是作者表示已经不会继续开发此项目,类似的替代者是thread-loader
- 利用缓存: webpack.cache、babel-loader.cacheDirectory、HappyPack.cache都可以利用缓存提高rebuild效率
- 缩小文件搜索范围: 比如babel-loader插件,如果你的文件仅存在于src中,那么可以include: path.resolve(__dirname, 'src'),当然绝大多数情况下这种操作的提升有限,除非不小心build了node_modules文件
- 外部扩展(externals): 将不怎么需要更新的第三方库脱离webpack打包，不被打入bundle中，从而减少打包时间,比如jQuery用script标签引入

## 怎么配置单页应用？怎么配置多页应用
我们日常开发用的基本都是单页应用，webpack的标准模式也是单页应用，直接在entry中指定单页应用的入口即可
```
module.exports = {
    entry: './path/to/my/entry/file.js'
}
```
多页应用的话，可以使用webpack的 AutoWebPlugin来完成简单自动化的构建，但是前提是项目的目录结构必须遵守他预设的规范

```
module.entrys = {
    entry: {
        pageOne: './src/pageOne/index.js',
        pageTwo: './src/pageTwo/index.js'
    }
}
```


参考：[webpack 面试](https://juejin.im/post/5e6f4b4e6fb9a07cd443d4a5#heading-15)、[霖呆呆的近期中大厂面试汇总](https://github.com/LinDaiDai/niubility-coding-js/blob/master/%E6%AF%8F%E6%97%A5%E4%B8%80%E9%A2%98/%E9%9C%96%E5%91%86%E5%91%86%E7%9A%84%E8%BF%91%E6%9C%9F%E4%B8%AD%E5%A4%A7%E5%8E%82%E9%9D%A2%E8%AF%95%E6%B1%87%E6%80%BB.md)