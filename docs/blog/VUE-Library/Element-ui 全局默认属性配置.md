## npm 引入

直接修改```main.js```
```js
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
// ElementUI默认配置
ElementUI.Dialog.props.closeOnClickModal.default = false
ElementUI.Autocomplete.props.triggerOnFocus.default = false
ElementUI.Autocomplete.props.highlightFirstItem.default = true
ElementUI.Table.props.border = { type: Boolean, default: true }
ElementUI.Table.props.highlightCurrentRow = { type: Boolean, default: true }
ElementUI.DatePicker.props.unlinkPanels = { type: Boolean, default: true }
ElementUI.DatePicker.props.startPlaceholder = { type: String, default: '开始日期' }
ElementUI.DatePicker.props.endPlaceholder = { type: String, default: '结束日期' }
```

## cdn 引入

引入CDN引入后是element-ui抛出的名字是ELEMENT,所以直接在public/index.html调整，其余框架应该类似
```html
<script src="https://unpkg.com/vue@2.6.10/dist/vue.js"></script>
<script src="https://unpkg.com/vuex@3.1.0/dist/vuex.min.js"></script>
<script src="https://unpkg.com/vue-router@3.0.6/dist/vue-router.min.js"></script>
<script src="https://unpkg.com/axios@0.18.1/dist/axios.min.js"></script>
<script src="https://unpkg.com/lodash@4.17.20/lodash.min.js"></script>
<script src="https://unpkg.com/element-ui@2.13.2/lib/index.js"></script>
<script src="https://unpkg.com/xlsx@0.16.7/dist/xlsx.min.js"></script>
<script>
  // 生产环境禁用debug与devtools
  Vue.config.productionTip = false
  Vue.config.devtools = false
  Vue.config.debug = false
  Vue.config.silent = true
  // 生产环境CDN引入配置element ui全局默认属性
  ELEMENT.Dialog.props.closeOnClickModal.default = false
  ELEMENT.Autocomplete.props.triggerOnFocus.default = false
  ELEMENT.Autocomplete.props.highlightFirstItem.default = true
  ELEMENT.Table.props.border = { type: Boolean, default: true }
  ELEMENT.Table.props.highlightCurrentRow = { type: Boolean, default: true }
  ELEMENT.DatePicker.props.unlinkPanels = { type: Boolean, default: true }
  ELEMENT.DatePicker.props.startPlaceholder = { type: String, default: '开始日期' }
  ELEMENT.DatePicker.props.endPlaceholder = { type: String, default: '结束日期' }
```

[ElementUI 全局设置组件的原生属性](https://blog.csdn.net/cuisini1/article/details/117413023?spm=1001.2101.3001.6650.2&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7Edefault-2.highlightwordscore&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7Edefault-2.highlightwordscore)