## 项目添加svgIcon

1. 安装 
  
```js
npm i svg-sprite-loader  -S
```

2. vue.config.js 中的 chainWebpack 修改

```js
const path = require('path')
function resolve(dir) {
  return path.join(__dirname, './', dir)
}

...

module.exports = {
  chainWebpack(config) {
    // set svg-sprite-loader
    config.module
      .rule('svg')
      .exclude.add(resolve('src/icons'))
      .end()
    config.module
      .rule('icons')
      .test(/\.svg$/)
      .include.add(resolve('src/icons'))
      .end()
      .use('svg-sprite-loader')
      .loader('svg-sprite-loader')
      .options({
        symbolId: 'icon-[name]'
      })
      .end()
  }
}
```

3. src下新建icons文件夹放svg文件

4. 编写svgIcon 组件,components下新建```SvgIcon.vue```

```vue
<template>
  <svg :class="svgClass" aria-hidden="true" 

  // /* aria-hidden="true"将元素从可访问树上移除 */

  v-on="$listeners">
    <use :xlink:href="iconName" />
  </svg>
</template>

<script>
export default {
  name: 'SvgIcon',
  props: {
    iconClass: {
      type: String,
      required: true
    },
    className: {
      type: String,
      default: ''
    }
  },
  computed: {
    iconName() {
      return `#icon-${this.iconClass}`
    },
    svgClass() {
      if (this.className) {
        return 'svg-icon ' + this.className
      } else {
        return 'svg-icon'
      }
    }
  }
}
</script>

<style scoped>
.svg-icon {
  width: 1em;
  height: 1em;
  vertical-align: -0.15em;
  fill: currentColor;
  overflow: hidden;
}
</style>
```

5. main.js中

```js
import SvgIcon from '@/components/SvgIcon'

const req = require.context('./icons', false, /\.svg$/)
const requireAll = requireContext => requireContext.keys().map(requireContext)

requireAll(req)
Vue.component('svg-icon',SvgIcon) // 全局注册
```

1. 使用

```vue
<svg-icon
  icon-class="ch"
  style="width: 2em; height: 2em;vertical-align:middle"
></svg-icon>
```

[svg图标封装组件 ](https://tatekii.github.io/2022/02/24/svg%E5%9B%BE%E6%A0%87%E5%B0%81%E8%A3%85%E7%BB%84%E4%BB%B6/)、[vue-element-admin使用svg图标](https://blog.csdn.net/qq2276031/article/details/107639303)