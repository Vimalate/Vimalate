<template>
  <el-input-number class="sh-input-number" style="width: 100%" v-bind="$attrs" v-on="$listeners" :controls='controls' :value='insideValue' @input="$emit('input',$event)"></el-input-number>
</template>

<script>
export default {
  name: 'NumberInput',
  props: {
    value: [String, Number],
    controls: {
      type: Boolean,
      default: false
    }
  },
  computed: {
    insideValue() {
      return typeof this.value === 'number' ? this.value : undefined
    }
  }
}
</script>

<style lang="css" scoped>
.sh-input-number .el-input__inner {
  text-align: left;
}
</style>
