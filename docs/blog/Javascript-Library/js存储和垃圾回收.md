# js 存储和垃圾回收

##  js 存储数据方式

我们都知道 js 的数据类型有以下7种 ：

```js 
Number,String,Symbol,null,undefined,Boolean和Object
```

除了 Object 是复杂类型，其他皆为简单类型，他们的不同之处在于内存存储的方式。

内存分为堆内存(heap) 和 栈内存(stack),，js引擎在解析代码时：

- 遇到简单类型的声明，就在栈内存里开辟一个空间，将**简单类型的值放进去；**
- 如果遇到复杂类型，就在栈内存，堆内存分别开辟一个空间。将**自身的值放进堆内存**，并将存在堆内存的这块空间**的地址，放进栈内存**。
- 堆内存 中存的是我们声明的object类型的数据，栈内存 中存的是 基本数据类型 以及 函数执行时的运行空间。

## 看看这几题

我们在了解了 js 的存储方式后，来看看以下几题 :

1、

```js
var a = 1
var b = a
b = 2
console.log(a)
```

2、

```js
var a ={name:'vimalakirti'}
b = a
b.name = 'vmkt'
console.log(a)
```

3、

```js
var a ={name:'vimalakirti'}
b = a
b.name = {'name':'vmkt'}
console.log(a.name)
```

4、

```js
var a ={name:'vimalakirti'}
b = a
b= null
console.log(a.name)
```

答案揭晓：按题目顺序分别为  **2 、'vmkt' 、'vimalakirti' 、'vimalakirti'**

前两题应该很好理解，如果你还是感到困惑的话，那么可能确实需要加强一下 js 方面的基础知识。

**第 3 题 ：**

复杂类型拷贝的时候为，如果为赋值操作，那么拷贝的是引用，即第 3 题第三行 `b.name = {'name':'vmkt'}`, b.name 指向了另一堆内存中的值，并不会改变 a 的值。

**第 4 题 ：**

同第 3  题，将 b 重新赋值给了 null ，而我们知道null为 js 中的简单类型，存储在栈内存，也就是说 b 的引用不存在了，栈内存存储的是新赋的值，不再是引用。



**结论 ：**复杂类型的赋值操作，如果引用改变（地址改变），则 b 改变不影响原来 a 的值。

## 什么是垃圾回收？

程序的运行需要内存。只要程序提出要求，操作系统或者运行时就必须供给内存。所谓的内存泄漏简单来说是不再用到的内存，没有及时释放。为了更好避免内存泄漏。

由于字符串、对象和数组没有固定大小，所有当他们的大小已知时，才能对他们进行动态的存储分配。JavaScript程序每次创建字符串、数组或对象时，解释器都必须分配内存来存储那个实体。只要像这样动态地分配了内存，最终都要释放这些内存以便他们能够被再用，否则，JavaScript的解释器将会消耗完系统中所有可用的内存，造成系统崩溃。    ——《JavaScript权威指南（第四版）》

**即是说JavaScript垃圾回收是： 找出不再使用的变量，然后释放掉其占用的内存**

## 垃圾回收机制

垃圾回收有两种方法：**标记清除、引用计数**。

### 标记清除



**标记清除是 js 中最常用的垃圾回收方式** ，当变量进入执行环境是，就标记这个变量为“进入环境”。从逻辑上讲，永远不能释放进入环境的变量所占用的内存，因为只要执行流进入相应的环境，就可能会用到他们。当变量离开环境时，则将其标记为“离开环境”。

垃圾收集器在运行的时候会给存储在内存中的所有变量都加上标记。然后，它会去掉环境中的变量以及被环境中的变量引用的标记。而在此之后再被加上标记的变量将被视为准备删除的变量，原因是环境中的变量已经无法访问到这些变量了。最后。垃圾收集器完成内存清除工作，销毁那些带标记的值，并回收他们所占用的内存空间。

### 引用计数

引用计数核心原理是: 判断一个对象是否要被回收就是要看是否还有引用指向它,如果是"零引用",即引用次数为0 ，那么就回收。

但这种回收算法有一个严重缺陷—————循环引用

```js
function func() {
    let obj1 = {};
    let obj2 = {};

    obj1.a = obj2; // obj1 引用 obj2
    obj2.a = obj1; // obj2 引用 obj1
}

```

当函数 func 执行结束后，返回值为 undefined，所以整个函数以及内部的变量都应该被回收，但根据引用计数方法，obj1 和 obj2 的引用次数都不为 0，所以他们不会被回收。

## 常见内存泄漏

1. ### **忘记声明的局部变量**

```js
function a(){
    b=2
}

```

`b` 没被声明,会变成一个全局变量,在页面关闭之前不会被释放.使用严格模式可以避免.

2. ### **闭包带来的内存泄漏**

```js
function a(){
  let b=2
  return function(){
      console.log(b)
  }
}
```

b 在闭包中引用，不会被回收

3. ###  **定时器中的内存泄漏**

```js
var someResource = getData();
setInterval(function() {
    var node = document.getElementById('Node');
    if(node) {
        node.innerHTML = JSON.stringify(someResource));
    }
}, 1000);

```

这样的代码很常见，如果 id 为 Node 的元素从 DOM 中移除，该定时器仍会存在，同时，因为回调函数中包含对 someResource 的引用，定时器外面的 someResource 也不会被释放。

4. ### **移除 `DOM` 节点时候忘记移除暂存的值**

有时候出于优化性能的目的,我们会用一个变量暂存 `节点`,接下来使用的时候就不用再从 `DOM` 中去获取.但是在移除 `DOM` 节点的时候却忘记了解除暂存的变量对 `DOM` 节点的引用,也会造成内存泄漏

```js
var element = {
  image: document.getElementById('image'),
  button: document.getElementById('button')
};

document.body.removeChild(document.getElementById('image'));
// 如果element没有被回收,这里移除了 image 节点也是没用的,image 节点依然留存在内存中.

```

与此类似情景还有: `DOM` 节点绑定了事件, 但是在移除的时候没有解除事件绑定,那么仅仅移除 `DOM`节点也是没用的

参考：

[垃圾回收](https://juejin.im/post/5cb33660e51d456e811d2687)

[JavaScript中的垃圾回收和内存泄漏](https://juejin.im/post/5b4d421e5188251b200176a6)

[聊聊V8引擎的垃圾回收](https://juejin.im/post/5ad3f1156fb9a028b86e78be#heading-10)

<Vssue/>