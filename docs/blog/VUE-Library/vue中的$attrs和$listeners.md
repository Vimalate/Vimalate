## vue中的$attrs和$listeners
多级组件嵌套需要传递数据时，通常使用的方法是通过vuex。如果仅仅是传递数据，而不做中间处理，使用 vuex 处理，这就有点大材小用了。所以就有了 $attrs / $listeners ，通常配合 inheritAttrs 一起使用。

感觉还是挺晦涩难懂的，简单的说就是 inheritAttrs：true 继承除props之外的所有属性；inheritAttrs：false 只继承class属性。

- $attrs:包含了父作用域中不被认为 (且不预期为) props 的特性绑定 (class 和 style 除外)，并且可以通过 v-bind=”$attrs” 传入内部组件。当一个组件没有声明任何 props 时，它包含所有父作用域的绑定 (class 和 style 除外)。
- $listeners:包含了父作用域中的 (不含 .native 修饰符) v-on 事件监听器。它可以通过 v-on=”$listeners” 传入内部组件。它是一个对象，里面包含了作用在这个组件上的所有事件监听器，相当于子组件继承了父组件的事件。

$attrs 和 $listeners 在创建高级别的组件时非常有用。

### 禁用attribute继承在根节点

![](https://gitee.com/lj107571/image-for-picgo/raw/master/img/%E7%A6%81%E7%94%A8Attribute%E7%BB%A7%E6%89%BF.png)

[详情](https://segmentfault.com/a/1190000022708579)

