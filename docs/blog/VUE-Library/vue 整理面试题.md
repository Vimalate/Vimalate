# VUE 常见面试整理

## 生命周期钩子函数

**beforeCreate（初始化界面前）**

**created（初始化界面后）**

**beforeMount（渲染dom前）**

**mounted（渲染dom后）**

**beforeUpdate（更新数据前）**

**updated（更新数据后）**

**beforeDestroy（卸载组件前）**

**destroyed（卸载组件后）**

**钩子函数，其实和回调是一个概念**，当系统执行到某处时，检查是否有hook，有则回调。说的更直白一点，每个组件都有属性，方法和事件。所有的生命周期都归于事件，在某个时刻自动执行。**生老病死**

我们首先需要创建一个实例，也就是在 n**ew Vue ( ) 的对象过程当中，首先执行了init**（init是vue组件里面默认去执行的），在**init的过程当中**首先调用了**beforeCreate**，然后在injections（注射）和reactivity（反应性）的时候，它会再去调用created。所以在init的时候，事件已经调用了，我们在beforeCreate的时候千万不要去修改data里面赋值的数据，最早也要放在created里面去做（添加一些行为）。

created完成之后，它会去**判断instance（实例）里面是否含有“el”option（选项）**，如果**没有**的话，它会调用**vm.$mount(el)**这个方法，然后执行下一步；如果**有**的话，**直接执行下一步**。紧接着会**判断是否含有“template”这个选项**，如果**有**的话，它会**把template解析成一个render function** ，即template编译的过程，结果是解析成了render函数

**render函数是发生在beforeMount和mounted之间的**，这也从侧面说明了，在**beforeMount**的时候，**$el还只是我们在HTML里面写的节点**，然后到**mounted**的时候，它就把**渲染出来的内容挂载到了DOM节点上**。这中间的过程其实是执行了render function的内容。

beforeMount在有了render function的时候才会执行，当执行完render function之后，就会调用mounted这个钩子，在mounted挂载完毕之后，这个实例就算是走完流程了。

另外还有 `keep-alive` 独有的生命周期，分别为 `activated` 和 `deactivated` 。用 `keep-alive` 包裹的组件在切换时不会进行销毁，而是缓存到内存中并执行 `deactivated` 钩子函数，命中缓存渲染后会执行 `actived` 钩子函数。

## 父子组件生命周期调用顺序
父组件初始化完，再初始化子组件

子组件渲染完，再渲染父组件


