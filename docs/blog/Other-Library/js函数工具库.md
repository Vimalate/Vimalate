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
        // console.log(map[item.pId],'父级节点?')
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