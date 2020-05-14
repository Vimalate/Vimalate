## 树状结构变一维数组

```js
flatten(arr) {
  return [].concat(...arr.map(item=>[].concat(item,...flatten(item.subitems))))
}
```

## ellipsis 指定宽度

## vue移动端禁止页面整体下拉

```js
#app {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    z-index: 0;
    width: 100%;
    height: 100%;
    background: #7d8188;
    overflow: hidden;
    -webkit-overflow-scrolling: touch;
  }
```

## 利用 a 标签解析 URL

```js
function parseURL(url) {
    var a =  document.createElement('a');
    a.href = url;
    return {
        host: a.hostname,
        port: a.port,
        query: a.search,
        params: (function(){
            var ret = {},
                seg = a.search.replace(/^\?/,'').split('&'),
                len = seg.length, i = 0, s;
            for (;i<len;i++) {
                if (!seg[i]) { continue; }
                s = seg[i].split('=');
                ret[s[0]] = s[1];
            }
            return ret;
        })(),
        hash: a.hash.replace('#','')
    };
}

```

## Vue 路由懒加载方法简易封装

```js
    /**
    *@parma {String} name 文件夹名称
    *@parma {String} component 视图组件名称
    */
    const getComponent = (name,component) => () => import(`@/views/${name}/${component}.vue`);
```

## Vue 里有用的招

在组件中有 input 时

v-model.trim ：自动过滤用户输入的首尾空白字符

和 v-model.number ：自动将用户的输入值转为数值类型

<Vssue/>