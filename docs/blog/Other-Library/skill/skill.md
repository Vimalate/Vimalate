<!--
 * @Author: your name
 * @Date: 2020-04-03 01:45:05
 * @LastEditTime: 2020-07-09 23:04:28
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vuepress-blog\docs\blog\Other-Library\skill\skill.md
--> 
## cnpm 临时使用
```npm --registry=https://registry.npm.taobao.org install```

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
## 数组转树
```js
/**
 * 该方法用于将有父子关系的数组转换成树形结构的数组
 * 接收一个具有父子关系的数组作为参数
 * 返回一个树形结构的数组
 */
function translateDataToTree(data) {
  //没有父节点的数据
  let parents = data.filter(value => value.parentId == 'undefined' || value.parentId == null)
 
  //有父节点的数据
  let children = data.filter(value => value.parentId !== 'undefined' && value.parentId != null)
 
  //定义转换方法的具体实现
  let translator = (parents, children) => {
    //遍历父节点数据
    parents.forEach((parent) => {
      //遍历子节点数据
      children.forEach((current, index) => {
        //此时找到父节点对应的一个子节点
        if (current.parentId === parent.id) {
          //对子节点数据进行深复制，这里只支持部分类型的数据深复制，对深复制不了解的童靴可以先去了解下深复制
          let temp = JSON.parse(JSON.stringify(children))
          //让当前子节点从temp中移除，temp作为新的子节点数据，这里是为了让递归时，子节点的遍历次数更少，如果父子关系的层级越多，越有利
          temp.splice(index, 1)
          //让当前子节点作为唯一的父节点，去递归查找其对应的子节点
          translator([current], temp)
          //把找到子节点放入父节点的children属性中
          typeof parent.children !== 'undefined' ? parent.children.push(current) : parent.children = [current]
        }
      }
      )
    }
    )
  }
 
  //调用转换方法
  translator(parents, children)
 
  //返回最终的结果
  return parents
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

[Vue 开发必须知道的 36 个技巧](https://juejin.im/post/5d9d386fe51d45784d3f8637#heading-1)

## js && 符号妙用
在进行条件判断时，我们通常这样写
```js
if(index > -1){
  list.splice(index, 1)
}
```
然而换种写法可能更简洁
```js
index > -1 && list.splice(index, 1)
```

## 获取控制台打印的数据
1. 首先将需要获取的数据存储为全局对象

![](https://gitee.com/lj107571/imgformd/raw/master/20201016144240.png)

2. 然后控制台输入```copy(存储的全局对象)```

![](https://gitee.com/lj107571/imgformd/raw/master/20201016144743.png)

3. c+v 即可得到控制台输出的对象

## 控制台直接生成 .txt 文档

```js
file = new File(["foo"], "foo.txt", {
  type: "text/plain",
});

let aTag = document.createElement('a')
aTag.download = file.name;
aTag.href = URL.createObjectURL(file)
aTag.click()
```

<Vssue/>