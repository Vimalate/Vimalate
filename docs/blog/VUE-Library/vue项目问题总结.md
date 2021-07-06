<!--
 * @Author: Vimalakirti
 * @Date: 2020-04-09 23:03:50
 * @LastEditTime: 2020-08-06 22:43:12
 * @Description: 
 * @FilePath: \vuepress-blog\docs\blog\VUE-Library\vue项目问题总结.md
--> 
## vue加scoped后就无法修改vant的UI组件的样式

一些时候UI组件提供的默认的样式不能满足项目的需要，就需要我们对它的样式进行修改，但是发现加了scoped后修改的样式不起作用。

>注：div中使用v-html，里面的图片溢出也是同样解决方法

**解决方法：**
```css
<style scoped>
  .a >>> .b { /* ... */ }
</style>
```
以上的代码会编译成：```.a[data-v-f3f3eg9] .b { /* ... */ }```

使用Less或Sass等预处理器，可能无法>>>正确解析
这时可以```/deep/```
```css
.brandList {
    /deep/.van-grid-item__content {
      padding: 0;
    }
  }
```

## van-tree-select 设置剩余高度

```css
<van-tree-select height="calc(100vh - 114px)" :items="categoryList" :main-active-index.sync="active">
```

使用 ```height="calc(100vh - 114px)"``` 114px 为上下 tab 所占高度
## calc 计算高度

```height: calc( 100vh - 36px );``` calc 里面记得空格，否则不生效

## Vue中使用this.$forceUpdate()强制刷新渲染

当使用了v-for嵌套循环，外层循环了一个数组，且外层数组中的每一项底下又有一个子项的数组，并且当外层列表是不变的，而内部的子项列表确是在动态改变时

**出现改变子项数组元素后，页面并没有被及时渲染改变的问题**

