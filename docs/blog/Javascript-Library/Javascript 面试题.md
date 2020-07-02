<!--
 * @Author: your name
 * @Date: 2020-04-04 20:00:38
 * @LastEditTime: 2020-07-02 19:15:24
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vuepress-blog\docs\blog\Javascript-Library\Javascript 面试题.md
--> 
# Javascript 面试题

## JS数据类型
**基本类型**
- Undefined
- Null
- String
- Symbol
- Number
- Bigint
- Boolean

**复杂类型**
- Object
## JavaScript 有几种类型的值？存储位置？

 js 可分为两种数据类型：```原始数据类型和引用数据类型```。

 **原始数据类型( String、Number、Null、Undefined、Boolean、Symbol )**，原始数据类型存放在栈中。

**引用数据类型（对象、数组和函数）**，引用数据类型的值保存在堆中，引用数据类型在栈中存储了指针，该指针指向堆中该实体的起始地址。当解释器寻找引用值时，会首先检索其在栈中的地址，取得地址后从堆中获得实体。

## Symbol使用场景
Symbol 是 ES6 引入了一种新的原始数据类型，他表示独一无二的值。

- 作为属性名的使用
- 定义常量
- 定义私有属性
  
具体用法[参考](https://juejin.im/post/5ebb6e1d6fb9a043365002a6#heading-4)

## null 和 undefined
- null表示“无”的对象（空对象指针），数据转换时转为数值0，undefined 表示“无”的原始值，转为数值 NaN
- 一般变量声明了但还没有定义的时候会返回 undefined，null 主要用于赋值给一些可能会返回对象的变量，作为初始化。
- 当我们对两种类型使用 typeof 进行判断的时候，Null 类型化会返回 “object”，这是一个历史遗留的问题。当我们使用双等 号对两种类型的值进行比较时会返回 true，使用三个等号时会返回 false。




## 怎么理解闭包，作用是什么？

闭包是指有权访问另一函数作用域中变量的函数，其最常见的为函数 A 内创建函数 B ，函数 B 可以访问函数 A 的局部变量。

作用：
- 我们可以通过在外部调用闭包函数，在函数外部访问到函数内部的变量。用这种方式创建私有变量。
- 存储这个变量，使得这个变量不会被回收。注：(这也是常说的闭包造成内存泄漏)
## 对作用域和作用域链的理解
- **作用域**：是定义变量的区域，它有着一套访问变量规则，这套规则用来管理浏览器引擎如何在作用域以及嵌套作用域根据变量进行变量查找。
- **作用域链**：作用域链的作用是保证对执行环境有权访问的所有变量和函数的有序访问，通过作用域链，我们可以访问到外层环境的变量和 函数。

在《JavaScript深入之变量对象》是这样说的，当查找变量的时候，会从当前上下文的变量对象中查找，如果没有查找到，则会从父级的执行上下文的变量对象查找，一直到全局对象。而由多个执行上下文的变量对象构成的链表就叫做作用域链。

## 箭头函数
箭头函数是es6引入的语法，和之前的function定义函数不同，箭头函数更简洁。

**箭头函数的注意事项**
- 不能作为构造函数，因为new的时候需要将this指向实例对象，而箭头函数没有自己的this
- 没有arguments(js内置对象，存放实参)
- 没有自己的this，所以不能用call()/apply()/bind() 来改变 this 指向
- 没有原型（不能使用 new 调用箭头函数）

**什么时候不能使用箭头函数**

- 调用对象上的方法
- 调用原型上的方法
- 动态上下文的回调函数
- 调用构造函数

[具体可见](https://juejin.im/post/5df86e555188251220308a46)

## arguments的对象是什么
arguments 的对象是函数传递参数值的对象。它类似于一个数组的对象，因为它有 length 属性，但是它没有数组内置的那些方法。像是 forEach、reduce、filter和map。

我们可以使用 Array.prototype.slice 将arguments对象转换成一个数组
```js
function (){
  retutn Array.prototype.slice.call(arguments)
}
```
```!
箭头函数没有自己的this
```
[Array.prototype.slice.call()方法详解](https://www.jianshu.com/p/c5df0156b229)
## 如何理解BigInt?
```!
BigInt是一种新的数据类型，用于当整数值大于Number数据类型支持的范围时。这种数据类型允许我们安全地对大整数执行算术操作，表示高分辨率的时间戳，使用大整数id，等等，而不需要使用库。
```
在JS中，所有的数字都以双精度64位浮点格式表示，那这会带来什么问题呢？
这导致JS中的Number无法精确表示非常大的整数，它会将非常大的整数四舍五入，确切地说，JS中的Number类型只能安全地表示-9007199254740991(-(2^53-1))和9007199254740991（(2^53-1)），任何超出此范围的整数值都可能失去精度。
```js
console.log(999999999999999);  //=>10000000000000000
```
同时也会有一定的安全性问题:
```js
9007199254740992 === 9007199254740993;    // → true 居然是true!
```
**如何创建并使用BigInt**

要创建BigInt，只需要在数字末尾追加n即可:
```js
console.log( 9007199254740995n );    // → 9007199254740995n	
console.log( 9007199254740995 );     // → 9007199254740996
```
另一种创建BigInt的方法是用BigInt()构造函数:
```js
BigInt("9007199254740995");    // → 9007199254740995n
```
简单使用:
```js
10n + 20n;    // → 30n	
10n - 20n;    // → -10n	
+10n;         // → TypeError: Cannot convert a BigInt value to a number	
-10n;         // → -10n	
10n * 20n;    // → 200n	
20n / 10n;    // → 2n	
23n % 10n;    // → 3n	
10n ** 3n;    // → 1000n	

const x = 10n;	
++x;          // → 11n	
--x;          // → 9n
console.log(typeof x);   //"bigint"
```
## typeof 于 instanceof 区别

>typeof 对于基本类型，除了 null都可以显示正确的类型
```js
typeof null // 'object'
```
而这也是一个历史遗留问题

typeof 对于对象，除了函数都会显示 object
```js
typeof [] // 'object'
typeof {} // 'object'
typeof console.log // 'function'
```
>instanceof 可以正确的判断对象的类型，因为内部机制是通过判断对象的原型链中是不是能找到类型的 prototype

这里我们可以试着动手实现一下 instanceof
```js
function myInstanceof(left, right) {
    //基本数据类型直接返回false
    if(typeof left !== 'object' || left === null) return false;
    //getProtypeOf是Object对象自带的一个方法，能够拿到参数的原型对象
    let proto = Object.getPrototypeOf(left);
    while(true) {
        //查找到尽头，还没找到
        if(proto == null) return false;
        //找到相同的原型对象
        if(proto == right.prototype) return true;
        proto = Object.getPrototypeOf(proto);
    }
}

```
```!
 instanceof 也能判断基本数据类型
```
```js
class PrimitiveNumber {
  static [Symbol.hasInstance](x) {
    return typeof x === 'number'
  }
}
console.log(111 instanceof PrimitiveNumber) // true
```
其实就是自定义instanceof行为的一种方式，这里将原有的instanceof方法重定义，换成了typeof，因此能够判断基本数据类型。

## [] == ![]结果是什么？为什么？

== 中两边转换为数字后开始比较

[] 转换为数字0

![] 先转换为 boolean，由于[]作为一个引用类型转换为布尔值为true

因此![]为false，进而在转换成数字，变为0。

0 == 0 ， 结果为true

## 对象转原始类型是根据什么流程运行的？
对象转原始类型，会调用内置的[ToPrimitive]函数，对于该函数而言，其逻辑如下：
1. 如果Symbol.toPrimitive()方法，优先调用再返回
2. 调用 valueof(),如果转换为原始类型，则返回
3. 调用 toString(), 如果转换为原始类型，则返回
4. 如果都没有返回原始类型，会报错
```js
var obj = {
  value: 3,
  valueOf() {
    return 4;
  },
  toString() {
    return '5'
  },
  [Symbol.toPrimitive]() {
    return 6
  }
}
console.log(obj + 1); // 输出7
```

##  使用Promise实现每隔1秒输出1,2,3
用 promise 配合 reduce 不停的在promise后面叠加 .then
```js
const arr=[1,2,3]
arr.reduce((p,x)=>{
  return p.then(()=>{
    return new Promise(res=>{
      setTimeout(()=>res(console.log(x),1000))
    })
  })
},Promise.resolve())
```
## requestAnimationFrame有了解过吗？

```requestAnimationFrame```是浏览器用于定时循环操作的一个接口，类似于```setTimeout```，主要用途是按帧对网页进行重绘。对于JS动画，用```requestAnimationFrame``` 会比 ```setInterval``` 效果更好。
具体可以看[这里](https://juejin.im/post/5e621f5fe51d452700567c32#heading-13)


参考：
[原生js灵魂之问](https://juejin.im/post/5dac5d82e51d45249850cd20#heading-12)
<Vssue/>
