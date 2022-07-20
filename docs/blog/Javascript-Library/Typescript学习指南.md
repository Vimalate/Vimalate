## 前言


## 安装环境

### 安装typescript

首先，我们可以新建一个空文件夹，用来学习 ts，例如我文件夹下新建了个 ```helloworld.ts```


```shell
npm install -g  typescript // 全局安装 ts
```

不记得自己是否已经安装typescript，可以使用以下命令来验证是否已经安装：

```shell
tsc -v 
```
如果出现版本，则说明已经安装成功

```shell
Version 4.6.3
```

在我们```helloworld.ts```文件中,随便写点什么


```typescript
const s:string = "彼时彼刻，恰如此时此刻";
console.log(s);
```

控制台执行 ```tsc helloworld.ts``` 命令，目录下会生成了一个同名的 helloworld.js 文件，代码如下

```js
var s = "彼时彼刻，恰如此时此刻";
console.log(s);
```

通过tsc命令，我们的typescript代码被转换成了熟悉的js代码

再执行

```shell
node helloworld.js
```

即可看到输出结果

## 安装 ts-node

那么通过我们上面的一统操作，我们知道了运行tsc命令就可以编译生成一个文件，但是如果每次改动我们都要手动去执行编译，然后再通过 node命令才能查看运行结果岂不是太麻烦了。

而 ts-node 正是来解决这个问题的

```shell
npm i -g ts-node // 全局安装ts-node
```

这个插件可以直接运行.ts文件

```shell
ts-node helloworld.ts
```

可以看到我们的打印结果已经输出

但是这样还是显得麻烦，有没有可以监测变动，在每次改动后自动帮我们把 ts 编译成 js 

加个参数就可以解决

```shell
tsc --watch helloworld.ts
```

接下来我们正式进入到 typescript 的学习之旅

## TypeScript 基础类型

### Boolean 类型

```typescript
const flag: boolean = true;
```
### Number 类型
  
```typescript
const count: number = 10;
```

### String 类型
  
```typescript
  let name: string = "haunglaoye";
```

### Enum 类型

枚举类型用于定义数值集合，使用枚举我们可以定义一些带名字的常量。 使用枚举可以清晰地表达意图或创建一组有区别的用例。，如周一到周日，方位上下左右等

```typescript
  enum Color {Red, Green, Blue}
  const c: Color = Color.Red;
```

### Array 类型

对数组类型的定义有两种方式:

```typescript
  const arr: number[] = [1,2,3];
  const arr2: Array<number> = [1,2,3];
```

### 元组（tuple）类型

上面数组类型的方式，只能定义出内部全为同种类型的数组。对于内部不同类型的数组可以使用元组类型来定义

元组（ Tuple ）表示一个已知数量和类型的数组,可以理解为他是一种特殊的数组

```typescript
  const tuple: [number, string] = [1, "zhangmazi"];
```

>需要注意的是，元组类型只能表示一个已知元素数量和类型的数组，长度已指定，越界访问会提示错误。例如，一个数组中可能有多种类型，数量和类型都不确定，那就直接any[]。

### undefined和null

默认情况下 null 和 undefined 是所有类型的子类型。 也就是说你可以把 null 和 undefined 赋值给其他类型。

```typescript
  let a: undefined = undefined;
  let b: null = null;

  let str: string = 'zhangmazi';
  str = null; // 编译正确
  str = undefined; // 编译正确
```

如果你在tsconfig.json指定了"strictNullChecks":true ，即开启严格模式后， null 和 undefined 只能赋值给 void 和它们各自的类型。

```typescript
// 启用 --strictNullChecks
let x: number;
x = 1; // 编译正确
x = undefined;    // 编译错误
x = null;    // 编译错误
```

### any 类型

any会跳过类型检查器对值的检查，任何值都可以赋值给any类型

```typescript
  let value: any = 1;
  value = "zhangmazi"; // 编译正确
  value = []; // 编译正确
  value = {};// 编译正确
```

### void 类型
	
void 意思就是无效的, 一般只用在函数上，告诉别人这个函数没有返回值。

```typescript
  function sayHello(): void {
    console.log("hello 啊，树哥！");
  }
```

### never 类型

