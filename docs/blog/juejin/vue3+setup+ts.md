## 环境搭建

```sh
npm init vue@latest
```

## 使用工具

``` <script setup lang="ts"> + VSCode + Volar```

>安装 Volar 后，注意禁用 vetur

## ref 和 reactive

- ref: 用来给基本数据类型绑定响应式数据，访问时需要通过 .value 的形式， tamplate 会自动解析,不需要 .value
-  reactive: 用来给 复杂数据类型 绑定响应式数据，直接访问即可

>ref其实也是内部调用来reactive实现的


```vue
<template>
  <div>
    <p>{{title}}</p>
    <h4>{{userInfo}}</h4>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from "vue";
type Person = {
    name: string;
    age: number;
    gender?: string;
};
const title = ref<string>("彼时彼刻，恰如此时此刻");
const userInfo = reactive<Person>({
  name: '树哥',
  age: 18
})
</script>
```

## 计算属性与监听器

### 计算属性

```vue
<template>
  <div>
    <p>{{title}}</p>
    <h4>{{userInfo}}</h4>
    <h1>{{add}}</h1>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive,computed } from "vue";
const count = ref(0)

// 推导得到的类型：ComputedRef<number>
const add = computed(() => count.value +1)

</script>
```

## watch



>注意：defineProps 、defineEmits 、 defineExpose 和 withDefaults 这四个宏函数只能在 <script setup> 中使用。他们不需要导入，会随着 <script setup> 的处理过程中一起被编译。

[Vue3使用TypeScript的正确姿势](https://blog.csdn.net/lgno2/article/details/109446711)

[dynamic-theme-demos](https://github.com/GitOfZGT/dynamic-theme-demos)