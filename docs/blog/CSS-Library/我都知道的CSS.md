## 1、css盒模型
**box-sizing 属性：border-box、content-box**

context-box：W3C的标准盒子模型(默认)、

**盒子实际内容（content）的width/heigh**t=我们设置的width/height;**盒子总宽度/高度**=width/height+padding+border+margin。


border-box：IE传统盒子模型。  

**盒子的（content）宽度+内边距padding+边框border宽度**=我们设置的width(height也是如此)，**盒子总宽度/高度**=width/height + margin = 内容区宽度/高度 + padding + border + margin。
## 2、常见一些的兼容性问题
### 2.1 Chrome 中文界面下设置小于 12px 的文本显示

**解**：
```css
p{
    font-size:12px;
    -webkit-transform:scale(0.5);//0.5是缩放比例，即设置显示6px
} 

```

### 2.2  超链接访问过后hover样式就失效

原因：因为被点击访问过的超链接样式也就不再具有hover和active了  

**解：改变CSS属性的排列顺序为：L-V-H-A**  

```css
a:link {} 
a:visited {} 
a:hover {} 
a:active {}
```  
 

## 3、伪类和伪元素

常见伪类，如2.2中a标签的:link、:visited等  
常见伪元素，`::after ::before`  

简单理解：目视区别  **单冒号(:)用于CSS3伪类，双冒号(::)用于CSS3伪元素。** 从字面理解意思 **伪类就是假的类，伪元素就是假的元素。**  

**定义区别**：  
>CSS 伪类用于向某些选择器添加特殊的效果。  
CSS 伪元素用于将特殊的效果添加到某些选择器。  

伪类存在的意义是为了**通过选择器，格式化DOM树以外的信息以及不能被常规CSS选择器获取到的信息**  

当然，上面的你看起来可能有点难以理解，这说的啥玩意儿啊，那么下面我们从功能上来理解  

**伪类**的两种功能：  

1. 格式化DOM树以外的信息。比如： ```<a>``` 标签的:link、:visited 等。这些信息不存在于DOM树中。  
2. 不能被常规CSS选择器获取到的信息。比如：要获取第一个子元素，我们无法用常规的CSS选择器获取，但可以通过 :first-child 来获取到。

**伪元素**：**可以创建一些文档语言无法创建的虚拟元素**
我们可以在其中```<font    color='red'>```添加内容或样式```</font>```。如常见的利用**伪元素清除浮动。**

**总结，伪类与伪元素的区别在于：有没有创建一个文档树之外的元素。**  
 

## 4、当margin与padding的值设置为百分比时相对于谁？  

当margin和padding的值设置为百分比时，是指相对于**最近的块级父元素width（非总宽度）的相应百分比的值**，即使是margin-top、margin-bottom、padding-top、padding-bottom，设置为百分比时也是以最近块级父元素的width（非总宽度）为基准，而非height。  

## 5、 li 与 li 之间有看不见的空白间隔是什么原因引起的？如何解决？  

元素被当成行内元素排版的时候，元素之间的空白符（空格、回车换行等）都会被浏览器处理，根据CSS中white-space属性的处理方式（默认是normal，合并多余空白），原来HTML代码中的回车换行被转成一个空白符，在字体不为0的情况下，空白符占据一定宽度，所以inline-block的元素之间就出现了空隙。


**解：**  
1. 制造无空白条件，将```<li>```代码全部写在一排；
2. 利用浮动，浮动li中float：left；
3. 在ul中用font-size：0（谷歌不支持）；
4. 设置 ```ul{letter-spacing: -4px;};li{letter-spacing: normal;```

## 6、行内元素和块级元素的具体区别？行内元素的 padding 和 margin 是否可设置？  
**块级元素( block )：**

老大哥，总是独占一行；  
宽度(width)、高度(height)、内边距(padding)和外边距(margin)都可控制；

**内联元素(inline)特性：**

