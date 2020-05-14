# CSS 技巧

## css实现文本溢出显示 ...

**单行文本 :**
```
overflow: hidden;
text-overflow:ellipsis;
white-space: nowrap;
当然还需要加宽度width属来兼容部分浏览。
```
**多行文本（如3行）**

```
display: -webkit-box;
-webkit-box-orient: vertical;
-webkit-line-clamp: 3;
overflow: hidden;
```
>1、-webkit-line-clamp用来限制在一个块元素显示的文本的行数。 为了实现该效果，它需要组合其他的WebKit属性。常见结合属性：
2、display: -webkit-box; 必须结合的属性 ，将对象作为弹性伸缩盒子模型显示 。
3、-webkit-box-orient 必须结合的属性 ，设置或检索伸缩盒对象的子元素的排列方式 。

## postion fixed和transform的冲突

我们知道这里 fixed 默认参照对像是**可视窗口**，如果transformEle (父元素)使用了transform，而fixedEle (子元素)使用了position: fixed，那么position: fixed不会有固定在可视窗口上，实际结果相当于相对transformEle元素定位，**就是fixed相对的不是可视窗口，而是transformELe**, 产生这样的原因主要是因为**transform和position: fixed使用了不同的坐标系统**

## 已知父级盒子的宽高，子级img宽高未知，想让img铺满父级盒子且图片不能变形

利用 CSS 的`object-fit` 属性

关于[object-fit 详细](https://developer.mozilla.org/zh-CN/docs/Web/CSS/object-fit)

```css
div {
    width: 100px;
    height: 100px;
}
img {
    object-fit: cover;
    width: 100%;
    height: 100%;
}
```
## 设置 平行 rem 布局

```scss
scss 文件
$ratio: 375 / 10;

@function px2rem($px) {
  @return $px / $ratio + rem;
}
```
然后所需要使用 px2rem() 的文件引入即可

## 什么是替换元素？

```
通过修改某个属性值呈现的内容就可以被替换的元素就称为“替换元素”。因此，<img>、<object>、<video>、<iframe>或者表
单元素<textarea>和<input>和<select>都是典型的替换元素。

替换元素除了内容可替换这一特性以外，还有以下一些特性。

（1）内容的外观不受页面上的CSS的影响。用专业的话讲就是在样式表现在CSS作用域之外。如何更改替换元素本身的外观需要
类似appearance属性，或者浏览器自身暴露的一些样式接口，

（2）有自己的尺寸。在Web中，很多替换元素在没有明确尺寸设定的情况下，其默认的尺寸（不包括边框）是300像素×150像
素，如<video>、<iframe>或者<canvas>等，也有少部分替换元素为0像素，如<img>图片，而表单元素的替换元素
的尺寸则和浏览器有关，没有明显的规律。

（3）在很多CSS属性上有自己的一套表现规则。比较具有代表性的就是vertical-align属性，对于替换元素和非替换元素，ve
rtical-align属性值的解释是不一样的。比方说vertical-align的默认值的baseline，很简单的属性值，基线之意，
被定义为字符x的下边缘，而替换元素的基线却被硬生生定义成了元素的下边缘。

（4）所有的替换元素都是内联水平元素，也就是替换元素和替换元素、替换元素和文字都是可以在一行显示的。但是，替换元素默认
的display值却是不一样的，有的是inline，有的是inline-block。
```

<Vssue/>