**原题 ：**

```
给定一个Excel表格中的列名称，返回其相应的列序号。

例如，

    A -> 1
    B -> 2
    C -> 3
    ...
    Z -> 26
    AA -> 27
    AB -> 28 
    ...
示例 1:

输入: "A"
输出: 1
示例 2:

输入: "AB"
输出: 28
示例 3:

输入: "ZY"
输出: 701
```

**解 ：**

```js
var titleToNumber = function (s) {
    let res = 0
    let base = 1 //每次*26的n次方，初始为1即为26的0次方
    for (let num of [...s].reverse()) {
        //如 AB 即为1*26^1+2*26^0=28,以此类推
        res += (num.charCodeAt() - 64) * base
        base *= 26
    }
    return res

};
```

