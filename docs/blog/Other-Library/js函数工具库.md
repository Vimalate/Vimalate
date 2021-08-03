## 一维结构转树状结构
```js
    formatTree(arr) {
      // 有可能存在多个最外层的父级节点，先把他们找出来
      function findParents(arr) {
        // arr为原数组
        //通过reduce方法把数组转换成对象，作为一个哈希表（说白了就是个对象）存储他们的id
        const map = arr.reduce((obj, cur) => {
          let id = cur["id"]; // 获取每一项的id
          obj[id] = id;
          return obj;
        }, {});
        // 最后做一次筛选，找出最外层的父级节点数据
        // console.log(map[item.pId],'父级节点?') id 是否等于 pId
        arr = arr.filter((item) => !map[item.pId]);
        return arr;
      }
      let parents = findParents(arr); // 获取最外层父级节点
      // 查找每个parents 对应的子孙节点，此处开始递归
      function findChildren(parents) {
        if (!parents) return;
        parents.forEach((p) => {
          arr.forEach((item) => {
            // 如果原数组arr里面的每一项中的pId恒等于父级的某一个节点的id，则把它推进父级的children数组里面
            if (p.id === item.pId) {
              if (!p.children) {
                p.children = [];
              }
              p.children.push(item);
            }
          });
          // 最后进行一次递归，找儿子们的儿子们
          findChildren(p.children);
        });
      }
      findChildren(parents);
      return parents;
    },
```

## 数据深拷贝
```js
    deepCopy(data) {
      //深拷贝原数据
      if (data == null) return; // 如果为空则返回
      let typeOf = (d) => {
        return Object.prototype.toString.call(d);
      };
      let o = null;
      if (typeOf(data) === "[object Object]") {
        o = {};
        for (let k in data) {
          o[k] = this.deepCopy(data[k]);
        }
      } else if (typeOf(data) === "[object Array]") {
        o = [];
        for (let i = 0; i < data.length; i++) {
          o.push(this.deepCopy(data[i]));
        }
      } else {
        return data;
      }
      return o;
    }
```

## 遍历树型结构数组并获得某节点的所有父节点
```js
    // 遍历数组 查找节点的父节点
foreachAndSearchDeptParentNode (list,Id) {
  const self = this
  if (list) {
    for (let value of list) {
      if (Id === value.Id) { // 找到该节点
        if (value.parentId) { // 继续寻找该节点父节点的父节点，以此类推
          self.foreachAndSearchDeptParentNode (this.treeList,value.parentId) 
        }
        self.deptIdList.push(value.Id) 
      }
      if (Id !== value.Id){
        if (value.children) {
          self.foreachAndSearchDeptParentNode (value.children,Id)
        }
      }
    }
  }
}
```

## 模糊搜索
```js
 //模糊搜索
fuzzyQuery(list, keyWord) {
  var reg = new RegExp(keyWord);
  var arr = [];
  for (var i = 0; i < list.length; i++) {
    if (reg.test(list[i].name)) {
      arr.push(list[i]);
    }
  }
  return arr;
},
```

## 根据 object 每个 key 上值的数据类型，赋对应的初始值
```js
const cleanObject = (object: any) => {

  for (let key in object) {
    switch (getType(object[key])) {

      case 'string':
        object[key] = ''
        break

      case 'array':
        object[key] = []
        break

      case 'number':
        object[key] = 0
        break

      case 'boolean':
        object[key] = false
        break
    }
  }
}
```

## 访问多层级对象属性
```js
const checkNested = (obj) => {
  let args = Array.prototype.slice.call(arguments);
  obj = args.shift();

  for (let i = 0; i < args.length; i++) {
    if (!obj || !obj.hasOwnProperty(args[i])) {
      return false;
    }
    obj = obj[args[i]];
  }
  return true;
}

var test = {level1:{level2:{level3:'level3'}} };

checkNested(test, 'level1', 'level2', 'level3'); // true
checkNested(test, 'level1', 'level2', 'foo'); // false
```
## 监测数据类型

```js
const getType = function(obj) {
    let type = typeof obj
    if (type !== 'object') {
        return type
    }
    return Object.prototype.toString.call(obj).replace(/^\[object (\S+)\]$/, '$1').toLowerCase()
}
```

```js
const getType2=function(data) {
  Object.prototype.toString.call(data).slice(8, -1).toLowerCase()
}
```

## 下载文件

```js
/**
 * 下载文件
 * @param {String} api 接口
 * @param {Object} params 请求参数
 * 
 * @param {String} fileName 文件名
 */
const downloadFile = function (api, params, fileName, type = 'get') {
  axios({
    method: type,
    url: api,
    responseType: 'blob', //接收返回的类型 
    params: params
  }).then((res) => {
    let str = res.headers['content-disposition']
    if (!res || !str) {
      return
    }
    let suffix = ''
    // 截取文件名和文件类型
    if (str.lastIndexOf('.')) {
      fileName ? '' : fileName = decodeURI(str.substring(str.indexOf('=') + 1, str.lastIndexOf('.')))
      suffix = str.substring(str.lastIndexOf('.'), str.length)
    }
    //  如果支持微软的文件下载方式(ie10+浏览器)
    if (window.navigator.msSaveBlob) {
      try {
        const blobObject = new Blob([res.data]);
        window.navigator.msSaveBlob(blobObject, fileName + suffix);
      } catch (e) {
        console.log(e);
      }
    } else {
      //  其他浏览器
      let url = window.URL.createObjectURL(res.data)
      let link = document.createElement('a')
      link.style.display = 'none'
      link.href = url
      link.setAttribute('download', fileName + suffix)
      document.body.appendChild(link)
      link.click()
      document.body.removeChild(link)
    }
  }).catch((err) => {
    console.log(err.message);
  })
}
```