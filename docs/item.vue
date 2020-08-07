<template>
  <div class="inspection-item">
    <div class="name">
      <span>XXXXX检查项目</span>
      <van-checkbox v-model="isChecked"></van-checkbox>
    </div>
    <div class="desc">
      <span>巡检专家 | 刘秀宝</span>
      <span>日期 | 2020-03-08</span>
    </div>
  </div>
</template>

<script>
export default {
    name:'InspectionItem',
    props:{
        isChecked:Boolean
    },
    data() {
        return {
        }
    },
    computed: {
        // isChecked
    },
};
</script>

<style lang="less" scoped>
 .inspection-item {
        margin-top: 10px;
      display: flex;
      flex-direction: column;
      width: 95%;
      box-sizing: border-box;
      border: 1px solid #eee;
      font-size: 14px;
      padding:0 10px;
      box-shadow: 0 5px 8px lightgray ;
      .name {
        display: flex;
        height: 40px;
        font-weight: 600;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #eee;
      }
      .desc {
        display: flex;
        height: 60px;
        justify-content: space-between;
        align-items: center;
        font-size: 12px;
      }
    }
</style>