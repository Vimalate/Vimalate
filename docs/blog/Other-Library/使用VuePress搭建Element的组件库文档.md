# 使用VuePress搭建Element的组件库文档

## 安装element

```sh
npm install element-ui
```



## 修改 enhanceApp.js
在 docs/.vuepress/enhanceApp.js（没有文件的则新建） 添加

```js
import Element from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
 
export default ({ Vue}) => {
  Vue.use(Element);
};
```

## 安装 vuepress-plugin-demo-container

```sh
npm i vuepress-plugin-demo-container --save-dev
```

虽然 VuePress 支持在 markdown 里直接写 vue 代码,但是我们可能需要写两份同样的代码，一份示例，一份展示，而使用此插件可以很好地做到不光有示例，还有展示示例代码

语法及使用文档[点此查看](https://docs.chenjianhui.site/vuepress-plugin-demo-container/zh/started.html#%E4%BD%BF%E7%94%A8)


## 使用自定义 vue 组件

创建目录"docs/.vuepress/components"

components 文件夹下新建 EllipsisTooltip.vue，这里我以二次封装 el-tooltip 的组件为例

```vue
<template>
  <el-tooltip :effect="dark" :content="text" :disabled="disableTip" :placement="placement">
    <div class="ellipsis" @mouseover="onMouseOver">
      <span ref="ellipsis" :style="{color:color}" class="text">{{text}}</span>
    </div>
  </el-tooltip>
</template>

<script>
export default {
  name: 'EllipsisTooltip',
  props: {
    text: { type: String, default: '' },
    placement: { type: String, default: 'top-start' },
    effect: { type: String, default: 'dark' },
    color:String
  },
  data() {
    return {
      disableTip: false,
    }
  },
  methods: {
    onMouseOver() {
      let parentWidth = this.$refs['ellipsis'].parentNode.offsetWidth
      let contentWidth = this.$refs['ellipsis'].offsetWidth
      this.disableTip = contentWidth <= parentWidth
    },
  },
}
</script>

<style scoped lang="css">
.ellipsis {
  width: 100%;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}
</style>
```

因为Vuepress可以自动识别components里面的组件并注册，所以我们的自定义组件写完后，就可以直接在md文档按照组件名字使用

## 引用自定义组件并编写组件案例

### 使用
```
::: demo
```vue
<div style="width:105px">
<EllipsisTooltip text="这是一段用来做组件示例的文字"></EllipsisTooltip>
</div>
\```
:::
```

### 案例
::: demo
```vue
<div style="width:125px">
<EllipsisTooltip text="这是一段用来做组件示例的文字"></EllipsisTooltip>
</div>
```
:::

这样，你就大功告成啦

![](https://gitee.com/lj107571/imgformd/raw/master/20220222155941.png)

