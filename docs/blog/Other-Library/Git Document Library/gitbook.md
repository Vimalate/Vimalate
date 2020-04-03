# 使用gitbook serve/build 遇到的错误

使用gitbook serve/build 时，遇到

```
Vimalakirti>gitbook serve
Live reload server started on port: 35729
Press CTRL+C to quit ...

info: 18 plugins are installed
info: 14 explicitly listed
info: loading plugin "prism"... OK
info: loading plugin "copy-code-button"... OK
info: loading plugin "search-pro"... OK
info: loading plugin "expandable-chapters"... OK
info: loading plugin "splitter"... OK
info: loading plugin "github-buttons"... OK
info: loading plugin "donate"... OK
info: loading plugin "tbfed-pagefooter"... OK
info: loading plugin "baidu-tongji"... OK
info: loading plugin "anchor-navigation-ex"... OK
info: loading plugin "livereload"... OK
info: loading plugin "fontsettings"... OK
info: loading plugin "theme-comscore"... OK
info: loading plugin "theme-default"... OK
info: found 7 pages
info: found 8 asset files
warn: "options" property is deprecated, use config.get(key) instead
warn: "options.generator" property is deprecated, use "output.name" instead
init!

Error: ENOENT: no such file or directory, stat 'C:\Users\liujian1\Desktop\Vimalakirti\_book\gitbook\gitbook-plugin-theme-comscore\test.css'
```

于是乎，开启Google 大法，终于在 [gitbook 的 issue](https://github.com/GitbookIO/gitbook-cli/issues/55#) 找到解决办法

**按照issue的解决方法具体如下：**

首先进入到

> C:\Users\Administrator\.gitbook\versions\3.2.3\lib\output\website

然后找到文件**copyPluginAssets.js**，这里我选用vscode打开

找到**112**行

![112](https://i.loli.net/2019/07/23/5d370e0d8925f29931.png)  

将` confirm: true` 修改为 `false`

保存然后重新 gitbook serve/build 

OK，成功

```
Starting server ...
Serving book on http://localhost:4000

```