never 类型表示的是那些永不存在的值的类型。 例如never 类型是那些总是会抛出异常或根本就不会有返回值的函数表达式或箭头函数表达式的返回值类型

值会永不存在的两种情况：

- 1 如果一个函数执行时抛出了异常，那么这个函数永远不存在返回值（因为抛出异常会直接中断程序运行，这使得程序运行不到返回值那一步，即具有不可达的终点，也就永不存在返回了）
- 2 函数中执行无限循环的代码（死循环），使得程序永远无法运行到函数返回值那一步，永不存在返回。

```typescript
// 异常
function error(msg: string): never { // 编译正确
  throw new Error(msg); 
}

// 死循环
function loopForever(): never { // 编译正确
  while (true) {};
}
```

### Unknown 类型

unknown与any一样，所有类型都可以分配给unknown:

```typescript
  let value: unknown = 1;
  value = "zhangmazi"; // 编译正确
  value = false; // 编译正确
```

unknown与any的最大区别是：

> 任何类型的值可以赋值给any，同时any类型的值也可以赋值给任何类型。unknown 任何类型的值都可以赋值给它，但它只能赋值给unknown和any


## 对象类型

这里所说的对象类型，就是我们常说的```函数、{}、数组、类```

### object, Object 和 {} 类型

- object
object 类型用于表示所有的非原始类型，即我们不能把 number、string、boolean、symbol等 原始类型赋值给 object。在严格模式下，null 和 undefined 类型也不能赋给 object。

```ts
let object: object;
object = 1; // 报错
object = "a"; // 报错
object = true; // 报错
object = null; // 报错
object = undefined; // 报错
object = {}; // 编译正确
```

- Object
  
大 Object 代表所有拥有 toString、hasOwnProperty 方法的类型 所以所有原始类型、非原始类型都可以赋给 Object(严格模式下 null 和 undefined 不可以)

```ts
let bigObject: Object;
object = 1; // 编译正确
object = "a"; // 编译正确
object = true; // 编译正确
object = null; // 报错
ObjectCase = undefined; // 报错
ObjectCase = {}; // ok
```

- {}

{} 空对象类型和大 Object 一样 也是表示原始类型和非原始类型的集合

### 类

在 TypeScript 中，我们通过 Class 关键字来定义一个类

```ts
class Person {
  name: string;
  age: number;
  constructor(name: string, age: number) {
    this.name = name;
    this.age = age;
  }
  sayHi(): void {
    console.log(`Hi, ${this.name}`);
  }
}
```

### 数组

```ts
const flag1: number[] = [1, 2, 3];
const flag2: Array<number> = [1, 2, 3];
```

### 函数

#### 函数声明

```ts
function add(x: number, y: number): number {
  return x + y;
}
```

#### 函数表达式

```ts
const add = function(x: number, y: number): number {
  return x + y;
}
```

#### 接口定义函数

```ts
interface Add {
  (x: number, y: number): number;
}
```

#### 可选参数

```ts
function add(x: number, y?: number): number {
  return y ? x + y : x;
}
```

#### 默认参数

```ts
function add(x: number, y: number = 0): number {
  return x + y;
}
```

#### 剩余参数

```ts
function add(...numbers: number[]): number {
  let sum = 0;
  for (let i = 0; i < numbers.length; i++) {
    sum += numbers[i];
  }
  return sum;
}
```

#### 函数重载

函数重载或方法重载是使用相同名称和不同参数数量或类型创建多个方法的一种能力。

```ts
function add(x: number, y: number): number;
function add(x: string, y: string): string;
function add(x: any, y: any): any {
  return x + y;
}
```

上面示例中，我们给同一个函数提供多个函数类型定义，从而实现函数的重载

需要注意的是:
>函数重载真正执行的是同名函数最后定义的函数体 在最后一个函数体定义之前全都属于函数类型定义 不能写具体的函数实现方法 只能定义类型

