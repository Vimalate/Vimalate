```
给定一个正整数，返回它在 Excel 表中相对应的列名称。

例如 :
 1 -> A
    2 -> B
    3 -> C
    ...
    26 -> Z
    27 -> AA
    28 -> AB 
    ...
    
    示例 1:

输入: 1
输出: "A"

示例 2:

输入: 28
输出: "AB"

示例 3:

输入: 701
输出: "ZY"
```

**解 ：**

```js
var convertToTitle = function (n) {
    let res = ''
    while (n != 0) {
        n--
        //接收一个 Unicode 值，返回一个字符串
        res = String.fromCharCode(n % 26 + 65) + res
        n = parseInt(n / 26)
    }
    return res
}
```

**解说 ：** 从给出条件可以看出 26 一个循环，在 ASCII 中 A 对照为65，当循环一轮，如27，那么新的一轮位于初始第一个，所以n-- 才能对上 A ，即0=》65=》A。

