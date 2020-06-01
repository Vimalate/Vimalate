# 别再问我布局了喔

## 1、盒子垂直水平居中

提供四中解决方法 ：


1. 定位 盒子宽高已知， position: absolute; left: 50%; top: 50%; margin-left:-自身一半宽度; margin-top: -自身一半高度;

2. table-cell布局 父级 display: table-cell; vertical-align: middle;  子级 margin: 0 auto;

3. 定位 + transform ; 适用于 子盒子 宽高不定时； （这里是本人常用方法）
    
    position: relative / absolute;
    /*top和left偏移各为50%*/
       top: 50%;
       left: 50%;
    /*translate(-50%,-50%) 偏移自身的宽和高的-50%*/
    transform: translate(-50%, -50%); 注意这里启动了3D硬件加速哦 会增加耗电量的 （至于何是3D加速 请看浏览器进程与线程篇）

4. flex 布局
    父级： 
        /*flex 布局*/
        display: flex;
        /*实现垂直居中*/
        align-items: center;
        /*实现水平居中*/
        justify-content: center;


## 2、高度已知，三栏布局，左右宽度300，中间自适应



**效果如下 ：**

![](https://i.loli.net/2019/07/31/5d415877bac5331270.png)



### 1、float

html 部分，**center 放后面**

```html
<div class="container">
        <div class="left"></div>
        <div class="right"></div>
        <div class="center"></div>
</div>
```

**css 部分**

```css
.container {
            height: 200px;
        }

        .left {
            float: left;
            width: 300px;
            height: 100%;
            background: red;
        }

        .right {
            float: right;
            width: 300px;
            height: 100%;
            background: yellow;
        }

        .center {
            background: skyblue;
            height: 100%;
            margin: 0 300px;
        }
```



### 2、position 定位

HTML 不变

**css**

```css
.container {
            position: relative;
            height: 200px;
        }

        .container>div {
            position: absolute;
        }

        .left {
            left: 0;
            width: 300px;
            height: 100%;
            background: red;
        }

        .right {
            right: 0;
            width: 300px;
            height: 100%;
            background: yellow;
        }

        .center {
            background: skyblue;
            height: 100%;
            left: 300px;
            right: 300px;
        }
```

### 3、flex 布局

HTML  center 放置中间

```html
 <div class="container">
        <div class="left"></div>
        <div class="center"></div>
        <div class="right"></div>  
 </div>
```



**css**

```css
.container {
            display: flex;
            height: 200px;
        }

        .left {
            width: 300px;
            height: 100%;
            background: red;
        }

        .right {
            width: 300px;
            height: 100%;
            background: yellow;
        }

        .center {
            background: skyblue;
            height: 100%;
            flex: 1;
        }
```

### 4、table 布局

html 同 3

**ccs**

```css
.container {
            display: table;
            width: 100%;//注意，要加上  width: 100%; center 不设置 width 将会自适应
            height: 200px;
        }
        .container>div{
            display: table-cell;
        }
        .left {
            width: 300px;
            height: 100%;
            background: red;
        }

        .right {
            width: 300px;
            height: 100%;
            background: yellow;
        }

        .center {
            background: skyblue;
            height: 100%;
        }
```

### 5、Grid 布局

 网格布局 Grid第一个专门为解决布局问题而创建的CSS模块 (设置容器类型,然后设置列宽和行高，[Grid 详细了解](https://juejin.im/post/5d2d7a67f265da1bb5652b91#comment)

html 同 3

**css**

```css
.container {
            display: grid;
            grid-template-columns:300px auto 300px;
            width: 100%;
            height: 200px;
        }
        .left {
            height: 100%;
            background: red;
        }

        .right {
            height: 100%;
            background: yellow;
        }

        .center {
            background: skyblue;
            height: 100%;
        }
```

###  方案的一些缺点

方案1 2 ：float和position方案的有点是兼容性好,因为都是比较老的解决方案了,
缺点是float之后需要清除浮动造成的影响,
定位的话就是绝对定位之后脱离文档流了,你要注意用position:relative包裹一下

方案3 ： flex IE 8以下不兼容

方案4 ：语义化不佳

方案 5：并没有做到大部分浏览器兼容，不过以后grid是一个趋势



## 3、如何实现一个最大的正方形

利用 padding -bottom

原理：对元素的margin设置百分数时，百分数是相对于父元素的width计算，不管是margin-top/margin-bottom还是margin-left/margin-right。当然，padding的原理也是一样的。

```css
.section{
            width: 100%;
            padding-bottom: 100%;
            background-color: cyan;
        }
```

## 4、画一个直角三角形

利用 border

**代码 ：**

```css
 div {
        width: 0;
        border: 200px solid transparent;
        border-bottom-color: cyan;
        border-right-color: cyan;
     }
```

## 5、画一个书签

![](https://i.loli.net/2019/08/03/uhjOACltrQcdvaV.png)


```css
.bookmark {
            width: 0;
            height: 200px;
            border-left: 50px solid #ccc;
            border-right: 50px solid #ccc;
            border-bottom: 40px solid transparent;
        }
```

## 6、如何用css实现瀑布流布局

利用 column 属性
- column-count：指定列数
- column-gap: 设置列之间的间距

```vue
<template>
  <div class="waterfall-width-column">
    <div class="image-box" v-for="img in imgList" :key="img">
      <img :src="img" alt="" />
    </div>
  </div>
</template>
<style lang="scss" scoped>
.waterfall-width-column {
  column-count: 3;
  column-gap: 10px;
  .image-box {
    img {
      display: block;
      width: 100%;
    }
  }
}
</style>
```
## 一个自适应矩形，水平垂直居中，且宽高比为 2:1

```css
.box {
    position:absolute;
    top:0;
    right:0;
    bottom:0;
    left:0;
    margin:auto;

    width:10%;
    height:0;
    padding-top:20vw;
    background:red;
}

<Vssue/>