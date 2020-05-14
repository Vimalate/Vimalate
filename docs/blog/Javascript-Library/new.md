# 实现一个 new 操作符

首先，我们来看一道面试题
```js
function Person(name) {
    this.name = name
    return name;
}
let p = new Person('Viamlakirti');
console.log(p)//?
```
请问输出什么？
**'Viamlakirti'** ?你是不是想当然的回答，那么我告诉你错了，代码丢到控制台

![](https://i.loli.net/2019/07/26/5d39ef64748cf40026.png)

**what** ? 这是咋回事

要想明白咋回事？我们就得了解一下 new 的过程中到底发生了什么？

**MDN** 上是这样解释的 ：

new 运算符创建一个用户定义的对象类型的实例或具有构造函数的内置对象的实例。new 关键字会进行如下的操作：

1. 创建一个空的简单JavaScript对象（即{}）；

2. 链接该对象（即设置该对象的构造函数）到另一个对象 ；
   
3. 将步骤1新创建的对象作为this的上下文 ；

4. 如果该函数没有返回对象，则返回this。

好吧，还是不怎么明白，我们来个例子来理解 new 的作用，理解了作用，就能知道其原理

```js
function Person(name) {
  this.name = name
}
Person.prototype.sayName = function () {
    console.log(this.name)
}
const p = new Person('liu')
console.log(t.name) // 'liu'
t.sayName() // 'liu'
```
从这个例子我们可以得出：

- new 出来的实例可以访问到 Person 这个构造函数中的属性

- new 出来的实例可以访问到 Person 这个构造函数中**原型链中的属性** ，即通过 new 操作符，实例与构造函数通过原型链连接了起来

**从面试题到面试题** ：
我们回到开始的面试题，当我们进行 new 操作时，，return 了一个非对象，函数返回了构造函数实例化后的对象。让我们再看下面几个例子
```js
function Person1(name) {
  this.name = name;
  // 没有返回值
}

function Person2(name) {
  this.name = name;
  return name;
  // 返回非对象
}

function Person3(name) {
  this.name = name;
  return { a: 1 };
  // 返回对象
}

function Person4(name) {
  this.name = name;
  return null;
  // 返回null
}

var p1 = new Person1("aa");
var p2 = new Person2("bb");
var p3 = new Person3("cc");
var p4 = new Person4("dd");

console.log(p1); // Person1 {name: "aa"}
console.log(p2); // Person2 {name: "bb"}
console.log(p3); // {a: 1}
console.log(p4); // Person4 {name: "dd"}
```
通过以上例子：

+ **构造函数如果返回原始值，那么这个返回值毫无意义**

+ **构造函数如果返回值为对象，那么这个返回值会被正常使用**

好了，我们回顾下 new 操作符的几个作用 ：

+ **new 操作符会返回一个对象，所以我们需要在内部创建一个对象**


+ **这个对象，也就是构造函数中的 this，可以访问到挂载在 this 上的任意属性(改变 this 指向)**
  
+ **这个对象可以访问到构造函数原型上的属性，所以需要将对象与构造函数链接起来**
  
+ **返回原始值需要忽略，返回对象需要正常处理**

下面我们动手自己实现一个 new 
```js
function create(Con, ...args) {
  let obj = {}
  Object.setPrototypeOf(obj, Con.prototype)
  let result = Con.apply(obj, args)
  return result instanceof Object ? result : obj
}
```
各步骤详解：

1. 首先函数接受不定量的参数，第一个参数为构造函数，接下来的参数被构造函数使用;
   
2. 然后内部创建一个空对象 obj;

3. 因为 obj 对象需要访问到构造函数原型链上的属性，所以我们通过 setPrototypeOf 将两者联系起来。这段代码等同于 obj.__proto__ = Con.prototype;

4. 将 obj 绑定到构造函数上，并且传入剩余的参数;

5. 判断构造函数返回值是否为对象，如果为对象就使用构造函数返回的值，否则使用 obj，这样就实现了忽略构造函数返回的原始值

文档参考 :

[聊聊 new 操作符](https://juejin.im/post/5c7b963ae51d453eb173896e)

[理解 new 运算符](https://juejin.im/post/5c1bbc16e51d4552e01a0114)

<Vssue/>