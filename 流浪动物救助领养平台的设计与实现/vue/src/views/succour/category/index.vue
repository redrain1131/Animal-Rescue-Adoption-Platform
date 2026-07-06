<template>
  <div>
    <!-- 顶部搜索 -->
    <el-form :model="queryParams" ref="queryRef" :inline="true" label-width="68px">
      <el-form-item label="分类名称" prop="name">
        <el-input
            v-model="queryParams.name"
            placeholder="请输入分类名称"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <!-- 顶部按钮 -->
    <el-row :gutter="10" style="padding: 10px 0">
      <el-col :span="1.5">
        <el-button
            type="primary"
            plain
            icon="Plus"
            @click="handleAdd"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="success"
            plain
            icon="Edit"
            :disabled="single"
            @click="handleUpdate"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="danger"
            plain
            icon="Delete"
            :disabled="multiple"
            @click="handleDelete"
        >删除</el-button>
      </el-col>
    </el-row>

    <!-- 表格 -->
    <el-table @row-click="clickRow" ref="tableRef" highlight-current-row
              border v-loading="loading" :data="categoryList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="序号" align="center" type="index" :index="indexMethod"/>
      <el-table-column label="分类名称" align="center" prop="name"/>
      <el-table-column label="排序" align="center" prop="sort"/>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页组件 -->
    <pagination
        v-show="total>0"
        :total="total"
        v-model:page="queryParams.pageNum"
        v-model:limit="queryParams.pageSize"
        @pagination="getList"
    />

    <!-- 添加或修改萌宠分类对话框 -->
    <vxe-modal :title="title" v-model="open" width="500px" show-maximize showFooter resize>
      <el-form ref="categoryRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="分类名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入分类名称" />
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input-number style="width: 100%;" v-model="form.sort" placeholder="请输入排序" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </vxe-modal>

  </div>
</template>

<script setup>
import {onMounted, ref} from 'vue'
import {addCategory, getCategory, listCategory, updateCategory, delCategory} from "@/api/succour/category.js";
import {ElMessage, ElMessageBox} from "element-plus";

//表单校验
const rules = ref({
  name: [
    { required: true, message: "分类名称不能为空", trigger: "blur" }
  ],
  sort: [
    { required: true, message: "排序不能为空", trigger: "blur" }
  ]
})

//对话框是否打开
const open = ref(false)

//表单参数
const form = ref({})

//表单实例
const categoryRef = ref()

//表单对话框title名称
const title = ref("")

//当前选中的行
const selectedRow = ref(null)

//当前选中的行的ID数组
const ids = ref([])

//当前是否未选中单行
const single = ref(true)

//当前是否未选中多行
const multiple = ref(true)

//表格实例
const tableRef = ref()

//条件查询表单实例
const queryRef = ref()

/** 新增按钮操作 */
const handleAdd = () => {
  reset()
  open.value = true
  title.value = "添加萌宠分类"
}

/** 修改按钮操作 */
const handleUpdate = (row) => {
  reset()
  const categoryId = row.categoryId || ids.value
  getCategory(categoryId).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改萌宠分类"
  })
}

/** 删除按钮操作 */
const handleDelete = (row) => {
  const categoryIds = row.categoryId || ids.value
  ElMessageBox.confirm('是否确认删除该项数据？', '系统提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(function() {
    return delCategory(categoryIds)
  }).then(() => {
    getList()
    ElMessage.success("删除成功")
  }).catch(() => {})
}

// 表单重置
const reset = () => {
  form.value = {
    categoryId: null,
    name: null,
    sort: null
  }
  if (categoryRef.value) {
    categoryRef.value.resetFields()
  }
}

// 取消按钮
const cancel = () => {
  open.value = false
  reset()
}

/** 提交按钮 */
const submitForm = () => {
  categoryRef.value.validate(valid => {
    if (valid) {
      if (form.value.categoryId != null) {
        //修改时提交
        updateCategory(form.value).then(res => {
          ElMessage.success("修改成功")
          open.value = false
          getList()
        })
      } else {
        //新增时提交
        addCategory(form.value).then(res => {
          ElMessage.success("新增成功")
          open.value = false
          getList()
        })
      }
    }
  })
}

/** 自定义序号 */
const indexMethod = (index) => {
  let pageNum = queryParams.value.pageNum - 1;
  if ((pageNum !== -1 && pageNum !== 0)) {
    return (index + 1) + (pageNum * queryParams.value.pageSize);
  } else {
    return (index + 1)
  }
}

//点击行 获取行
const clickRow = (row) => {
  selectedRow.value = row; // 更新选中的行
  const table = tableRef.value;
  // 清除所有已选中的行
  table.clearSelection();
  // 选中当前点击的行
  table.toggleRowSelection(row, true);
}

/** 搜索按钮操作 */
const handleQuery = () => {
  queryParams.value.pageNum = 1
  getList()
}

/** 重置按钮操作 */
const resetQuery = () => {
  queryRef.value.resetFields()
  handleQuery()
}

//查询参数
const queryParams = ref({
  pageNum: 1,
  pageSize: 10,
  name: null
})

// 多选框选中数据
const handleSelectionChange = (selection) => {
  ids.value = selection.map(item => item.categoryId)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

//加载状态
const loading = ref(false)

//列表数据
const categoryList = ref([])

//列表数据总数
const total = ref(0)

//查询列表数据
const getList = () => {
  loading.value = true
  listCategory(queryParams.value).then(response => {
    categoryList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

onMounted(() => {
  getList()
})
</script>

<style scoped>

</style>
