## 不设置 router-view 的 key 属性

vue 会复用相同组件，即 /page/1 => /page/2 或者 /page?id=1 => /page?id=2 这类链接跳转时, 将不在执行 created,mounted 之类的钩子, 这时候你需要在路由组件中, 添加 beforeRouteUpdate 钩子来执行相关方法拉去数据。
相关钩子加载顺序为：beforeRouteUpdate

## 设置 router-view 的 key 属性值为 $route.path

从 /page/1 => /page/2, 由于这两个路由的 $route.path 并不一样, 所以组件被强制不复用。
相关钩子加载顺序为：beforeRouteUpdate => created => mounted

从 /page?id=1 => /page?id=2, 由于这两个路由的 $route.path 一样, 所以和没设置key属性一样, 会复用组件。
相关钩子加载顺序为：beforeRouteUpdate

## 设置 router-view 的 key 属性值为 $route.fullPath

从/page/1 => /page/2, 由于这两个路由的$route.fullPath并不一样, 所以组件被强制不复用, 相关钩子加载顺序为:
beforeRouteUpdate => created => mounted

从/page?id=1 => /page?id=2, 由于这两个路由的$route.fullPath并不一样, 所以组件被强制不复用, 相关钩子加载顺序为:
beforeRouteUpdate => created => mounted

## 使用场景

使用Vue-router做项目时，会遇到如/serviceId/:id这样只改变id号的场景。由于router-view是复用的，单纯的改变id号并不会刷新router-view，而这并不是我们所期望的结果

### 使用 watch
```!
因为当id发生变化时，'$route'也会相应地发生变化，因此可以通过watch的方法来进行操作。
```

```js
watch: {
　　'$route': function (to, from) {
        this.$store.dispatch('updateActiveTemplateId', this.$route.params.templateId)
        // 通过更新Vuex中的store的数据，让数据发生变化
        this.getTemplateById()
　　}
}
```

### 改变router-view中的key

```js
<router-view :key="activeDate"></router-view>
//this.activeDate = new Date()
```
### 利用 beforeRouteLeave
```js
beforeRouteLeave (to, from, next) {
    // 导航离开该组件的对应路由时调用
    // 可以访问组件实例 `this`
}
```


[转载地址](https://www.jianshu.com/p/cf2fb443620f)
