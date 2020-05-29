<!--
 * @Author: your name
 * @Date: 2020-04-03 01:45:05
 * @LastEditTime: 2020-05-30 02:12:19
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vuepress-blog\docs\blog\Other-Library\skill\skill.md
--> 
## 树状结构变一维数组

```js
flatten(arr) {
  return [].concat(...arr.map(item=>[].concat(item,...flatten(item.subitems))))
}
```
## 如何平滑滚动到页面顶部
```js
 const scrollToTop = () => {
         const c = document.documentElement.scrollTop || document.body.scrollTop;
  if (c > 0) {
    window.requestAnimationFrame(scrollToTop);
    window.scrollTo(0, c - c / 8);
  }
}

// 事例
scrollToTop()
```
window.requestAnimationFrame()  告诉浏览器——你希望执行一个动画，并且要求浏览器在下次重绘之前调用指定的回调函数更新动画。该方法需要传入一个回调函数作为参数，该回调函数会在浏览器下一次重绘之前执行。
requestAnimationFrame：优势：由系统决定回调函数的执行时机。60Hz的刷新频率，那么每次刷新的间隔中会执行一次回调函数，不会引起丢帧，不会卡顿。

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