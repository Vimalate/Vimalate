## router-view的v-slot

router-view 提供给我们一个插槽，可以用于 ```<transition>``` 和 ```<keep-alive>``` 组件来包裹你的路由组件：

```vue
<router-view v-slot="{ Component, route }">
	<transition appear name="fade-transform" mode="out-in">
		<keep-alive :include="cacheRouter">
			<component :is="Component" :key="route.path"></component>
		</keep-alive>
	</transition>
</router-view>
```
