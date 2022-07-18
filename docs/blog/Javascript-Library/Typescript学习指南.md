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
Version 4.0.2
```

在我们```helloworld.ts```文件中


```typescript
const s:string = "彼时彼刻，恰如此时此刻";
console.log(s);
```

控制台执行 ```tsc helloworld.ts``` 命令，目录下会生成了一个同名的 helloworld.js 文件