## axios.all解决并发请求
1.  npm i axios --save-dev
2.  main.js 引入axios，挂载在原型上，全局使用
```js
//main.js
import axios from 'axios'
Vue.prototype.$axios=axios
```
3. 在组件中使用 axios.all() 和 axios.spread() 处理并发请求
```js
//index.vue
methonds:{
  getOne(){
    return this.$axios.post(url,params)
  },
  getTwo(){
    return this.$axios.get(url2)
  }
}

mounted(){
  this.$axios.all([getOne(),getTwo()]).then(()=>{
    this.$axios.spread((one,two)=>{
      console.log('所有请求都完成')
      console.log('请求1结果',one)
      console.log('请求2结果',two)
    })
  })
}
```

>请求都执行完，才执行 axios.spread() 中的函数，且 axios.spread() 回调函数返回值中的请求结果的顺序和请求的顺序一致