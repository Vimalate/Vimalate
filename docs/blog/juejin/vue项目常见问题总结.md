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

## vue路由跳转打开新窗口

使用  this.$router.resolve

```js
const openNewUrl=(url) => {
  let routeData = this.$router.resolve({path: url})
  window.open(routeData.href, '_blank')
  }
```


## el-input 限制输入框只能输入数字
```css
<el-input v-model.number="num"  onkeyup="this.value = this.value.replace(/[^\d.]/g,'');"></el-input>
```
## el-input 过滤特殊字符或身份证脱敏

**v-model拆分为:value和@input**

```vue
<el-input :value="input" @input='e => input = idCardValid (e)' placeholder="请输入内容"></el-input>
```

```js
  methods:{
    idCardValid(val){
      const idCard= val.replace(/^(\d{6})\d+(\d{4})$/, "$1******$2")
      console.log(idCard)
      return idCard
    } 
},
```

## 使用a标签下载本地静态资源文件

- 1、public目录下存放要下载的静态资源
- 2、a 标签下载

```html
 <a href="/demo.rar" download="demo.rar">点击下载</a>
```

## 检测元素外部(或内部)的单击

```js
window.addEventListener('mousedown', e => {
  // 获取被点击的元素
  const clickedEl = e.target;
  
  if (el.contains(clickedEl)) {
   //在 "el "里面点击了
  } else {
   //在 "el "外点击了
  }
});
```
## iframe框架内页面控制父框架页面跳转到某地址

```js
const { href } = this.$router.resolve({ path: "/resetPwd", query: { key: key } });
// iframe 控制父页面跳转
window.parent.window.location.href = href
```

## hookEvent

### 组件内使用

开发中用到定时器时我们一般这样
```js
// bad
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

而借助 hook，可以更方便维护

```js
// good
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

### 监听子组件生命周期函数

**原本**

 ```vue
//父组件
<child
  :value="value"
  @childMounted="onChildMounted"
/>
method () {
  onChildMounted() {
  // do something...
  }
},

// 子组件
mounted () {
  this.$emit('childMounted')
},
```


hooks：

```vue
//父组件
<child
  :value="value"
  @hook:mounted="onChildMounted"
/>
method () {
  onChildMounted() {
  // do something...
  }
},
```

在Vue组件中，可以用过```$on,$once```去监听所有的生命周期钩子函数，如监听组件的 updated 钩子函数可以写成 ```this.$on('hook:updated', () => {})```

### 外部监听生命周期函数

我们有时会遇到这样的情况，用了一个第三方组件，当需要监听第三方组件数据的变化，但是组件又没有提供change事件时。我们可以利用Vue 提供的** ```@hook:updated``` 来监听组件的 updated 生命钩子函数**

```vue
<template>
  <!--通过@hook:updated监听组件的updated生命钩子函数-->
  <!--组件的所有生命周期钩子都可以通过@hook:钩子函数名 来监听触发-->
  <custom-select @hook:updated="onSelectUpdated" />
</template>
<script>
import CustomSelect from './components/custom-select'
export default {
  components: {
    CustomSelect
  },
  methods: {
    onSelectUpdated() {
      console.log('custom-select组件的updated钩子函数被触发')
    }
  }
}
</script>
```
## vue跳转相同路径报错

在vue的router的js中添加下面代码，ew VueRouter 前

```js
const originalPush = VueRouter.prototype.push
const originalReplace = VueRouter.prototype.replace
// push
VueRouter.prototype.push = function push(location, onResolve, onReject) {
  if (onResolve || onReject) return originalPush.call(this, location, onResolve, onReject)
  return originalPush.call(this, location).catch(err => err)
}
// replace
VueRouter.prototype.replace = function push(location, onResolve, onReject) {
  if (onResolve || onReject) return originalReplace.call(this, location, onResolve, onReject)
  return originalReplace.call(this, location).catch(err => err)
}
```

## Vue-cli3 打包后报错 Failed to load resource: net::ERR_FILE_NOT_FOUND

根目录下新建文件 vue.config.js

```js
// vue.config.js
module.exports = {
  publicPath: './'
}
```

默认情况下，Vue CLI 会假设你的应用是被部署在一个域名的根路径上，例如 https://www.my-app.com/。如果应用被部署在一个子路径上，你就需要用这个选项指定这个子路径。例如，如果你的应用被部署在 https://www.my-app.com/my-app/，则设置 publicPath 为 /my-app/。

