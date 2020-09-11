# 前端模块化：CommonJS,AMD,CMD,ES6

## CommonJS:

CommonJS规范为CommonJS小组所提出，目的是弥补JavaScript在服务器端缺少模块化机制，NodeJS、webpack都是基于该规范来实现的。
日常使用时，多用module.exports定义当前模块对外输出的接口，用require加载模块。

**module 变量代表当前模块，这个变量是一个对象.**


**module.exports(即module的exports属性) 是对外的接口。加载某个模块，其实是加载该模块的module.exports属性。```exports=module.exports={Obj}```**

**CommonJS 用法**
```js
//a.js
module.exports = function () {
  console.log("CommonJS")
}

//main.js
var a = require('./a');

a();//"CommonJS"
```
**CommonJS 特点：**
* 所有代码都运行在模块作用域，不会污染全局作用域。
* 模块首次加载，运行结果就被 **缓存** 了，以后再加载，就直接读取缓存结果。如想模块再次运行，必须清除缓存。
* 模块是同步加载的，即只有加载完成，才能执行后面的操作。
## AMD

AMD 采用**异步方式**加载模块，模块的加载不影响它后面语句的运行。允许指定回调函数，所有依赖这个模块的语句，都定义在一个回调函数中，等到加载完成之后，这个回调函数才会运行。

```require([module], callback);```

1. [module]，是一个数组，里面的成员就是要加载的模块；

2. callback，加载成功之后的回调函数。

RequireJS实现了AMD规范，所以一般说AMD也是指RequireJS。

**RequireJS的基本用法**

这里我们通过  ```define```  来定义一个模块，使用  ```require```  导入定义的模块

```js
// model.js
// 可以传入三个参数，分别是字符串-模块名、数组-依赖模块、函数-回调函数
define (function(){
  return 1
})
```

```js
// main.js
// 数组中声明需要加载的模块，可以是模块名、js文件路径
require(['model'], function(a){
    console.log(model);// 1
});
```
AMD 推崇依赖前置、提前执行


## CMD
CMD是SeaJS在推广过程中生产的对模块定义的规范

CMD 规范整合了CommonJS和AMD规范的特点。CMD 专门**用于浏览器端，模块的加载是异步的**，模块使用时才会加载执行

```js
/** sea.js **/
// 定义模块 model.js
define(function(require, exports, module) {
    var add = function(a,b){
        return a+b;
    }
    exports.add = add;
});
// 加载模块
seajs.use(['model.js'], function(model){
    var sum = model.add(1+2);
});
```
CMD推崇依赖就近、延迟执行,即到require时依赖模块才会执行。

## ES6 Module

ES6 中提供了简单的模块系统，完全可以取代现有的CommonJS和AMD规范，旨在成为浏览器和服务器通用的模块解决方案。

其模块功能呢主要由两个命令构成：
```export```  :用于规定模块的对外接口

```import```  :用于输入其他模块提供的功能。

**ES6 Module的基本用法**

```js
/** 定义模块 **/
// model.js
var name = 'biubiu'
var agr=23
export { name,age }

/** 引用模块 **/
// main.js
import { name, age, job} from './model.js';
```

ES6还提供了 ```export default```  命令，为模块指定默认输出，对应的```import```  语句不需要使用大括号。

```js
/** 定义模块 **/
// model2.js
export default function () {
  console.log('ES6 Module ');
}

//b2.js
import customName from './model2.js';
customName(); // 'ES6 Module'
```

需要注意的是ES6的模块不是对象，import命令会被 JavaScript 引擎静态分析，在编译时就引入模块代码，而不是在代码运行时加载，所以无法实现条件加载。也正因为这个，使得静态分析成为可能。

## 总结

**各自特点**
+ **CommonJS**规范主要用于**服务端编程**，加载模块是同步的，这并不适合在浏览器环境，因为同步意味着阻塞加载，浏览器资源是异步加载的，因此有了AMD CMD解决方案。
+ AMD规范在**浏览器环境中异步加载**模块，而且可以并行加载多个模块。不过，AMD规范开发成本高，代码的阅读和书写比较困难，模块定义方式的语义不顺畅。
+ CMD规范与AMD规范很相似，都用于浏览器编程，依赖就近，延迟执行。
+ ES6 在语言标准的层面上，实现了模块功能，而且实现得相当简单，完全可以取代 CommonJS 和 AMD 规范，成为浏览器和服务器通用的模块解决方案。

**区别**

**ES6 模块与 CommonJS 模块的差异**：

1. CommonJS 模块输出的是一个值的拷贝，ES6 模块输出的是值的引用。
2. CommonJS 模块是运行时加载，ES6 模块是编译时输出接口
3. CommonJS加载的是整个模块，将所有的接口全部加载进来，ES6 Module可以单独加载其中的某个接口；
4. CommonJS this指向当前模块，ES6 Module this指向undefined;

**AMD和CMD区别**

1. 对于依赖的模块，AMD 是提前执行，CMD 是延迟执行。（RequireJS 从 2.0 开始，也改成可以延迟执行（根据写法不同，处理方式不同）。CMD 推崇 as lazy as possible.）
2. CMD 推崇依赖就近，AMD 推崇依赖前置。

> 参考：[前端模块化详解](https://juejin.im/post/5c17ad756fb9a049ff4e0a62)
> [前端模块化](https://juejin.im/post/5aaa37c8f265da23945f365c)

<Vssue/>