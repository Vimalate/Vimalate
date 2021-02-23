## 图片懒加载
通过添加 loading='lazy' 的属性来实现

```html
<img src="image.png" loading="lazy" alt="lazy" width="200" height="200" />
```

## Picture标签
你是否遇到过在不同场景或者不同尺寸的设备上面的时候，图片展示适配

<picture>标签，允许我们来添加多张图片资源，并且根据不同的分辨率需求来展示不同的图片。

```html
<picture>
  <source media="(min-width:768px)" srcset="med_flower.jpg">
  <source media="(min-width:495px)" srcset="small_flower.jpg">
  <img src="high_flower" style="width: auto;" />
</picture>
```