![](https://i.loli.net/2020/04/20/RJFVdzEpo9Btc5n.png)

同理，组件的销毁操作是先父后子，销毁完成的顺序是先子后父。
##  组件通信

- 父子组件通信
- 兄弟组件通信
- 跨多层级组件通信
- 任意组件

### 父子

父组件通过 `props` 传递数据给子组件，子组件通过 `emit` 发送事件传递数据给父组件，这两种方式是最常用的父子通信实现办法。  **单向数据流**，父组件通过 `props` 传递数据，子组件不能直接修改 `props`， 而是必须通过发送事件的方式告知父组件修改数据。父组件通过v-on监听并接收参数

当然我们还可以通过访问 `$parent` 或者 `$children` 对象来访问组件实例中的方法和数据。

**v-model**

因为 `v-model` 默认会解析成名为 `value` 的 `prop` 和名为 `input` 的事件。这种语法糖的方式是典型的双向绑定，常用于 UI 控件上，但是究其根本，还是通过事件的方法让父组件修改数据。
```!
在一个组件上使用v-model，默认会为组件绑定名为value的prop和名为input的事件
```

### **兄弟**

#### **eventBus**

初始化：

```
// event-bus.js

import Vue from 'vue'
export const EventBus = new Vue()

```

兄弟组件通过EventBus.$emit分发和EventBus.$on接收

#### `$children` / `$parent`

对于这种情况可以通过查找父组件中的子组件实现，也就是 `this.$parent.$children`，在 `$children`中可以通过组件 `name` 查询到需要的组件实例，然后进行通信。



## mixin 和 mixins 区别

`mixin` 用于全局混入，以全局混入封装好的 `ajax` 或者一些工具函数等等。

`mixins` 应该是我们最常使用的扩展组件的方式了。如果多个组件中有相同的业务逻辑，就可以将这些逻辑剥离出来，通过 `mixins` 混入代码，比如上拉下拉加载数据这种逻辑等等。

```!
需要注意的是 mixins 混入的钩子函数会先于组件内的钩子函数执行，并且在遇到同名选项的时候也会有选择性的进行合并，具体可以阅读
```

[文档](https://cn.vuejs.org/v2/guide/mixins.html)

## computed 和 watch 区别

`computed` 是计算属性，依赖其他属性计算值，并且 `computed` 的值有**缓存**，只有当计算值变化才会返回内容。内部做了一个一个 dirty ,实现缓存。当依赖的属性发生变化，就会让 dirty 变为true

`watch` 监听到值的变化就会**执行回调，**在回调中可以进行一些逻辑操作。可设置 deep:true 深层次监听，利用递归实现。

所以一般来说需要依赖别的属性来动态获得值的时候可以使用 `computed`，对于监听到值的变化需要做一些复杂业务逻辑的情况可以使用 `watch`。



## v-show 与 v-if 区别

`v-show` 无论初始条件是什么都会被渲染出来，后面只需要切换 CSS，DOM 还是一直保留着的。`display:none`属性，**所以总的来说 `v-show` 在初始渲染时有更高的开销，但是切换开销很小，更适合于频繁切换的场景。**，v-show是控制有没有display：none这个样式来控制显隐。

`v-if` 条件渲染，切换条件时会**触发销毁/挂载组件，**所以总的来说在切**换时开销更高，更适合不经常切换的场景。**

## vue中组件的data为什么是一个函数

组件是可复用的vue实例，一个组件被创建好之后，就可能被用在各个地方，而组件不管被复用了多少次，组件中的data数据都应该是相互隔离，互不影响的。

组件中的data 写成函数，数据以函数返回值定义，这样每复用一次组件，就能够获得一份独立的 data 拷贝，互不影响。原因在于采用函数定义，在 initData 时会将其作为工厂函数返回全新的 data 对象，有效规避多组件间的状态污染。
```!
而在 Vue 根实例创建则不存在此限制，因为根实例只有一个。无须担心此状况。
```
## nextTick的用途与原理

应用场景 ：需要在试图更新后，基于新的视图进行操作。

例：点击按钮让原本隐藏的输入框显示，并且获取焦点

```js
<input v-if='isShow' id='keywords'>
<button @click="showInput">输入框显示，并且获取焦点</button>

showInput() {
	this.isShow=true
	// document.getElementById('keywords').focus //获取不到输入框报错
	this.$nextTick(function () {
    // DOM 更新了,可以获取
    document.getElementById("keywords").focus()//加上$nextTick 
}

```
vue 的数据响应通过 ```Object.defineProperty``` 实现，而 vue 更新 dom 是异步的，官方这样解释：
>Vue 异步执行 DOM 更新。只要观察到数据变化，Vue 将开启一个队列，并缓冲在同一事件循环中发生的所有数据改变。如果同一个watcher 被多次触发，只会被推入到队列中一次。这种在缓冲时去除重复数据对于避免不必要的计算和 DOM 操作上非常重要。然后，在下一个的事件循环“tick”中，Vue 刷新队列并执行实际 (已去重的) 工作。Vue 在内部尝试对异步队列使用原生的Promise.then和 MessageChannel，如果执行环境不支持，会采用setTimeout(fn, 0)代替。

即 nextTick 原理与 Event Loop 相关

事件循环又分为 

macro-task(宏任务)包括：
- script(整体代码)
- setTimeout / setInterval
- setImmediate(Node.js 环境)
- I/O
- UI render
- postMessage
- MessageChannel
 
>不建议记住宏任务，太多，记住以下微任务即可，其他不知道的把其归类为宏任务（当然，此仅为面试时技巧）

micro-task(微任务)：
- process.nextTick(Node.js 环境)
- Promise
- Async/Await
- MutationObserver(html5 新特性)

所有微任务都会在下一次渲染前完成，目的是在渲染前更新应用程序状态。

**关于事件循环执行顺序总结与速记：**
先执行主线程
遇到宏队列（macrotask）放到宏队列（macrotask）
遇到微队列（microtask）放到微队列（microtask）
主线程执行完毕
执行微队列（microtask），微队列（microtask）执行完毕
执行一次宏队列（macrotask）中的一个任务，执行完毕
执行微队列（microtask），执行完毕
依次循环。。。

nextTick 的主要实现依赖于 微任务，但 Vue 为了做好一些兼容，优先使用 promise ，其次是 html5 的 MutationObserver，然后是setTimeout。前两者属于microtask，后一个属于 macrotask。

优先尝试 Promise ，尝试 MutationObserver，尝试 setImmediate，最终不行在使用 setTimeout

参考：[从 javascript 事件循环看 Vue.nextTick 的原理和执行机制](https://juejin.im/post/5e899111f265da47d4056689)


## Proxy 与 Object.defineProperty 的优劣对比

proxy 优势 ：
- 能直接监听数组的变化
- 能直接监听对象而非属性
- 多达 13 种拦截方法，不限于 apply、ownKeys、deleteProperty、has等等是 Object.defineProperty 所不具备的
- 返回一个新对象，我们的操作只对于新对象，而 Object.defineProperty 只能遍历对象属性进行更改
- 性能红利 

>在Vue中，Object.defineProperty无法监控到数组下标的变化，导致直接通过数组的下标给数组设置值，不能实时响应。 为了解决这个问题，经过vue内部处理后可以使用以下几种方法来监听数组
（其实，Object.defineProperty本身是可以监控到数组下标的变化的，具体可参[Vue为什么不能检测数组变动](https://segmentfault.com/a/1190000015783546#comment-area)）


## v-for和v-if一起使用

v-for和v-if同时使用时，有一个先后运行的优先级。因为v-for比v-if优先级更高，所以当两者用于同一标签时，v-for的每次循环中都会调用v-if。如果要遍历的数组很大，而真正要展示的数据很少时，这将造成很大的性能浪费。

**解决方法**：ul和li搭配使用，或者是渲染父级标签下的子标签
```js 
<ul v-if="data">
	<li v-for="(item,id) in list" :key="id"></li>
</ul>
```
**或使用过滤器将v-if中的判断转移到vue的computed的计算属性中**
```js
<ul>
	<li v-for="(item,id) in list" :key="id"></li>
</ul>
 
//利用vue的计算属性，过滤掉不需要的数据，剩下需要的数据再利用v-for循环遍历取出渲染
computed: {
	list: function () {
		return this.list.filter(function (item) {
			return item.state
		})
	}
}
```

## v-for中的key不建议使用index

我们使用 v-for 时，其内部 diff 算法使用就地复用原则，当列表数据发生更改，他是根据 key 值来判断某个值是否修改，如修改，则重新渲染，否则就复用这一项。key的作用也主要是为了高效的更新虚拟DOM，而 index 则不能做到。

也就是说如果你的列表顺序会改变，别用 index 作为 key，和没写基本上没区别，因为不管你数组的顺序怎么颠倒，index 都是 0, 1, 2 这样排列，导致 Vue 会复用错误的旧子节点，做很多额外的工作。列表顺序不变也尽量别用，可能会误导新人。
[具体参考： v-for中的key](https://juejin.im/post/5aae19aa6fb9a028d4445d1a)

##  了解 Virtual DOM？为什么 Virtual DOM 比原生 DOM 快？

Virtual DOM 其实就是通过对文档中的 DOM 树结构进行分析，利用 js 对象将其表示出来，比如一个元素对象，包含 TagName、props 和 Children 这些属性。然后我们将这个 js 对象树给保存下来，最后再将 DOM 片段插入到文档中。

当我们的页面要发生改变，也就是页面 DOM 结构调整，我们首先根据变更的状态，重新构建起一棵对象树，然后将新树和旧树进行对比，记录下两棵树的差异。

最后将有差异的地方进行替换，应用到真正的 DOM 树中，然后视图也就完成更新。

**这种方法在我们需要大量的 DOM 操作时，能够很好的提高我们的操作效率，通过在操作前确定需要做的最小修改，尽可能的减少 DOM 操作带来的重流和重绘的影响。其实 Virtual DOM 并不一定比我们真实的操作 DOM 要快，这种方法的目的是为了提高我们开发时的可维护性，在任意的情况下，都能保证一个尽量小的性能消耗去进行操作。**

## 如何比较两个 DOM 树的差异？

两个树的完全 diff 算法的时间复杂度为 O(n^3) ，但是在前端中，我们很少会跨层级的移动元素，所以我们只需要比较同一层级的元素进行比较，这样就可以将算法的时间复杂度降低为 O(n)。

算法首先会对新旧两棵树进行一个深度优先的遍历，这样每个节点都会有一个序号。在深度遍历的时候，每遍历到一个节点，我们就将这个节点和新的树中的节点进行比较，如果有差异，则将这个差异记录到一个对象中。

在对列表元素进行对比的时候，由于 TagName 是重复的，所以我们不能使用这个来对比。我们需要给每一个子节点加上一个 key，列表对比的时候使用 key 来进行比较，这样我们才能够复用老的 DOM 树上的节点。


```!
diff 过程整体遵循 **深度优先、同层比较**的策略：两个节点比较他们是否拥有子节点或者文本节点做不同的操作，当比较两组子节点时，会先假设头尾节点相同做四次比较尝试，如果没有找到相同节点则按照通用方式遍历查找，查找结束再按情况处理剩下的节点，借助 key 通常可以更高效精确的找到相同节点，然后复用，因此整个 patch 过程也非常的高效。
```

## Vue的渲染过程

1. 把模板编译为 render 函数
2. 实例进行挂载，执行 render 函数，生成 vnode 
3. 基于 vnode 执行 diff 算法，对比虚拟 dom，渲染真实 dom
4. 组件内的 data 发生变化时，重新调用 render 函数，生成 vnode ，然后又回到步骤3了。

## hash路由和history路由

- hash模式：依靠onhashchange事件(监听location.hash的改变)
- history模式：history.pushState 和 replaceState ，pushState()可以改变url地址且不会发送请求，replaceState()可以读取历史记录栈,还可以对浏览器记录进行修改。

##  Vue 项目的一些优化？

代码层面优化：

- v-if 和 v-show 区分使用
- v-for 加key ，避免同时使用 v-if
- 路由懒加载
- 图片懒加载 v-lazy
- 事件及时销毁
- 第三方插件按需引入

Webpack 层面：

- 对图片进行压缩
- 模板预编译
- 优化 SourceMap
- 提取公共代码

基础的 Web 技术的优化：

- 开启 gzip
- 使用 cdn 
- 浏览器缓存
- 使用 Chrome Performance 查找性能瓶颈

## 为什么使用异步组件

项目过大时，核心页面访问速度变慢，使用异步组件将代码分割成小块，需要使用这个组件时在引入，可提高加载的速度。主要依赖```import()```这个语法。
用法示例：
```js
export default {
    components: {
        Home: () => import('./components/Home')
    }
}
```
## 如何在不刷新页面的情况下，刷新组件？
方法：
- v-if
- $forceUpdate()
- v-key
## 路由懒加载
路由懒加载就是把不同路由对应的组件分割成不同的代码块，然后当路由被访问的时候才加载对应组件。

实现：使用命名 chunk ，和 webpack 的魔法注释
```js
chunkconst Home = () => import(/* webpackChunkName: "group-home" */ './Home.vue')
```
## Vue-router 导航守卫有哪些
- 全局钩子：```beforeEach、beforeResolve、afterEach```
- 路由独享守卫：```beforeEnter```
- 组件内守卫： ```beforeRouteEnter 、beforeRouteUpdate、beforeRouteLeave```
## vue-router 传参

query方式传参和接收参数

```js
传参: 
this.$router.push({
        path:'/xxx',
        query:{
          id:id
        }
      })
  
接收参数:
this.$route.query.id
```
params方式传参和接收参数

```js
传参: 
this.$router.push({
        name:'xxx',
        params:{
          id:id
        }
      })
  
接收参数:
this.$route.params.id
```
>params传参，push里面只能是 name:'xxxx',不能是path:'/xxx',因为params只能用name来引入路由，如果这里写成了path，接收参数页面会是undefined！！！
query 和 params 传参方式的区别
- query 地址栏显示参数，params 则不会，
- params只能用name来引入路由，query用name，path都可以
- params参数要在路由中声明了才不会消失。

详细：[导航守卫](https://router.vuejs.org/zh/guide/advanced/navigation-guards.html)、[query 和 params](https://segmentfault.com/a/1190000012735168#comment-area)

## $route 和 $router 的区别？

$route 是“路由信息对象”，包括 path，params，hash，query，fullPath，matched，name 等路由信息参数。

而 $router 是“路由实例”对象包括了路由的跳转方法，钩子函数等。
## 组件渲染和更新过程
渲染组件时，会通过 Vue.extend 方法构建子组件的构造函数，并进行实例化。最终手动调用 $mount() 进行挂载，更新组件时会 进行 patchVnode 流程，核心是 diff 算法。

## provide / inject 使用
```!
provide 和 inject 主要在开发高阶插件/组件库时使用。并不推荐用于普通应用程序代码中。
```
这对选项需要一起使用，以允许一个祖先组件向其所有子孙后代注入一个依赖，不论组件层次有多深

```js
//父级组件 a.vue
export default {
  name: "VmRadioGroup",
  props: {
    value: null
  },
  provide() {
    return {
      RadioGroup: this
    };
  }
};

// 子组件注入
export default {
  name: "VmRadio",
  inject: {
    RadioGroup: {
      default:  ""
    }
  },
};

```
## 简单介绍 一下 Vuex 
Vuex 是一个专门为 Vue 应用程序开发的状态管理工具，每一个 Vuex 应用的核心是 store。Vuex 主要应用了**单例模式**，这样不管我们尝试去创建多少次，它都只会返回第一次创建的哪一个唯一的实例。

Vuex 主要包含一下几个模块：
- State：定义应用状态的数据结构
- Getter：允许组件从 Store 中获取数据，mapGetters 辅助函数仅仅是将 store 中的 getter 映射到局部计算属性。
- Mutation：唯一更改 store 中状态的方法，且必须为同步
- Action：用于 (commit) mutation，可包含任意异步操作
- Module：可将单一 Store 拆分为多个 store 且保存在单一状态树中

## 为什么 Vuex 的 mutation 中不能做异步操作
Vuex 中所有的状态更新的唯一途径都是通过 mutation，异步通过 Action 来提交 mutation实现，这样可以使我们方便地追踪每一个状态的变化。
如果 mutation 支持异步操作，那么就没有办法知道状态何时更新，，不能很好地追踪状态的变化，也给我们的调试带来困难。

<Vssue/>