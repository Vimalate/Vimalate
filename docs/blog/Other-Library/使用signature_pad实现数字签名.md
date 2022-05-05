# 使用 signature_pad 实现数字签名

## 安装

```js
npm install --save signature_pad
```

## 创建组件

```vue
<template>
  <van-popup v-model="show" position="right" get-container="body" lazy-render :overlay="false" :style="{ height: '100%',width:'100%' }">
    <div class="wrap" id="signature-wrap">
      <div v-safeBottom class="button-view">
        <div v-for="(item,i) in btnList" class="btn item" @click="itemClick(i)" :class="{'close-btn':i===0}" :key="i">
          <img class="icon" :src="require(`../img/${item.icon}.png`)" alt="">
          <span class="text">{{item.text}}</span>
        </div>
        <div class="item submit-btn" @click="itemClick(3)">提 交</div>
      </div>
      <div class="canvas-wrap">
        <div class="border">
          <canvas ref="signaturePadCanvas" class="canvas"></canvas>
        </div>
        <p class="tip">请在框里写上您的签名</p>
      </div>
      <sh-loading :loading="loading"></sh-loading>
    </div>
  </van-popup>
</template>

<script>
import { mapState } from 'vuex'
import SignaturePad from "signature_pad";
import { SAVE_PERSON_SIGN, UPLOAD_SINGLE, GET_PERSON_SIGN } from '@/apis/listCommunication'
import { ImagePreview, Dialog } from 'vant';
export default {
  props: {
    fileName: String, //文件名
    signatureId: String, //签名人员 id
    options: { // 配置
      type: Object,
      default: () => {
        return {
          penColor: "#000000",   //笔刷颜色
          minWidth: 0.5,       //最小宽度
          maxWidth: 6,
          backgroundColor: '#f2f2f2'
        }
      }
    }
  },
  components: {
    [ImagePreview.Component.name]: ImagePreview.Component,
  },
  computed: {
    ...mapState(['user'])
  },
  data() {
    return {
      SignaturePad: null,
      fileList: [],
      show: false,
      loading: false,
      btnList: [
        { text: '退出', icon: 'close' },
        { text: '重写', icon: 'refresh' },
        { text: '预览', icon: 'preview' },
      ]
    }
  },
  mounted() {
    // 禁止页面复制
    document.onselectstart = new Function("event.returnValue=false");
  },
  methods: {
    open() {
      this.show = true
      this.$nextTick(() => {
        this.initSign()
      })
    },
    initSign() {
      const canvas = this.$refs.signaturePadCanvas;
      this.signaturePad = new SignaturePad(canvas, this.options);
      // window.addEventListener("resize", this.resizeCanvas);
      this.resizeCanvas();
      this.getSign()
    },
    // 重置写字板
    resizeCanvas() {
      const canvas = this.$refs.signaturePadCanvas;
      const ratio = Math.max(window.devicePixelRatio || 1, 1);
      canvas.width = canvas.offsetWidth * ratio;
      canvas.height = canvas.offsetHeight * ratio;
      canvas.getContext("2d").scale(ratio, ratio);
      this.signaturePad.clear();
    },
    itemClick(i) {
      switch (i) {
        case 0:
          let message = '确认关闭？'
          let confirmButtonText='退出'
          let cancelButtonText='取消'
          if (!this.signaturePad.isEmpty()) {
            message = '当前签名未提交，是否退出？'
          }
          Dialog.confirm({
            title: '提示',
            message,
            confirmButtonText,
            cancelButtonText,
            className: 'sign_close_dialog',
            getContainer: '#signature-wrap'
          })
            .then(() => {
              this.show = false
              this.$emit("cancel");
            })
            .catch(() => {
              // on cancel
            });
          break;
        case 1:
          this.signaturePad.clear();
          break;
        case 2:
          if (this.signaturePad.isEmpty()) {
            this.$toast({
              message: '暂无签名!',
              className: 'sign_empty_toast',
              getContainer: '#signature-wrap'
            })
            return;
          }
          const url = this.signaturePad.toDataURL();
          ImagePreview({
            images: [url],
            closeable: true,
          })
          break;
        case 3:
          if (this.signaturePad.isEmpty()) {
            this.$toast({
              message: '签名为空!',
              className: 'sign_empty_toast',
              getContainer: '#signature-wrap'
            })
            return;
          }
          const data = this.signaturePad.toDataURL();
          let fd = new FormData();
          let blob = this.dataURItoBlob(data, this.fileName);
          fd.append('files' + 1, blob);
          this.uploadFile(fd);
          break;
      }
    },
    // 获取用户签名
    getSign() {
      this.loading = true
      const id = this.signatureId || this.user.id
      this.$post(GET_PERSON_SIGN, { id }, data => {
        this.loading = false
        if (data.data.length && data.data[0].url) {
          this.signaturePad.fromDataURL(data.data[0].url);
        }
      },
        error => {
          this.$toast.fail(error.msg)
          this.loading = false
        }
      )
    },

    // 上传生成的签名图片
    uploadFile(fd) {
      const loading = this.$toast.loading("生成中...");
      this.$post(UPLOAD_SINGLE, fd, data => {
        this.fileList = data.data
        this.saveSign()
        loading.clear();
      }, error => {
        this.$toast.fail(error.msg)
        loading.clear();
      })
    },
    saveSign() {
      this.$post(SAVE_PERSON_SIGN, { fileList: this.fileList }, data => {
        this.$emit("confirm", this.fileList);
        this.$toast.success(data.msg)
        this.show = false
      })
    },
    // 将base64，转换成 file
    dataURItoBlob(dataUrl, filename = 'file') {
      const arr = dataUrl.split(',')
      const mime = arr[0].match(/:(.*?);/)[1]
      const suffix = mime.split('/')[1]
      const bstr = atob(arr[1])
      let n = bstr.length
      const u8arr = new Uint8Array(n)
      while (n--) {
        u8arr[n] = bstr.charCodeAt(n)
      }
      return new File([u8arr], `${filename}.${suffix}`, {
        type: mime
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.wrap {
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: space-between;
}
.border {
  border: 1px dashed #c0c7d4;
  box-sizing: border-box;
  height: 100%;
}
.canvas-wrap {
  height: 100%;
  width: 100%;
  width: calc(100% - 65px);
  padding: 20px 15px 20px 3px;
  position: relative;
  box-sizing: border-box;
  .tip {
    position: absolute;
    transform: rotate(90deg);
    top: 50%;
    left: -52px;
    color: #c0c7d4;
    font-size: 14px;
    z-index: 100;
  }
}
.canvas {
  height: 100%;
  width: 100%;
}
.button-view {
  height: 100%;
  width: 60px;
  box-sizing: border-box;
  display: flex;
  align-items: center;
  justify-content: flex-end;
  flex-direction: column;
  background: #fff;
  padding-top: 35px;
  padding-bottom: 50px;
  position: relative;
  .item {
    transform: rotate(90deg);
  }
  .btn {
    display: flex;
    align-items: center;
    width: 100px;
    height: 40px;
    margin-bottom: 62px;
    .text {
      color: #515e78;
    }
    .icon {
      width: 24px;
      height: 24px;
      margin-right: 6px;
    }
  }
  .close-btn {
    position: absolute;
    top: 45px;
  }
  .submit-btn {
    width: 100px;
    height: 40px;
    border-radius: 4px;
    background-color: #3f7af3;
    color: #fff;
    text-align: center;
    line-height: 40px;
  }
}

#signature-wrap {
  ::v-deep.sign_close_dialog {
    transform: rotate(90deg);
    top: 37%;
    left: 10%;
  }
  ::v-deep.sign_empty_toast {
    transform: rotate(90deg);
    top: 48%;
    left: 37%;
  }
}
</style>
```

## 使用

```js
this.$refs.sign.open()
```