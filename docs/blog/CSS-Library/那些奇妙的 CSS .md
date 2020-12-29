## 画一个海浪

代码 ：

html

```html
<div class="wave"></div>
```
CSS 

```css
.wave {
            position: relative;
            width: 150px;
            height: 150px;
            background-color: #5291e0;
            overflow: hidden;
        }

        .wave::before,
        .wave::after {
            content: "";
            position: absolute;
            left: 50%;
            bottom: 45%;
            width: 500%;
            height: 500%;
            border-radius: 45%;
            background-color: #fff;
            transform: translateX(-50%);
            animation: rotate 15s linear infinite;
        }

        .wave::before {
            bottom: 40%;
            opacity: .5;
            border-radius: 47%;
        }

        @keyframes rotate {
            from {
                transform: translateX(-50%) rotateZ(0deg);
            }

            to {
                transform: translateX(-50%) rotateZ(360deg);
            }
        }
```

**效果 :**
 
 ![](https://user-gold-cdn.xitu.io/2019/8/8/16c70e84664a24d4?imageslim)

[原文具体实现原理解说](https://juejin.im/post/5d4c01dbf265da03e61afcfd)


## 设置最小字体大小
```css
//利用 calc()
.title {
    font-size: calc(14px + 2vw);
}
```
calc()CSS函数将具有一个最小值14px，并在些基础上添加2vw的值，有了这些，字体大小值就不会变得太小。
<Vssue/>