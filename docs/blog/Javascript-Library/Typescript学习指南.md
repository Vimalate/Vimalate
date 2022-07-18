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

-1 如果一个函数执行时抛出了异常，那么这个函数永远不存在返回值（因为抛出异常会直接中断程序运行，这使得程序运行不到返回值那一步，即具有不可达的终点，也就永不存在返回了）
-2 函数中执行无限循环的代码（死循环），使得程序永远无法运行到函数返回值那一步，永不存在返回。

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