[具体示例原理可参考](https://segmentfault.com/a/1190000042004610)



## 类型推论

如果没有明确的指定类型，那么 TypeScript 会依照类型推论的规则推断出一个类型。

```ts
let x = 1;
x = true; // 报错
```
上面的代码等价于

```ts
let x: string = 1;
x = true; // 报错
```

通过上述示例我们可以看出，我们没有给 x 指定明确类型的时候，typescript 会推断出 x 的类型是 string。

而如果定义的时候没有赋值，不管之后有没有赋值，都会被推断成 any 类型而完全不被类型检查：

```ts
let x;
x = 1; // 编译正确
x = true; // 编译正确
```

## 类型断言

某些情况下，我们可能比typescript更加清楚的知道某个变量的类型，所以我们可能希望手动指定一个值的类型

类型断言有两种方式

- 尖括号写法

```ts
let str: any = "to be or not to be";
let strLength: number = (<string>str).length;
```

- as 写法

```ts
let str: any = "to be or not to be";
let strLength: number = (str as string).length;
```

### 非空断言

在上下文中当类型检查器无法断定类型时，可以使用缀表达式操作符 `!` 进行断言操作对象是非 null 和非 undefined 的类型，**即x!的值不会为 null 或 undefined**
  
```ts
  let user: string | null | undefined;
  console.log(user!.toUpperCase()); // 编译正确
  console.log(user.toUpperCase()); // 错误
```
### 确定赋值断言


```ts
let value:number
console.log(value); // Variable 'value' is used before being assigned.
```

我们定义了变量, 没有赋值就使用，则会报错

通过 let x!: number; 确定赋值断言，TypeScript 编译器就会知道该属性会被明确地赋值。

```ts
let value!:number
console.log(value); // undefined 编译正确
```

## 联合类型

联合类型用```|```分隔，表示取值可以为多种类型中的一种

```ts
let status:string|number
status='to be or not to be'
status=1
```

## 类型别名

类型别名用来给一个类型起个新名字。它只是起了一个新名字，并没有创建新类型。类型别名常用于联合类型。

```ts
type count = number | number[];
function hello(value: count) {}
```


## 交叉类型

交叉类型就是跟联合类型相反，用```&```操作符表示，交叉类型就是两个类型必须存在

```ts
interface IpersonA{
  name: string,
  age: number
}
interface IpersonB {
  name: string,
  gender: string
}

let person: IpersonA & IpersonB = { 
    name: "师爷",
    age: 18,
    gender: "男"
};
```
person 即是 IpersonA 类型，又是 IpersonB 类型

>注意：交叉类型取的多个类型的并集，但是如果key相同但是类型不同，则该key为never类型

```ts
interface IpersonA {
    name: string
}

interface IpersonB {
    name: number
}

function testAndFn(params: IpersonA & IpersonB) {
    console.log(params)
}

testAndFn({name: "黄老爷"}) // error TS2322: Type 'string' is not assignable to type 'never'.
```




## 类型守卫


**类型保护是可执行运行时检查的一种表达式，用于确保该类型在一定的范围内**。 换句话说，类型保护可以保证一个字符串是一个字符串，尽管它的值也可以是一个数值。类型保护与特性检测并不是完全不同，其主要思想是尝试检测属性、方法或原型，以确定如何处理值。

换句话说：**类型守卫是运行时检查，确保一个值在所要类型的范围内**

目前主要有四种的方式来实现类型保护：

- 1、in 关键字

```ts
interface InObj1 {
    a: number,
    x: string
}
interface InObj2 {
    a: number,
    y: string
}
function isIn(arg: InObj1 | InObj2) {
    // x 在 arg 打印 x
    if ('x' in arg) console.log('x')
    // y 在 arg 打印 y
    if ('y' in arg) console.log('y')
}
isIn({a:1, x:'xxx'});
isIn({a:1, y:'yyy'});
```

- 2、typeof 关键字

```ts
function isTypeof( val: string | number) {
  if (typeof val === "number") return 'number'
  if (typeof val === "string") return 'string'
  return '啥也不是'
}
```

>typeof 只支持：typeof 'x' === 'typeName' 和 typeof 'x' !== 'typeName'，x 必须是  'number', 'string', 'boolean', 'symbol'。

- 3、instanceof

```ts
function creatDate(date: Date | string){
    console.log(date)
    if(date instanceof Date){
        date.getDate()
    }else {
        return new Date(date)
    }
}
```

- 4、自定义类型保护的类型谓词

```ts
function isNumber(num: any): num is number {
    return typeof num === 'number';
}
function isString(str: any): str is string{
    return typeof str=== 'string';
}
```

## 接口

我们使用接口来定义对象的类型。接口是对象的状态(属性)和行为(方法)的抽象(描述)

简单理解就是：**为我们的代码提供一种约定**

我们使用关键字interface来声明接口

```ts
interface Person {
    name: string;
    age: number;
}
let tom: Person = {
    name: 'Tom',
    age: 25
};
```

我们定义了一个接口 Person，接着定义了一个变量 tom，它的类型是 Person。这样，我们就约束了 tom 的形状必须和接口 Person 一致。

接口一般首字母大写。(当然挺多人也习惯 I 大写字母开头，用来表示这是一个接口)

### 设置接口可选|只读

```ts
interface Person {
  readonly name: string;
  age?: number;
}
```

- 可选属性，我们最常见的使用情况是，不确定这个参数是否会传，或者存在。

- 只读属性用于限制只能在对象刚刚创建的时候修改其值。此外 TypeScript 还提供了 ReadonlyArray<T> 类型，它与 Array<T> 相似，只是把所有可变方法去掉了，因此可以确保数组创建后再也不能被修改。

### 索引签名

有时候我们希望一个接口中除了包含必选和可选属性之外，还允许有其他的任意属性，这时我们可以使用 **索引签名** 的形式来满足上述要求。

>需要注意的是，一旦定义了任意属性，那么确定属性和可选属性的类型都必须是它的类型的子集

```ts
interface Person {
  name: string;
  age?: number;
  [prop: string]: any; //  propName字段必须是 string类型 or number类型。 值是any类型，也就是任意的
}

const p1 = { name: "张麻子" };
const p2 = { name: "树哥", age: 28 };
const p3 = { name: "汤师爷", sex: 1 }
```
我们规定 以 string 类型的值来索引，索引到的是一个 any 类型的值


### 接口与类型别名的区别

实际上，在大多数的情况下使用接口类型和类型别名的效果等价，但是在某些特定的场景下这两者还是存在很大区别。

>TypeScript 的核心原则之一是对值所具有的结构进行类型检查。 而接口的作用就是为这些类型命名和为你的代码或第三方代码定义数据模型。

>type(类型别名)会给一个类型起个新名字。 type 有时和 interface 很像，但是可以作用于原始值（基本类型），联合类型，元组以及其它任何你需要手写的类型。起别名不会新建一个类型 - 它创建了一个新名字来引用那个类型。给基本类型起别名通常没什么用，尽管可以做为文档的一种形式使用。




**接口和类型别名都可以用来描述对象或函数的类型，只是语法不同**

```ts
type MyTYpe = {
  name: string;
  say(): void;
}

interface MyInterface {
  name: string;
  say(): void;
}
```


**都允许扩展**

- interface 用 ```extends``` 来实现扩展


```ts
interface MyInterface {
  name: string;
  say(): void;
}

interface MyInterface2 extends MyInterface {
  sex: string;
}

let person:MyInterface2 = {
  name:'树哥',
  sex:'男',
  say(): void {
    console.log("hello 啊，树哥！");
  }
}
```
- type 使用 ```&``` 实现扩展

```ts
type MyType = {
  name:string;
  say(): void;
}
type MyType2 = MyType & {
  sex:string;
}
let value: MyType2 = {
  name:'树哥',
  sex:'男',
  say(): void {
    console.log("hello 啊，树哥！");
  }
}
```

### 不同点

- type可以声明基本数据类型别名/联合类型/元组等，而interface不行

```ts
// 基本类型别名
type UserName = string;
type UserName = string | number;
// 联合类型
type Animal = Pig | Dog | Cat;
type List = [string, boolean, number];
```

- interface能够合并声明，而type不行

```ts
interface Person {
  name: string
}
interface Person {
  age: number
}
// 此时Dog同时具有name和age属性
```

## 泛型

泛型是指在定义函数、接口或类的时候，不预先指定具体的类型，而在使用的时候再指定类型的一种特性。

举个例子，比如我们现在有个这样的需求，我们要实现一个这样的函数，函数的参数可以是任何值，返回值就是将参数原样返回，并且其只能接受一个参数，你会怎么做？




## 装饰器