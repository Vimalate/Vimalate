# $ref和$el区别

## $ref

```$ref``` 被用来给元素或子组件注册引用信息

ref 有三种用法：

　- 1、 ref 加在普通的元素上，用this.$refs.（ref值） 获取到的是dom元素
　- 2、ref 加在子组件上，用this.$refs.（ref值） 获取到的是组件实例，可以使用组件的所有方法。在使用方法的时候直接this.$refs.（ref值）.方法（） 就可以使用了。
　- 3、如何利用 v-for 和 ref 获取一组数组或者dom 节点


## $el

获取Vue实例关联的DOM元素；

比方说我这里想获取自定义组件tabControl，并获取它的OffsetTop。就需要先获取该组件。

在组件内设置   属性 ref='一个名称(tabControl2)', 

然后 this.$refs.tabControl2     就拿到了该组件 

切记：ref属性，而获取组件的时候要用$refs

获取  OffsetTop，组件不是DOM元素，是没有OffsetTop的，无法通过 点 .OffsetTop来获取的。就需要通过$el来获取组件中的DOM元素


[详情：$ref和$el区别](https://www.cnblogs.com/hope192168/p/11966104.html)