患难兄弟，和相邻的内联元素在同一行;  
宽度(width)、高度(height)、内边距的top/bottom(padding-top/padding-bottom)和外边距的top/bottom(margin-top/margin-bottom)都不可改变**即只有padding和margin的left和right是可以设置的。**

## 7、rgba() 和 opacity 区别
都能实现透明效果，**opacity（一人得道鸡犬升天的意味）作用于元素，以及元素内的所有的元素的透明度**，```rgba()```**只作用于元素的颜色或其背景色。**

## 8、CSS引入的方式使用Link和@import有什么区别？

两者都为外部引用CSS的方式，但是存在一定的区别
1. link是XHTML标签，除了加载CSS外，还可以定义RSS等其他事务；@import属于CSS范畴，只能加载CSS；
2. link引用CSS时，在页面载入时同时加载；@import需要页面网页完全载入以后加载；
3. link是XHTML标签，无兼容问题；@import是在CSS2.1提出的，低版本的浏览器不支持。
4. link支持使用Javascript控制DOM去改变样式；而@import不支持。

  

## 9、"nth-child"和"nth-of-type"的区别  
简单的字面理解：**“nth-of-type”** 即指定类型， 而**“nth-child”**，只要是其子代即可

“nth-child”选择的是父元素的子元素，这个子元素并没有指定确切类型，同时满足两个条件时方能有效果：其一是子元素，其二是子元素刚好处在那个位置；“nth-of-type”选择的是某父元素的子元素，而且这个子元素是指定类型。

  

## 10、CSS选择器的匹配规则？为什么？  

**CSS选择器的匹配是从右向左进行的**  

因为**考虑性能问题**，所以需要考虑的是如何在选择器不匹配时提升效率。从右向左匹配正是为了达成这一目的的，通过这一策略能够使得CSS选择器在不匹配的时候效率更高。

  

## 11、line-height: 2; 和 line-height: 200%; 有什么区别?

1. 父元素设置line-height:2会直接继承给子元素，子元素根据自己的font-size再去计算子元素自己的line-height。**即父、子元素各自计算。**  

2. 父元素设置line-height:200%是计算好了line-height值，然后把这个计算值给子元素继承，子元素继承拿到的就是最终的值了。此时子元素设置font-size就对其line-height无影响了。 **即父元素计算，子拿来即用** 

**举个栗子：**  
比如父元素设置属性：font- size：14px;**line-height: 2** , child设置font-size:26px;

那么父元素：line-height = 14px * 2 = 28px， **子元素：line-height = 26px * 2 = 52px。**

父元素设置属性：font-size:14px;**line-height:200%**,child设置font-size:26px;

那么父元素：line-height = 14px * 200% = 28px，**子元素：line-height = 父元素的line-height = 28px**

  

## 12、Canvas 和 SVG 有什么区别？
**Canvas**  
- 通过 JavaScript 来绘制 2D 图形。
- 是逐像素进行渲染的。
- 位置一旦发生改变，将重新进行绘制
- 依赖分辨率
- 能够以 .png 或 .jpg 格式保存结果图像
- 弱的文本渲染能力
- 最适合图像密集型的游戏，其中的许多对象会被频繁重绘

**SVG**   
- 使用XML描述的2D图形的语言
- SVG DOM中的每个元素都是可用的，可以为某个元素附加Javascript事件处理器。
- 不依赖分辨率
- 最适合带有大型渲染区域的应用程序（比如谷歌地图）
- 复杂度高会减慢渲染速度（任何过度使用 DOM 的应用都不快）
- 不适合游戏应用  

