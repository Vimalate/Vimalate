## Vue的provide、inject

**祖组件：**
```js
provide() {
  return {
    elForm: this
  };
},
```

子孙组件

```js
inject: ['elForm'],
```
[参考](https://zhuanlan.zhihu.com/p/184967263)