这个值也可以被设置为空字符串 ('') 或是相对路径 ('./')，这样所有的资源都会被链接为相对路径，这样打出来的包可以被部署在任意路径。

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

## require.context() 自动注册
require.context():
>你可以通过 require.context() 函数来创建自己的 context。
>
>可以给这个函数传入三个参数：一个要搜索的目录，一个标记表示是否还搜索其子目录， 以及一个匹配文件的正则表达式。
>
>webpack 会在构建中解析代码中的 require.context() 。

```js
// 利用require.context()自动引入 除 index.js 外其他 js 文件
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


## vue+elementUI在输入框中按回车键会刷新页面

当一个 form 元素中只有一个输入框时，在该输入框中按下回车应提交该表单。如果希望阻止这一默认行为，可以在 ```<el-form>``` 标签上添加 @submit.native.prevent。

```vue
<templat>
<el-form   @submit.native.prevent >< /el-form >
</templat>
```



## el-select 下拉框样式修改

使用样式穿透修改下拉框样式，你会发现打死都不生效，那是因为下拉框是默认挂载在 body 下面。解决办法：设置 ```:popper-append-to-body="false"```,然后再用样式穿透

## element-ui select组件change事件传递多个参数的方法

1. 方法一

```js
@change="onChange($event,customParam)"
```

2. 方法二

```js
@change="((val)=>{changeEvent(val,args)})"  
```



**其他组件的的默认事件同样的方法传递**

```vue
<el-dropdown trigger="click" @command="((val)=>{handleCommand(val,scope.row)})">
  <span class="el-dropdown-link">
    <i class="el-icon-more el-icon--right"></i>
  </span>
    <el-dropdown-menu slot="dropdown">
        <el-dropdown-item command="volumes">新增</el-dropdown-item>
        <el-dropdown-item command="log">查看</el-dropdown-item>
        <el-dropdown-item command="shell">更新</el-dropdown-item>
        <el-dropdown-item command="container">删除</el-dropdown-item>
    </el-dropdown-menu>
</el-dropdown>
```

## el-input type=number 去除聚焦时的上下箭头

解决

```js
<el-input class="clear-number-input" type="number"></el-input>

<style scoped>
.clear-number-input ::v-deep input[type="number"]::-webkit-outer-spin-button,
.clear-number-input ::v-deep input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none !important;
}
</style>
```


## chrome表单自动填充导致input文本框背景失效

我们在开发登陆页的时候经常遇到，登陆页的表单自动填充导致input文本框背景失效的问题。

```css
// 自动填充样式覆盖
input:-internal-autofill-previewed,
input:-internal-autofill-selected {
  -webkit-text-fill-color: #fff; 
  transition: background-color 5000s ease-out 0.5s;
}
```

## 巧用$options

$options是一个记录当前Vue组件的初始化属性选项，当我们想把 data 里的某个值重置为初始值时，非常有用

例如：

```js
this.value = this.$options.data().value;
```


## dialog 里重置表单

我们经常的业务场景是这样：一个el-dialog中有一个el-form，而且我们通常是新增和编辑复用同一个组件，现在我们要求每次打开el-dialog时都要重置el-form里的数据，并且清除校验状态。

```js
  // 弹框打开时
initForm(){
  this.$refs['form'] && this.$refs['form'].resetFields()
  this.form = this.$options.data.call(this).form;
}
```

## 将一个 prop 限制在一个类型的列表中

 我们在使用 prop 时，可能会有时候需要判断该 prop 是否在我们规定的范围内（或者说规定的值内），这个时候我们可以使用 prop 定义中的 validator 选项，将一个 prop 类型限制在一组特定的值里。

```js
  // 只能选择一个
  props: {
    type: String,
    validator(value) {
      return ['A', 'B', 'C'].indexOf(value) > -1
    }
  }
