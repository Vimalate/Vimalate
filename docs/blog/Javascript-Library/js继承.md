# js 里的继承

## 函数封装重载和面向对象

**类的继承、封装、多态**
- 封装 :低内聚高耦合
- 多态:重载和重写
>重载：方法名相同，形参个数或者类型不一样（js 中不存在真正意义上的重载，js 中的重载指同一个方法，根据参数不同，实现不同效果）
>重写：在类的继承中，子类可以重写弗雷德方法
- 继承：子类继承父类上的属性和方法

**面向对象**
是一种编程思想，js 本身基于面向对象构建，例如 js 中与很多得内置类，像是我们项目中常用的 promise，js中的面向对象和其他编程语言有所不同，js 中的类和实例是基于原型和原型链机制来处理的。

## 继承

### 原型链继承
原型链继承的原理很简单，直接让子类的原型对象指向父类实例，即使父类中的属性和方法在子类实例的原型链上
```js
function Parent() {
    this.name = 'Parent;
    this.arr[1,2,3]
}
//在父类的原型对象上添加一个getName方法
Parent.prototype.getName = function() {
    console.log(this.name);
}

function Child(){}

//  让子类的原型对象指向父类实例, 这样一来在Child实例中找不到的属性和方法就会到原型对象(父类实例)上寻找
Child.prototype = new Parent();
let child1= new Child() 
console.log(new Child)
```
![原型及原型链关系图](https://i.loli.net/2019/07/24/5d37cfe39a31b43977.png)
改变原型链指向

```Child.prototype=new parent()```

实际上，我们是不能直接 操作__proto__，所以

```Child.prototype = new Parent(); <=> Child.prototype.__proto__ = Parent.prototype```

**特点**： 
- 不像一般语言中的继承，（子类继承父类，是拷贝一份父类中的属性和方法），是把父类的原型放到子类实例的原型链上，实例想调取这些方法，得基于__proto__原型链查找完成。
- 子类可改写父类上的方法（会导致父类其他实例受影响）
- 父类中公有或私有的属性方法都会变成子类中公有的属性和方法。

### 借用构造函数(利用 call)
构造函数继承，即在子类的构造函数中执行父类的构造函数，并为其绑定子类的 ```this``` ,让父类构造函数把属性和方法挂载到```子类的this```上去，这样就避免了实例原型共享一个原型对象。还能像父类构造方法传参。
```js
 function Parent(name) {
    this.name = [name]
}
Parent.prototype.getName = function() {
    return this.name
}
function Child() {
    Parent.call(this, 'zhangsan')   // 执行父类构造方法并绑定子类的this, 使得父类中的属性能够赋到子类的this上
}

//测试
const child1 = new Child()
const child2 = new Child()
child1.name[0] = 'foo'
console.log(child1.name)          // ['foo']
console.log(child2.name)          // ['zhangsan']
child2.getName()                  // 报错,找不到getName(), 构造函数继承的方式继承不到父类原型上的属性和方法
//构造函数继承不能继承到父类原型链上的属性和方法
```

**call 继承特点：**
child 方法中把parents当做普通函数执行，让parents中的this 指向child的实例，相当于给child 的实例设置了私有的属性和方法。
    1. 只能继承父类私有的属性和方法，继承不到父类原型上的属性和方法
    2. 父类私有变为子类私有

### 组合继承
call 继承+类似于原型链继承

```Object.create()```

```js
/**
 * 组合方式
 */

function Parent() {
  this.name = 'Parent';
  this.play = [1, 2, 3];
}

Parent.prototype.say = function () { }

function Child () {
  Parent.call(this);
  this.type = 'Child';
}

Child.prototype = new Parent();

var s3 = new Child();
var s4 = new Child();
s3.play.push(4);
console.log(new Child);
console.log(s3.play, s4.play)
```

特点：父类私有和公有分别都为子类公有和私有

缺点：每次构建子类实例都执行了两次构造函数（Parent.call()和new Parent())），虽然并不影响子类对父类继承，但是子类创建实例时，原型中会存在两份相同的属性和方法，显得不优雅。

## 寄生式组合继承
将```指向父类实例```改为```指向子类实例```,这样就减少了一次构造函数的执行，从而解决了上面组合继承的问题

```js
function Parent(name) {
    this.name = [name]
}
Parent.prototype.getName = function() {
    return this.name
}
function Child() {
    // 构造函数继承
    Parent.call(this, 'zhangsan') 
}
//原型链继承
// Child.prototype = new Parent()
Child.prototype = Parent.prototype  //将`指向父类实例`改为`指向父类原型`
Child.prototype.constructor = Child

//测试
const child1 = new Child()
const child2 = new Child()
child1.name[0] = 'foo'
console.log(child1.name)          // ['foo']
console.log(child2.name)          // ['zhangsan']
child2.getName()                  // ['zhangsan']
```
但这种方式存在一个问题，由于子类原型和父类原型指向同一个对象，我们对子类原型的操作会影响到父类原型，例如给Child.prototype增加一个getName()方法，那么会导致Parent.prototype也增加或被覆盖一个getName()方法，为了解决这个问题，我们给Parent.prototype做一个浅拷贝

```js
function Parent(name) {
    this.name = [name]
}
Parent.prototype.getName = function() {
    return this.name
}
function Child() {
    // 构造函数继承
    Parent.call(this, 'zhangsan') 
}
//原型链继承
// Child.prototype = new Parent()
Child.prototype = Object.create(Parent.prototype)  //将`指向父类实例`改为`指向父类原型`
Child.prototype.constructor = Child

//测试
const child = new Child()
const parent = new Parent()
child.getName()                  // ['zhangsan']
parent.getName()                 // 报错, 找不到getName()
```

## ES6 继承
```class child extends parent{}```
```js
// ES6 

class parents {
    constructor(){
        this.grandmather = 'rose';
        this.grandfather = 'jack';
    }
}

class children extends parents{
    constructor(mather,father){
    //super 关键字，它在这里表示父类的构造函数，用来新建父类的 this 对象。
        super();
        this.mather = mather;
        this.father = father;
    }
}

let child = new children('mama','baba');
console.log(child) // =>
// father: "baba"
// grandfather: "jack"
// grandmather: "rose"
// mather: "mama"
```
**参考**
[隔壁小孩也能看懂的 7 种 JavaScript 继承实现](https://juejin.im/post/5ceb468af265da1bd1463585)、[实现继承](https://juejin.im/post/5e8b261ae51d4546c0382ab4#heading-12)

<Vssue/>