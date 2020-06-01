<!--
 * @Author: your name
 * @Date: 2020-04-04 20:00:38
 * @LastEditTime: 2020-06-01 22:28:37
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vuepress-blog\docs\blog\Javascript-Library\Javascript 面试题.md
--> 
# Javascript 面试题

## JS 类型
**基本类型**
- Undefined
- Null
- String
- Symbol
- Number
- Object
- Bigint
- Boolean

**复杂类型**
- Object
## JavaScript 有几种类型的值？存储位置？

 js 可分为两种数据类型：```原始数据类型和引用数据类型```。

 **原始数据类型( String、Number、Null、Undefined、Boolean、Symbol )**，原始数据类型存放在栈中。

**引用数据类型（对象、数组和函数）**，引用数据类型的值保存在堆中，引用数据类型在栈中存储了指针，该指针指向堆中该实体的起始地址。当解释器寻找引用值时，会首先检索其在栈中的地址，取得地址后从堆中获得实体。

## 怎么理解闭包，作用是什么？

闭包是指有权访问另一函数作用域中变量的函数，其最常见的为函数 A 内创建函数 B ，函数 B 可以访问函数 A 的局部变量。

作用：
- 我们可以通过在外部调用闭包函数，在函数外部访问到函数内部的变量。用这种方式创建私有变量。
- 存储这个变量，使得这个变量不会被回收。注：(这也是常说的闭包造成内存泄漏)

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
参考：(原生js灵魂之问)[https://juejin.im/post/5dac5d82e51d45249850cd20#heading-12]
<Vssue/>
