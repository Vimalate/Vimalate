<!--
 * @Author: your name
 * @Date: 2020-06-04 22:17:58
 * @LastEditTime: 2020-06-05 00:40:57
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vuepress-blog\docs\blog\Other-Library\Git Document Library\github搜索.md
--> 
## github 搜索
GitHub的流行，以及托管在github众多的开源项目。使得我们能够方便的搜索我们想要的项目。但是大多数时候你是否只是简单的在搜索框里输入检索的内容，然后在列表中查找，最多也就是限制一下语言这些呢

![](https://raw.githubusercontent.com/Vimalate/music/gh-pages/src/assets/img/1.jpg)

那么现在，你可以利用 github 的**高级搜索**，更高效，准确的找到自己想要的内容。
## 明确搜索仓库标题、仓库描述、README
以 Vue 为例
**in:in:name 关键字**

```in:name vue```

**in:readme 关键词**

```in:readme vue```

**in:descripton  关键词**

```in:descripton vue```

## 明确搜索 star、fork 数大于多少的
一般来说，star 数越多，表示大家对项目越认可。
**stars: > 数字 关键字。**

比如咱们要找 star 数大于 3000 的 vue 仓库，就可以这样
```stars:>3000 vue```

如果要找在指定数字区间的话，使用

**stars: 10..20 关键词**

当然，也可以fork 数，将stars换成 fork 即可

## 明确仓库是否还在更新维护
当我们需要查找某些开源产品，框架是否还在维护时，可以使用 pushed

**pushed:>2020-06-03 vue**

就可以找到，在 2020-06-03 还在维护，更新的项目。

## 组合使用
以上这些基本都是可以组合使用的，例如查找 readme 里描述 vue，且stars 数大于1000的项目。

```in:readme  stars:>1000 vue```