说了那么多，俺觉得还是丢链接实在[Canvas 和 SVG 有什么区别？
](https://www.zhihu.com/question/19690014)



## 13、啥是聚焦环，正确的解决方案？  
当使用按钮或链接标签获得焦点时，会得到一个可见的外边框，这就是聚焦环。它的种类依赖于根据浏览器提供商，但通常会显示一个蓝色的外边框包围在元素的周围，以表明它当前获得了焦点。

在过去，许多人指定outline: 0;来去除元素上的聚焦环。然而，由于不可见会对键盘用户访问性造成困扰。当不指定时，它会形成一个不吸引人的蓝色环显示在元素周围。  

然而```:focus-visible```可以很好的解决这个问题，他是非常年轻的一个伪类，目前仅Chrome浏览器标准支持，关于这个伪类具体可看这里[CSS :focus-visible伪类让我感动哭了](https://www.zhangxinxu.com/wordpress/2019/03/css-focus-visible/)



## 14、关于重绘与重排，以及一些优化问题？  
感觉俺要写不动了，这里看到有篇文章讲的不错  [浏览器重绘(repaint)重排(reflow)与优化[浏览器机制]](https://juejin.im/post/5c15f797f265da61141c7f86)

<div align=center>![](https://i.loli.net/2019/07/23/5d36e261a5a9726572.png) </div>



## 15、说说@media属性的四种类型  
1. `print`，指用于打印机的不透明介质。
2. `scren`，指屏幕设备
3. `tv`，电视类型媒体
4. `all`，所有媒体设备



## 16、transition和animation的区别  

这两货大部分属性相同，都是随时间改变元素的属性值，**主要区别**在于**transitionn**
需要触发一个事件才能改变属性，而**animation**不需要，animation和gif动态图差不多，立即播放。    

同时可以这样理解，**transition是从：hover延伸出来的**，不管是动态设置的还是非动态设置的过渡效果，只要过渡效果指定的属性值发生了变化就会触发过渡效果。**animation是从flash延伸出来的，使用关键帧的概念，**  



## 17、CSS 通用兄弟选择器和相邻兄弟选择器区别？  
通用兄弟选择器 `~` 会选择指定元素**所有**的兄弟元素   

**举个栗子：下例会选择 ```div```元素所有的 ```p```兄弟元素**  
```css
div ~ p {
    background-color:cyan;
}
```  
相邻兄弟选择器 ```+```会选择指定元素**相邻**的兄弟元素   


*~~整那么多都没用~~*，简单字面理解就完事，**通用兄弟选择**就是**一条船上，生死患难，大家都得是兄弟**，**相邻兄弟**就是**邻居比亲兄弟还亲。**

  

## 清除浮动原理
```css
.clearfix::after {
    content: '';
    display: block;
    clear: both;
    visibility: hidden;
    height: 0;
}
```
关键在于 ```clear``` 他是CSS中的定位属性，规定元素的哪一侧不允许其他浮动元素是CSS中的定位属性，规定元素的哪一侧不允许其他浮动元素，所以 ```clear:both``` 作用即为在左右不允许浮动元素。
## BFC
  
BFC 是页面的一块渲染区域，拥有一套渲染规则，确定位于其内的子元素如何定位，以及和其他的元素关系及相互作用。
**简单来说就是一个决定如何渲染元素的容器**

## flex: 0 1 auto 表示什么意思
弹性盒子默认值，分别表示 放大比例：```flex-grow```，缩小比例：  ```flex-shrink```和分配多余空间之前占的主轴比例： ```flex-basis``` 的简写，

## CSS3 新特性
-	边框属性:```border-radius、box-shadow和border-image```
-	选择器：```:read-only 、:nth-child(n)、:before、:after等```
-	渐变：```线性渐变（Linear Gradients）、径向渐变（Radial Gradients）```
-	盒模型:```resize、box-sizing、outline```
-	弹性盒：```flex```
-	动画：```transtion、animation```

## CSS优先级
!important>行内样式>id选择器>类选择器>标签>*通配符>继承>浏览器默认属性

css选择器的解析原则：选择器定位DOM元素从左往右，能够尽早过滤一些不必要规则，效率更高。


<Vssue/>