[参考及解决](https://www.w7.wiki/develop/2971.html)

## postcss-pxtorem
postcss-pxtorem（自动处理 rem，妈妈再也不用担心屏幕太大太小了）

[参考及实现](https://juejin.im/post/5d6cb8aae51d4561cc25f08f)

## element UI 自定义传参的解决方法

```html
<el-autocomplete
    v-model="data"
    :fetch-suggestions="querySearchAsync"
    placeholder="请输入内容"
    @select="handleSelect"
></el-autocomplete>
```
**使用闭包解决：**
```html
<el-autocomplete
    v-model="data"
    :fetch-suggestions="querySearchAsync"
    placeholder="请输入内容"
    //使用闭包,index 表示所选的第几个组件
    @select="item=>handleSelect(item,index)"
></el-autocomplete>
```
也可写成 ```@select="handleSelect($event, index)```

## Watch immediate
当 watch 一个变量的时候，初始化时并不会执行，如下面的例子，你需要在created的时候手动调用一次。
```js
// bad
created() {
  this.getsearchText();
},
watch: {
  searchText: 'getSearchText',
}
```
你可以添加immediate属性，这样初始化的时候也会触发,代码也就可以简化成这样
```js
// good
watch: {
  searchText: {
    handler: 'getSearchText',
    immediate: true,
  }
}
```

## ElementUI中限制el-input输入框只能输入数字
```css
<el-input v-model.number="num"  onkeyup="this.value = this.value.replace(/[^\d.]/g,'');"></el-input>
```
## 解决ElementUI导航栏重复点菜单报错问题

在VUE中路由遇到

```Error: Avoided redundant navigation to current location:```报错显示是路由重复，
虽然对项目无影响，但是看到有红的还是不舒服。

在router的配置文件中（router -> index.js）加上
```js
const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location) {
  return originalPush.call(this, location).catch(err => err)
}
```
## 组件封装

**组件封装原则：**

一个组件只专注做一件事，且把这件事做好（通用 易用 可组合）

 **vue组件三要素：**
1. props参数
2. slot定制插槽
3. event自定义事件

**组件封装思想：**
- 判断基本类型
  - 哪些写死
  - 哪些传进来
- 扩展
  - 自定义事件，判断传出参数
  - 插槽扩展
- 优化
  -  提高适应性(v-if,v-show)

[参考](https://juejin.im/post/5cc842dc6fb9a0322f7c98ff)、[封装Vue组件的一些技巧](https://juejin.im/post/5cb3eed65188251b0351f2c4)

## hookEvent，监听z组件生命周期函数
### 内部监听生命周期函数
以 echarts 开发图表为例
```js
export default {
  mounted() {
    this.chart = echarts.init(this.$el)
    // 请求数据，赋值数据 等等一系列操作...
    
    // 监听窗口发生变化，resize组件
    window.addEventListener('resize', this.$_handleResizeChart)
    // 通过hook监听组件销毁钩子函数，并取消监听事件
    this.$once('hook:beforeDestroy', () => {
      window.removeEventListener('resize', this.$_handleResizeChart)
    })
  },
  updated() {},
  created() {},
  methods: {
    $_handleResizeChart() {
      // this.chart.resize()
    }
  }
}
```
在Vue组件中，可以用过```$on,$once```去监听所有的生命周期钩子函数，如监听组件的 updated 钩子函数可以写成 ```this.$on('hook:updated', () => {})```
### 外部监听生命周期函数
我们有时会遇到这样的情况，用了一个第三方组件，当需要监听第三方组件数据的变化，但是组件又没有提供change事件时。我们可以利用Vue 提供的** ```@hook:updated``` 来监听组件的 updated 生命钩子函数**
```js
<template>
  <!--通过@hook:updated监听组件的updated生命钩子函数-->
  <!--组件的所有生命周期钩子都可以通过@hook:钩子函数名 来监听触发-->
  <custom-select @hook:updated="$_handleSelectUpdated" />
</template>
<script>
import CustomSelect from '../components/custom-select'
export default {
  components: {
    CustomSelect
  },
  methods: {
    $_handleSelectUpdated() {
      console.log('custom-select组件的updated钩子函数被触发')
    }
  }
}
</script>
```
## Vue-cli3 打包后报错 Failed to load resource: net::ERR_FILE_NOT_FOUND

根目录下新建文件 vue.config.js

```js
// vue.config.js
module.exports = {
  publicPath: './'
}
```
## node-sass安装失败
```js
//先
 npm set sass_binary_site=https://npm.taobao.org/mirrors/node-sass/

//然后
npm i
```
## vue-codemirror代码编辑器

[使用详情](https://blog.csdn.net/lfcss/article/details/106125784)

## 单个 *.vue 快速原型开发—遇到的坑
在进行单个 *.vue 文件进行开发，结合 element-UI 使用的时候，输入命令```vue sreve```时，发现报错
```js
#报错信息
These dependencies were not found:

* core-js/library/fn/object/assign in ./node_modules/babel-runtime/core-js/object/assign.js
* core-js/library/fn/symbol in ./node_modules/babel-runtime/core-js/symbol.js
* core-js/library/fn/symbol/iterator in ./node_modules/babel-runtime/core-js/symbol/iterator.js

To install them, you can run: npm install --save core-js/library/fn/object/assign core-js/library/fn/sym
bol core-js/library/fn/symbol/iterator
```
具体解决方法[在这里](https://juejin.im/post/5e5df6e66fb9a07c9d6fa8c8#heading-12)


## TortoiseSVN教程
[SVN快速上手](https://segmentfault.com/a/1190000014245101)、[SVN使用教程](TortoiseSVN)

## css解决fixed布局不会出现滚动条的问题
如果我们布局的是后是fixed并且想要高度为100%的时候，我们一般会这样设置:
```css
div {
    display:fixed;
    height:100%;
    overflow:scroll;
}
```
但是这样的话不会出现滚动条,设置
```css
div {
top: 0;
    bottom:0;
    position:fixed;
    overflow-y:scroll;
    overflow-x:hidden;
}
```

## element隐藏组件滚动条scrollbar使用
[具体使用](https://blog.csdn.net/zhongguohaoshaonian/article/details/79734787)

## post
https://blog.csdn.net/qq_35387940/article/details/103422835

## 男女随机
```js
sex: Math.random() > 0.5 ? 1 : 0,
```
## require.context() 自动注册
require.context():
>你可以通过 require.context() 函数来创建自己的 context。
>
>可以给这个函数传入三个参数：一个要搜索的目录，一个标记表示是否还搜索其子目录， 以及一个匹配文件的正则表达式。
>
>webpack 会在构建中解析代码中的 require.context() 。

```js
// 利用require.context()自动引入article.js和user.js
const routerContext = require.context('./', true, /\.js$/)
routerContext.keys().forEach(route => {
  // 如果是根目录的 index.js 、不处理
  if (route.startsWith('./index')) {
    return
  }
  const routerModule = routerContext(route)
  /**
   * 兼容 import export 和 require module.export 两种规范
   */
  routes = routes.concat(routerModule.default || routerModule)
})
```

## map
```
http://vue-gaode.rxshc.com/
```
## 换肤
```css
:root{
  --bg:#000
}
body{
  background:var(--bg)
}
```
## post常见数据格式
1. application/json
参数直接放在请求体，以 json 格式发送到后端，为 axios 请求的默认方式。
2. application/x-www-form-urlencoded 
请求体中的数据会以普通表单形式（键值对）发送给后端
3. multipart/form-data
参数会在请求体中，以标签为单元，用分隔符(可以自定义的boundary)分开。既可以上传键值对，也可以上传文件。通常被用来上传文件的格式。
[详情](https://juejin.im/post/6844903891872514056)

## vue props传递对象或数组
将对象或数组本地化
```js
<template>
  <input v-model="newName.firstName" placeholder="我是子组件">//插值
</template>

<script>
export default {
  props: { 
  //接收父组件传来的数据
    name: {}
  },
  data: function () {
    	return {
     		newName: {
     			firstName:'',
    			lastName:''
     		}
    	}
   },
	computed: {
	  initData: function () {
	  // 将对象本地化
	    return this.newName = JSON.parse(JSON.stringify(this.name))
	  }
}
} 
</script>
```

## eslint 报错
vue 文件 script首行添加 ```/* eslint no-unused-vars: "off"*/``` 即可

## 生产环境去除 console.log

vue.config.js 中配置

```js
configureWebpack: (config) => {
  if (process.env.NODE_ENV === "production") {
    config.optimization.minimizer[0].options.terserOptions.compress.drop_console = true;
    config.optimization.minimizer[0].options.terserOptions.compress.pure_funcs = [
      "console.log",
    ];
  }
}
```

## hook

开发中用到定时器时我们一般这样
```js
mounted() {
  // 创建一个定时器
    this.timer = setInterval(() => {
      // ......
    }, 500);
  },
  // 销毁这个定时器。
beforeDestroy() {
  if (this.timer) {
  clearInterval(this.timer);
  this.timer = null;
  }
}
```

借助 hook，方便维护

```js
mounted() {
    let timer = setInterval(() => {
      // ......
    }, 500);
    this.$once("hook:beforeDestroy", function() {
      if (timer) {
        clearInterval(timer);
        timer = null;
      }
    });
  }
```

## hook 监听第三方组件生命周期

如你要在第三方组件 CustomSelect 渲染时监听其 updated 钩子，可以通过@hook:updated来实现

```vue
<template>
  <!--通过@hook:updated监听组件的updated生命钩子函数-->
  <!--组件的所有生命周期钩子都可以通过@hook:钩子函数名 来监听触发-->
  <custom-select @hook:updated="doSomething" />
</template>
<script>
import CustomSelect from "../components/custom-select";
export default {
  components: {
    CustomSelect
  },
  methods: {
    doSomething() {
      console.log("custom-select组件的updated钩子函数被触发");
    }
  }
};
</script>
```
## vue+elementUI在输入框中按回车键会刷新页面

当一个 form 元素中只有一个输入框时，在该输入框中按下回车应提交该表单。如果希望阻止这一默认行为，可以在 <el-form> 标签上添加 @submit.native.prevent。

```js
<el-form  @submit.native.prevent></el-form>
```

## el-dialog关闭后重置数据

```js
//重置表单，formRef为表单的ref值，excludeFields为要排除重新初始化值得属性
Vue.prototype.$reset = function (formRef, ...excludeFields) {
  this.$refs[formRef].resetFields();
  let obj1 = this.$data;
  let obj2 = this.$options.data.call(this);
  if (!excludeFields || excludeFields.length === 0) {
    excludeFields = ["ruleValidate"];
  }
  for (let attrName in obj1) {
    if (excludeFields && excludeFields.includes(attrName)) {
      continue;
    }
    obj1[attrName] = obj2[attrName];
  }
};
```

el-dialog的close事件总调用

```vue
<template>
  <el-dialog v-el-drag-dialog :close-on-click-modal="false" :visible.sync="dialogVisible" :title="model.id === 0 ? '新增车辆' : '编辑车辆'" class="car-edit" width="450px" top="5vh" @close="$reset('form')">
    <el-form ref="form" :model="model" :rules="ruleValidate" class="formFillWidth" label-width="50px">
      <el-form-item label="车牌" prop="carCard">
        <el-input v-model="model.carCard" placeholder="请输入" />
      </el-form-item>
      <el-form-item label="司机" prop="driver">
        <el-input v-model="model.driver" placeholder="请输入" />
      </el-form-item>
      <el-form-item label="备注" prop="remark">
        <el-input v-model="model.remark" placeholder="请输入" />
      </el-form-item>
    </el-form>
    <span slot="footer">
      <el-button @click="dialogVisible = false">取消</el-button>
      <el-button :loading="submitLoading" type="primary" @click="handleSubmit">保存</el-button>
    </span>
  </el-dialog>
</template>
```



<Vssue/>