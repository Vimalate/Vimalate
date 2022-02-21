<template>
  <el-tooltip :effect="dark" :content="text" :disabled="disableTip" :placement="placement">
    <div class="ellipsis" @mouseover="onMouseOver">
      <span ref="ellipsis" :style="{color:color}" class="text">{{text}}</span>
    </div>
  </el-tooltip>
</template>

<script>
export default {
  name: 'EllipsisTooltip',
  props: {
    text: { type: String, default: '' },
    placement: { type: String, default: 'top-start' },
    effect: { type: String, default: 'dark' },
    color:String
  },
  data() {
    return {
      disableTip: false,
    }
  },
  methods: {
    onMouseOver() {
      let parentWidth = this.$refs['ellipsis'].parentNode.offsetWidth
      let contentWidth = this.$refs['ellipsis'].offsetWidth
      this.disableTip = contentWidth <= parentWidth
    },
  },
}
</script>

<style scoped lang="css">
.ellipsis {
  width: 100%;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}
</style>
