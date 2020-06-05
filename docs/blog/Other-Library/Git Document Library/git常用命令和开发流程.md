<!--
 * @Author: your name
 * @Date: 2020-06-05 22:01:51
 * @LastEditTime: 2020-06-06 01:20:54
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vuepress-blog\docs\blog\Other-Library\Git Document Library\git.md
--> 
## 前置知识
git 在我们开发中几乎每天都要接触到，但是大多数时候却仅仅是熟悉常用的几个 git 命令，此次算是总结和记录一些 git 命令的使用，也进一步的了解 git及怎样在工作开发中正确使用git版本管理 。

![](https://i.loli.net/2020/06/06/UpLvKRZwyW1eG9o.jpg)

**仓库**
1.  Remote: 远程主仓库；
2.  Repository： 本地仓库；
3.  Index： Git追踪树,暂存区；
4.  workspace： 本地工作区（即你编辑器的代码）

## git 命名规范
一个项目的分支，一般包括主干 master 和 开发分支 dev，以及若干临时分支

**分支命名规范**

```
分支:		命名:		说明:
 
主分支		master		主分支，所有提供给用户使用的正式版本，都在这个主分支上发布
开发分支		dev 		开发分支，永远是功能最新最全的分支
功能分支		feature-* (分支功能/分支名)	新功能分支，某个功能点正在开发阶段,一般开发新功能时，feature 分支都是基于 develop 分支下创建的
发布版本		release-*	发布定期要上线的功能，发布分支是从develop分支上面分出来的，预发布结束以后，必须合并进develop和master分支
修复分支		bug-*		修复线上代码的 bug
验证分支		demo-*      技术调研，完成后删除该分支
```
**commit 命名规范**

- feat:一个新功能
- fix：bug修复
- docs：仅仅修改了文档，比如 README, CHANGELOG, CONTRIBUTE 等
- style：不影响代码逻辑的修改，比如空格、格式缩进、删除分号等
- refactor：代码重构
- perf：提升性能的改动
- test：增加或修改测试
- chore: 改变构建流程、或者增加辅助工具、依赖库等

## git 常用命令
![](https://i.loli.net/2020/06/06/HbBJMf6axrp5nWk.jpg)

git pull = git fetch + git merge

参考：[git 教程](https://juejin.im/post/5c67e70bf265da2de33f127c)、[使用Git进行多人协作开发](https://juejin.im/post/5ecb6b41f265da770d3dae6e)