```

validator 函数接收一个prop吗，如果 prop 有效或无效，则返回 true 或 false。


## Vue在子组件中判断父组件是否传来事件

在做二次封装时，我们经常用到，```v-bind="$attrs"```和```v-on="$listeners"```进行多层组件监听,那么我们还可以利用 ```$listeners```在子组件中判断父组件是否传来事件

例如我们封装一个搜索组件，里面有重置按钮，当我们点击重置按钮时，默认操作是清空搜索栏的值并且刷新列表，而如果父组件传来事件，则以自定义事件为准，即我们想点击重置按钮做一些其他的自定义操作。

  
```js
resetFields() {
  //...
  if (this.$listeners.resetFields) {
    // 自定义事件
      this.$emit('resetFields')
    } else {
      // 默认刷新列表事件
      this.loadList()
    }
}
```

## 同一组件上存在多个table进行tabs和v-if/v-show切换时，多表格的数据会相互混淆，串在一起，引发bug

为每个table指定对应且唯一的key属性。

>其他一些类似的问题也可以尝试为其添加key属性来解决


## vue element 多个 Form 表单同时验证

- 1.

```vue
<template>
<el-form   ref="form1"></el-form>
<el-form   ref="form2"></el-form>
<el-form   ref="form3"></el-form>
</template>
<script>
export default{
    methods: {
      onValidate() { // 保存操作
      const formArr =['form1', 'form2','form3']//三个form表单的ref
      const resultArr = [] //用来接受返回结果的数组
      let _self = this
      function checkForm(formName) { //封装验证表单的函数
        let result = new Promise(function (resolve, reject) {
          _self.$refs[formName].validate((valid) => {
            if (valid) {
              resolve();
            } else { reject() }
          })
        })
        resultArr.push(result) // 得到promise的结果
      }
      formArr.forEach(item => { // 根据表单的ref校验
        checkForm(item)
      })
      Promise.all(resultArr).then(values => {
         // 此时必填完成，做保存后的业务操作
        //  ...
        console.log('success');
      }).catch(_ => {
        console.log('err')
      })
    },
    }
}
</script>
```
 - 2.

```js
submitForm() {
      let list = [];
      list.push(
        this.checkForm("formData"),
        this.checkForm("formData2"),
        this.checkForm("formData3"),
        this.checkForm("formData4")
      );
      Promise.all(list)
        .then(() => {
          console.log("通过检测");
        })
        .catch(() => {
          console.log("未通过");
        });
    },
    checkForm(formName) {
      return new Promise((resolve, reject) => {
        this.$refs[formName].validate(valid => {
          if (valid) {
            resolve();
          } else reject();
        });
      });
    }
```

## Vue中的method赋值为高阶函数

```js
<script>
  import { debounce } from "lodash";

  export default {
    methods: {
      search: debounce(async function (keyword) {
        // ... 请求逻辑
      }, 500),
    },
  };
</script>
```

## 给 slot 插槽绑定事件

- 1、作用域插槽 slot-scope 传方法

```vue
<!-- 伪代码:下拉框组件 -->
 
<template>
    <slot change-display="changeDisplay"></slot>
    <div v-show="visiable">*下拉框代码省略*<div>
<template>
 
<script>
export default {
    data(){
        return {
            visiable: false
        }
    }
 
    methods:{
        changeDisplay(){
            this.visiable = !this.visiable
        }
    }
}
</script>
```

使用：

```vue
<!--使用下拉弹窗组件-->
<dropdown v-model="value" :list="list">
  <button slot-scope="{changeDisplay}" 
    @click="changeDisplay">{{value}}</button>
</dropdown>
```

- 2、vnode 中对应的页面元素

```vue
<!-- 伪代码:下拉框组件 -->
<template>
    <slot></slot>
    <div v-show="visiable">*下拉框代码省略*<div>
<template>
 
<script>
export default {
    data(){
        return {
            visiable: false
            reference: undefined
        }
    }
 
    methods:{
        changeDisplay(){
            this.visiable = !this.visiable
        }
    }
 
    mounted() {
        if (this.$slots.default) {
          this.reference = this.$slots.default[0].elm
        }
        if (this.reference) {
          this.reference.addEventListener('click', this.changeVisiable, false)
          // hook
          this.$once('hook:beforeDestroy', () => {
          this.reference.removeEventListener('click', this.changeVisiable)
      })
        }
    }
}
</script>
```


## 二次封装作用域插槽

在二次封装组件时，我们知道可以通过判断 ```$slots.xxx``` 是否存在来判断我们在使用这个组件时是否传递了插槽内容。从而更好的定制默认的插槽内容。

那么在二次封装一个原本具有作用域插槽的组件时，我们可以通过 ```$scopedSlots.xxx``` 来进行判断


子组件

```vue
<template>
<Tree class="tree" v-if="items.length" :data="items" :options="options" :filter='search' ref="tree" v-model="treeModel">
<!-- 作用域插槽 -->
  <template slot-scope="{node}">
    <span v-if="!$scopedSlots.default">{{node.text}}</span>
    <slot v-else :node="node"></slot>
  </template>
