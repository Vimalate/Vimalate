## 鼠标滚轮变换横向滚动

```js
// 使用时请把需变换滚动的目标 dom id设置成  "scroll-container"
export const setScroolMixin = {
  data() {
    return {
      targetDom: null,
    };
  },
  mounted(){
    this.$nextTick(()=>{
      this.setScrool()
    })
  },
  beforeDestroy() {
    if (this.targetDom) {
      this.targetDom.removeEventListener(
        "DOMMouseScroll",
        this.handlerMouserScroll
      );
      this.targetDom.removeEventListener(
        "mousewheel",
        this.handlerMouserScroll
      );
    }
  },
  methods: {
    /*容器绑定鼠标滚轮事件*/
    setScrool() {
      //绑定的容器
      this.targetDom = document.getElementById("scroll-container"); // 获取DOM元素节点
      // 添加监听事件（不同浏览器，事件方法不一样，所以可以作判断，也可以如下偷懒）
      this.targetDom.addEventListener(
        "DOMMouseScroll",
        this.handlerMouserScroll,
        false
      ); //滚轮事件
      this.targetDom.addEventListener(
        "mousewheel",
        this.handlerMouserScroll,
        false
      ); //滚轮事件
    },

    handlerMouserScroll(event) {
      //获取滚轮跨距，兼容获取方式
      let detail = event.wheelDelta || event.detail || event.wheelDeltaY;
      /*反向*/
      let moveForwardStep = -1;
      /*正向*/
      let moveBackStep = 1;
      let step = 0;
      //如果跨步大于0，表明正向跨步，将跨步放大100倍，改变滑动速度，如果跨步小于0，表明反向跨步，将跨步放大500倍，改变滑动速度
      step = detail > 0 ? moveForwardStep * 80 : moveBackStep * 80;
      /*覆盖当前滚动条的位置,单位是像素，叠增或剃减*/
      // this.targetDom.scrollLeft = this.targetDom.scrollLeft + step

      //平滑值(越小越平滑越持久，反之，总之。总之，不能小于等于0，不能大于等于1，作者建议值：0.8)
      let slipNum = 0.8;
      //末尾值（越小，则越平稳，越大，则越仓促，作者建议值：5）
      let endNum = 5;
      /*递减步伐最大初始值=滚轮单位跨步值*/
      let decreasingPaceNum = step;
      /*平滑速度，越大，则越慢，越小，则越慢，作者建议值：70*/
      let paceNum = 70;

      /*效果一*/
      let t = setInterval(() => {
        if (Math.abs(decreasingPaceNum) < endNum) {
          clearInterval(t);
          return;
        }
        decreasingPaceNum = decreasingPaceNum * slipNum;
        this.targetDom.scrollLeft =
          this.targetDom.scrollLeft + decreasingPaceNum;
      }, paceNum);
    },
  },
};
```