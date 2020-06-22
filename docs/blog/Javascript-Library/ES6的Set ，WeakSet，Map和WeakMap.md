<!--
 * @Author: Vimalakirti
 * @Date: 2020-06-15 19:13:17
 * @LastEditTime: 2020-06-22 21:41:23
 * @Description: 
 * @FilePath: \vuepress-blog\docs\blog\Javascript-Library\ES6的Set ，WeakSet，Map和WeakMap.md
--> 
日常开发中，我们经常用 set 来做去重，map 来做数据的存储，但对set 和 map 是怎样的的数据结构了解不多。
## 集合(set)
```Set``` 是一种叫做集合的数据结构
```!
Set 本身是一个构造函数，用来生成 Set 数据结构（类似于数组）。Set 函数可以接受一个数组（或者具有 iterable 接口的其他数据结构）作为参数，用来初始化。Set 对象允许你存储任何类型的值，无论是原始值或者是对象引用。**它类似于数组**，但是成员的值都是唯一的，没有重复的值。
```
例如常见数组去重
```js
// 去重数组的重复对象
let arr = [1, 2, 3, 2, 1, 1]
[... new Set(arr)]    // [1, 2, 3]
```
### Set 实例对象的方法
- add(value)：添加某个值，返回 Set 结构本身(可以链式调用)。
- delete(value)：删除某个值，删除成功返回 true，否则返回 false。
- has(value)：返回一个布尔值，表示该值是否为 Set 的成员。
- clear()：清除所有成员，没有返回值。
```js
s.add(1).add(2).add(2)
// 注意2被加入了两次

s.size // 2

s.has(1) // true
s.has(2) // true
s.has(3) // false

s.delete(2)
s.has(2) // false
```
### 遍历方法
- keys()：返回键名的遍历器。
- values()：返回键值的遍历器。
- entries()：返回键值对的遍历器。
- forEach()：使用回调函数遍历每个成员。
```js
let set = new Set([1, 2, 3])
console.log(set.keys())    // SetIterator {1, 2, 3}
console.log(set.values())    // SetIterator {1, 2, 3}
console.log(set.entries())    // SetIterator {1, 2, 3}

for (let item of set.keys()) {
  console.log(item);
}    // 1    2     3
for (let item of set.entries()) {
  console.log(item);
}    // [1, 1]    [2, 2]    [3, 3]

set.forEach((value, key) => {
    console.log(key + ' : ' + value)
})    // 1 : 1    2 : 2    3 : 3
console.log([...set])    // [1, 2, 3]
```
### Array 和 Set 对比
- Array 的 indexOf 方法比 Set 的 has 方法效率低下
- Set 不含有重复值（可以利用这个特性实现对一个数组的去重）
- Set 通过 delete 方法删除某个值，而 Array 只能通过 splice。两者的使用方便程度前者更优
- Array 的很多新方法 map、filter、some、every 等是 Set 没有的（但是通过两者可以互相转换来使用）

## weakSet
WeakSet 对象允许你将弱引用对象储存在一个集合中

- WeakSet 只能储存对象引用，不能存放值，而 Set 对象都可以
- WeakSet 对象中储存的对象值都是被弱引用的，即垃圾回收机制不考虑 WeakSet 对该对象的应用，如果没有其他的变量或属性引用这个对象值，则这个对象将会被垃圾回收掉（不考虑该对象还存在于 WeakSet 中），所以，WeakSet 对象里有多少个成员元素，取决于垃圾回收机制有没有运行，运行前后成员个数可能不一致，遍历结束之后，有的成员可能取不到了（被垃圾回收了），WeakSet 对象是无法被遍历的（ES6 规定 WeakSet 不可遍历），也没有办法拿到它包含的所有元素

## 字典(map)
集合 与 字典 的区别:

- 共同点：集合、字典 可以储存不重复的值
- 不同点：集合 是以 [value, value]的形式储存元素，字典 是以 [key, value] 的形式储存

map中的 key 和 value 可以是任何类型的, 即对象也可以作为 key。 Map 的出现，就是让各种类型的值都可以当作键。Map 提供的是 “值-值”的对应。

### Map 和 Object 的区别
map 类似于对象，但他们也有不同
- Object 对象有原型， 也就是说他有默认的 key 值在对象上面， 除非我-们使用 Object.create(null)创建一个没有原型的对象；
- 在 Object 对象中， 只能把 String 和 Symbol 作为 key 值， 但是在 Map 中，key 值可以是任何基本类型(String, Number, Boolean, undefined, NaN….)，或者对象(Map, Set, Object, Function , Symbol , null….);
- 通过 Map 中的 size 属性， 可以很方便地获取到 Map 长度， 要获取 Object 的长度， 你只能手动计算

### Map 对象的方法
- set(key, val): 向 Map 中添加新元素
- get(key): 通过键值查找特定的数值并返回
- has(key): 判断 Map 对象中是否有 Key 所对应的值，有返回 true，否则返回 false
- delete(key): 通过键值从 Map 中移除对应的数据
- clear(): 将这个 Map 中的所有元素删除
```js
const m = new Map()
const o = { p: 'Hello World' }

m.set(o, 'content')
m.get(o) // "content"

m.has(o) // true
m.delete(o) // true
m.has(o) // false
```
### 遍历方法
- Keys()：将字典中包含的所有键名以迭代器形式返回
- values()：将字典中包含的所有数值以迭代器形式返回
- entries()：返回所有成员的迭代器
- forEach()：遍历字典的所有成员
```js
const map = new Map([
  ['a', 1],
  ['b', 2],
])

for (let key of map.keys()) {
  console.log(key)
}
// "a"
// "b"

for (let value of map.values()) {
  console.log(value)
}
// 1
// 2

for (let item of map.entries()) {
  console.log(item)
}
// ["a", 1]
// ["b", 2]

// 或者
for (let [key, value] of map.entries()) {
  console.log(key, value)
}
// "a" 1
// "b" 2

// for...of...遍历map等同于使用map.entries()

for (let [key, value] of map) {
  console.log(key, value)
}
// "a" 1
// "b" 2
```

## WeakMap
WeakMap 对象是一组键值对的集合，其中的键是弱引用对象，而值可以是任意。

注意，WeakMap 弱引用的只是键名，而不是键值。键值依然是正常引用。

WeakMap 中，每个键对自己所引用对象的引用都是弱引用，在没有其他引用和该键引用同一对象，这个对象将会被垃圾回收（相应的key则变成无效的），所以，WeakMap 的 key 是不可枚举的。

不能遍历，方法有 get、set、has、delete

## 总结
Set
- 是一种叫做集合的数据结构
- 成员唯一，无序且不重复
- 允许储存任何类型的唯一值，无论是原始值或者是对象引用
- 可以遍历，方法有：add、delete、has、clear

WeakSet
- 成员都是对象
- 成员都是弱引用，可以被垃圾回收机制回收，可以用来存储DOM
- 不能遍历，方法有 add、delete、has

Map
- 一种类似于字典的数据结构，本质上是键值对的集合
- 可以遍历，可以跟各种数据格式转换
- 操作方法有:set、get、has、delete、clear

WeakMap

- 只接受对象作为键名（null 除外），不接受其他类型的值作为键名
- 键名是弱引用，键值可以是任意的，键名所指向的对象可以被垃圾回收，此时键名是无效的
- 不能遍历，方法有 get、set、has、delete


参考：
[ES6的set，map](https://juejin.im/post/5ee71e92f265da76f65329fe)、[](https://juejin.im/post/5e1d2717e51d4557e97b109b)