</Tree>
</template>

使用

```vue
<template>
  <custom-tree ref="tree" checkbox :data='data' :props="{children:'children',text: 'text'}">
    <template slot-scope="{node}">
      <span class="tree-text">
      <!-- 自定义插槽内容 -->
        <template v-if="!node.children">
          <van-icon name="user-o" size="18" class="icon" />
            {{ node.text }}
        </template>
        <template v-else>
          {{ node.text }}
        </template>
      </span>
    </template>
  </custom-tree>
</template>
```

## vue-pdf不显示电子签章

- 1、找到node_modules包里的pdfjs-dist/es5/build/pdf.worker.js文件，找到下列代码注释掉即可

```js
_this3.setFlags(_util.AnnotationFlag.HIDDEN);   
```

- 2、安装 patch-package (npm install patch-package --save-dev)
- 3、package.json 文件中的 scripts 中加入"postinstall": "patch-package"
- 4、执行 npx patch-package pdfjs-dist

[vue-pdf不显示电子签章](https://blog.csdn.net/LingSnow1019/article/details/122448014)

## pdfjs-dist 安装后启动报错

插件中使用了 es11 的语法 ?. 然而当项目启动，插件中的代码没有经过编译，导致项目不能启动。解决方案是在项目中配置webpack 针对于这个插件进行编译。

修改项目根目录下 vue.config.js ，如果没有就创建一个，在文件中增加如下代码：

```js
// vue.config.js
module.exports = {
  // ...
  chainWebpack: config => {
     // ...
     config.module.rule('pdfjs-dist').test({
      test: /\.js$/,
      include: path.join(__dirname, 'node_modules/pdfjs-dist')
    }).use('babel-loader').loader('babel-loader').options({
      presets: ['@babel/preset-env'],
      plugins: ['@babel/plugin-proposal-optional-chaining']
    })
  }
}
```
[Vue3实现各种附件预览](https://juejin.cn/post/6995856687106261000)


## error delete ·CR· (prettier/prettier)

```
npm run lint --fix
```

## 使用 fuse 实现模糊搜索

安装
```js
 npm install --save fuse.js
```

实现

```vue
<template>
  <div class="hello">
    <el-input v-model="title" placeholder="请输入内容"></el-input>
    <ul>
      <li v-for="item in result">
        标题： {{item.item.title}}
        <br />
        作者： {{item.item.author.firstName}}
        <br />
        分数： {{item.score}}
      </li>
    </ul>
  </div>
</template>

<script>
// 1. 引入Fuse
import Fuse from "fuse.js";
export default {
  data() {
    return {
      title: "",
      fuse: null,
      result: [],
      books: [
        {
          title: "Java虚拟机",
          author: {
            firstName: "王浩",
            lastName: "wanghao"
          }
        },
        {
          title: "人工智能",
          author: {
            firstName: "侯建军",
            lastName: "marquis"
          }
        }
      ]
    };
  },
  created() {
    // 2. 初始化
    this.init();
  },
  watch: {
    // 要变量名一致
    title(newName, oldName) {
      // 新值
      console.log(newName);
      // 旧值
      console.log(oldName);
      // 3. 搜索内容
      this.result = this.fuse.search(newName);
      console.log(this.result);
    }
  },
  methods: {
    // 初始化
    init() {
      var options = {
        shouldSort: true, // 是否按分数对结果列表排序
        includeScore: true, //  是否应将分数包含在结果集中。0分表示完全匹配，1分表示完全不匹配。
        threshold: 0.6, // 匹配算法阈值。阈值为0.0需要完全匹配（字母和位置），阈值为1.0将匹配任何内容。
        /**
         * 确定匹配与模糊位置（由位置指定）的距离。一个精确的字母匹配，即距离模糊位置很远的字符将被视为完全不匹配。
         *  距离为0要求匹配位于指定的准确位置，距离为1000则要求完全匹配位于使用阈值0.8找到的位置的800个字符以内。
         */
        location: 0, // 确定文本中预期找到的模式的大致位置。
        distance: 100,
        maxPatternLength: 32, // 模式的最大长度
        minMatchCharLength: 1, // 模式的最小字符长度
        // 搜索标题与作者名
        keys: ["title", "author.firstName"]
      };
      // 设置数据与参数
      this.fuse = new Fuse(this.books, options);
    }
  }
};
</script>
```

参考：[十分钟，让你学会Vue的这些巧妙冷技巧](https://juejin.cn/post/7103066172530098206)
