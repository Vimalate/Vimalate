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

## cnpm 临时使用
```npm --registry=https://registry.npm.taobao.org install```