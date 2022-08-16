<template>
  <el-input v-bind='$attrs' v-on="$listeners" :clearable="clearable">
    <template #[slotName] v-for="(slot, slotName) in $slots" >
      <slot :name="slotName" />
    </template>
  </el-input>
</template>

<script>
  export default {
    name:'CzInput',
    props:{
      clearable:{type:Boolean,default:true}
    }
  }
</script>
