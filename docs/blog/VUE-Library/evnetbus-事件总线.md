## 初始化
1. 创建 js 文件
   例如新创建 event-bus.js
```js
// event-bus.js
import Vue from 'vue'
export const EventBus = new Vue()
```

EventBus 实质上是一个不具备 dom 的组件，具有的仅仅是它的实例方法而已

2. 全局初始化
  在 main.js 初始化 EventBus
```js
Vue.prototype.$EventBus = new Vue()
```
## 发送事件与接收事件
例如有 a ，b 两个页面需要通信，a 页面发送事件， b 页面接收事件
```vue
// a 页面
<template>
    <button @click="sendMsg()">-</button>
</template>

<script> 
import { EventBus } from "../event-bus.js";
export default {
  methods: {
    sendMsg() {
      EventBus.$emit("aMsg", '来自A页面的消息');
    }
  }
}; 
</script>
```

```vue
b 页面
<template>
  <p>{{msg}}</p>
</template>

<script> 
import { 
  EventBus 
} from "../event-bus.js";
export default {
  data(){
    return {
      msg: ''
    }
  },
  mounted() {
    EventBus.$on("aMsg", (msg) => {
      // A发送来的消息
      this.msg = msg;
    });
  }
};
</script>
```

[具体参考](https://zhuanlan.zhihu.com/p/72777951)

