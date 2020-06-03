<!--
 * @Author: your name
 * @Date: 2020-06-03 12:23:46
 * @LastEditTime: 2020-06-03 12:52:31
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vuepress-blog\docs\blog\Other-Library\skill\vscode：解决操作git总让输入用户名及密码问题.md
--> 
## vscode：git总让输入用户名及密码问题
当使用 vscode 集成 git 操作时，vscode总让我们输入用户名及密码，是一件很繁琐的事情。
只需要打开终端，在定位在我们仓库的位置添加：```git config --global credential.helper store```

```js
C:\Users\liujian1\Desktop\面试\vuepress-blog\docs\.vuepress>git config --global credential.helper store
```