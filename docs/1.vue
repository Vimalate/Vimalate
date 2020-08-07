<template>
  <div>
    <nav-bar class="head" :barProps="barProps" @click-left="goBack"></nav-bar>
    <div class="main">
      <van-tabs type="card" color="#3C85F7">
        <van-tab title="专项检查" badge="未处理">
          <van-pull-refresh v-model="refreshing" @refresh="onRefresh">
            <van-list
              v-model="loading"
              :finished="finished"
              finished-text="没有更多了"
              @load="onLoad"
              class="list"
            >
              <van-cell-group class="data-cart">
                <van-cell title="XXXX检查项目">
                  <template #extra>
                    <van-checkbox v-model="checked"></van-checkbox>
                  </template>
                </van-cell>
                <van-cell title="检查时间范围" class="time">
                  <template #extra>
                    <span>7-26</span>-
                    <span>8-7</span>
                  </template>
                </van-cell>
              </van-cell-group>
              <InspectionItem :isChecked="isChecked" />
            </van-list>
          </van-pull-refresh>
          <div class="submit" @click="goInspectionDetail">
            <van-button class="submit-btn" block type="info" native-type="submit">提交</van-button>
          </div>
        </van-tab>
        <van-tab title="历史记录">内容 2</van-tab>
      </van-tabs>
    </div>
  </div>
</template>

<script>
// 检查项目
import InspectionItem from "@/components/program/businessComponents/specialInspection/InspectionItem.vue";
export default {
  data() {
    return {
      barProps: {
        title: "专项检查",
        leftArrow: true,
        classStyle: "blue",
      },
      checked: true,
      isChecked: true,
      list: [],
      loading: false,
      finished: false,
      refreshing: false,
    };
  },
  components: {
    InspectionItem,
  },
  methods: {
    goBack() {},
    goInspectionDetail(){
        
    },
    onLoad() {
      setTimeout(() => {
        if (this.refreshing) {
          this.list = [];
          this.refreshing = false;
        }

        for (let i = 0; i < 10; i++) {
          this.list.push(this.list.length + 1);
        }
        this.loading = false;

        if (this.list.length >= 40) {
          this.finished = true;
        }
      }, 1000);
    },
    onRefresh() {
      // 清空列表数据
      this.finished = false;

      // 重新加载数据
      // 将 loading 设置为 true，表示处于加载状态
      this.loading = true;
      this.onLoad();
    },
  },
};
</script>

<style lang="less" scoped>
.main {
  margin-top: 46px;
  .list {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    margin-top: 10px;
    .data-cart {
      width: 95%;
      border: 1px solid #eee;
      box-shadow: 0 5px 8px lightgray ;
    }
  }
}
.submit {
  margin-top: 50px;
  display: flex;
  justify-content: center;
}
.submit-btn {
  width: 80vw;
}
.time {
  span {
    margin-right: 20px;
  }
}
</style>