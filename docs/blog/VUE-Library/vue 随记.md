## v-for 和 v-if
v-for 优先级比 v-if要高，因此可在 v-for里再做if判断

```!
避免出现多的div dom结构,可把 v-for 层的div标签换成 template(template相当于占位)
```

它是可以显示template标签中的内容，但是查看后台的dom结构不存在template标签。如果template标签不放在vue实例绑定的元素内部默认里面的内容不能显示在页面上（即id="app"），但是查看后台dom结构存在template标签。


[关于template标签用法总结](https://blog.csdn.net/u010510187/article/details/100356624?utm_medium=distribute.pc_relevant.none-task-blog-2~default~baidujs_title~default-0.control&spm=1001.2101.3001.4242)

