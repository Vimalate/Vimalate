## 场景一：根据 status 显示对应名称

### 使用对象
```js
const statusStr={
  '1':'待付款',
  '2': '待发货',
  '3': '已发货',
  '4': '交易完成',
  '5': '交易关闭',
  'default': '',
}

const getStatus=(status)=>{
  return statusStr[status]||statusStr['default']
}
```
### 利用 map
```js
const statusStr = new Map([
  ['1','待付款'],
  ['2','待发货'],
  ['3','已发货'],
  ['4','交易完成'],
  ['5','交易关闭'],
  ['default',''],
])
const getStatus = (status) =>{
  let actions = statusStr.get(status) || statusStr.get('default')
  return  actions;
}
```

## 场景升级：多个条件对应名称

```js
const onButtonClick = (status, identity) => {
  if (identity == "guest") {
    if (status == 1) {
      //do sth
    } else if (status == 2) {
      //do sth
    } else if (status == 3) {
      //do sth
    } else if (status == 4) {
      //do sth
    } else if (status == 5) {
      //do sth
    } else {
      //do sth
    }
  } else if (identity == "master") {
    if (status == 1) {
      //do sth
    } else if (status == 2) {
      //do sth
    } else if (status == 3) {
      //do sth
    } else if (status == 4) {
      //do sth
    } else if (status == 5) {
      //do sth
    } else {
      //do sth
    }
  }
};
```
### 将条件以字符串拼接方式存在 Map 对象里
```js
const actions = new Map([
  ["guest_1",() => { /*do sth*/},],
  ["guest_2",() => { /*do sth*/},],
  ["guest_3",() => { /*do sth*/},],
  ["guest_4",() => { /*do sth*/},],
  ["guest_5",() => { /*do sth*/},],
  ["master_1",() => { /*do sth*/},],
  ["master_2",() => { /*do sth*/},],
  ["master_3",() => { /*do sth*/},],
  ["master_4",() => { /*do sth*/},],
  ["master_5",() => { /*do sth*/},],
  ["default",() => { /*do sth*/},],
]);

const getAction=(identity,status)=>{
  let action = actions.get(`${identity}_${status}`)||actions.get('default')
   action.call(this)
}
```
### 将条件以字符串拼接方式存在 Object 对象里
```js
const actions={
  'guest_1':()=>{/*do sth*/},
  'guest_2':()=>{/*do sth*/},
  //...
}
const getAction=(identity,status)=>{
  let action = actions[`${identity}_${status}`]||actions['default']
  action.call(this)
  ```

## if 语句简化
示例：
```js
if(value === 'duck' || value === 'dog' || value === 'cat') {
  // ...
}
```
解决方法

```js
const options = ['duck', 'dog', 'cat'];
if (options.includes(value)) {
  // ...
}
```


## 函数条件调用

```js
function getInfo(){
  console.log('user1')
}

function getInfo2(){
  console.log('user2')
}

let status=1
if (status===1){
  getInfo()
} else {
  getINfo2()
}

(status===1?getInfo:getINfo2)()
```

## 复杂的逻辑

```js
function calculate(action, num1, num2) {
  const actions = {
    add: (a, b) => a + b,
    subtract: (a, b) => a - b,
    multiply: (a, b) => a * b,
    divide: (a, b) => a / b,
  };
​
  return actions[action]?.(num1, num2) ?? "Calculation is not recognised";
}
```

