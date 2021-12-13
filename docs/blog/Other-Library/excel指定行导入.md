## 编写一个组件

```vue
<template>
  <div class="upload">
    <el-upload class="upload" action :multiple="false" :show-file-list="false" accept="csv, application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" :http-request="httpRequest">
        <el-button type="primary">{{title}}</el-button>
    </el-upload>
  </div>

</template>

<script>
import XLSX from 'xlsx' // 引入xlsx
export default {
  props: {
    title: {
      type: String,
      default: '导入'
    },
    rowStart: Number
  },
  data() {
    return {
      tableData: []
    }
  },
  methods: {
    httpRequest(e) {
      const file = e.file // 文件信息
      if (!file) {
        // 没有文件
        return false
      } else if (!/\.(xls|xlsx)$/.test(file.name.toLowerCase())) {
        // 格式根据自己需求定义
        this.$message.error('上传格式不正确，请上传xls或者xlsx格式')
        return false
      }
      const fileReader = new FileReader()
      fileReader.onload = ev => {
        try {
          const data = ev.target.result
          const workbook = XLSX.read(data, {
            type: 'binary' // 以字符编码的方式解析
          })
          const exlname = workbook.SheetNames[0] // 取第一张表


          if (this.rowStart) {
            const xlsxLth = workbook.Sheets[exlname]["!ref"];//获取!ref属性值
            const stopX = xlsxLth.substr(xlsxLth.indexOf(':') + 1, workbook.Sheets[exlname]["!ref"].length);
            workbook.Sheets[exlname]["!ref"] = `A${this.rowStart}:` + stopX //从第几行开始读取
          }

          const exl = XLSX.utils.sheet_to_json(workbook.Sheets[exlname]) // 生成json表格内容
          this.$emit('callback', exl)

        } catch (e) {
          this.$message.error('出错了！')
          return false
        }
      }
      fileReader.readAsBinaryString(file)
    },

  }
}
</script>

<style lang="scss" scoped>
.upload {
  margin-left: 6px;
}
</style>
```

## 使用

```vue
...
<UploadExcel :rowStart='2' @callback="importExcel" title='导入' v-if="!disabled"></UploadExcel>
...

importExcel(data) {
  const list = data.map(item => {
    return {
      materialName: item['费用名称'],
      materialCode: item['费用编号'],
      classifyName: item['费用分类'],
      categoryName: item['类别'],
      measureUnit: item['单位'],
      monthAccount: item['数量'],
      monthUnitPrice: item['单价（元）'],
      monthPrice: item['合价（元）'],
      remarks: item['备注'],
    }
  })
  // this.form.costActualDetail = [...this.forcostActualDetail, ...list]
  this.form.costActualDetail = this.$removeDuplica(this.form.costActualDetail, list, 'materialCode')
},
```