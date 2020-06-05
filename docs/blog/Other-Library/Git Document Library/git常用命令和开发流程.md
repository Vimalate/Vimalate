<!--
 * @Author: your name
 * @Date: 2020-06-05 22:01:51
 * @LastEditTime: 2020-06-05 23:06:38
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \vuepress-blog\docs\blog\Other-Library\Git Document Library\git.md
--> 
## 
git 在我们开发中几乎每天都要接触到，但是大多数时候却仅仅是熟悉常用的几个 git 命令，此次算是总结和记录一些 git 命令的使用，也进一步的了解 git及怎样在工作开发中正确使用 。


## git 命名规范
一个项目的分支，一般包括主干 master 和 开发分支 dev，以及若干临时分支

**分支命名规范**

```
分支:		命名:		说明:
 
主分支		master		主分支，所有提供给用户使用的正式版本，都在这个主分支上发布
开发分支		dev 		开发分支，永远是功能最新最全的分支
功能分支		feature-*	新功能分支，某个功能点正在开发阶段
发布版本		release-*	发布定期要上线的功能
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
