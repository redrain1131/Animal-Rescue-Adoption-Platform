<template>
  <div class="app-container">
    <!-- 顶部搜索 -->
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="90px">
      <el-form-item label="救助站名称" prop="name">
        <el-input
            v-model="queryParams.name"
            placeholder="请输入救助站名称"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="负责人姓名" prop="contactPerson">
        <el-input
            v-model="queryParams.contactPerson"
            placeholder="请输入负责人姓名"
            clearable
            @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="认证用户" prop="userName">
        <el-input
            v-model="queryParams.userName"
            placeholder="请输入认证用户"
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
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
            type="primary"
            plain
            icon="Plus"
            @click="handleAdd"
        >新增
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="success"
            plain
            icon="Edit"
            :disabled="single"
            @click="handleUpdate"
        >修改
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="danger"
            plain
            icon="Delete"
            :disabled="multiple"
            @click="handleDelete"
        >删除
        </el-button>
      </el-col>
    </el-row>

    <!-- 表格 -->
    <el-table @row-click="clickRow" ref="tableRef" highlight-current-row
              border v-loading="loading" :data="stationList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="序号" align="center" type="index" :index="indexMethod"/>
      <el-table-column label="救助站名称" align="center" prop="name"/>
      <el-table-column label="救助站logo" align="center" prop="logo" width="100">
        <template #default="scope">
          <image-preview :src="scope.row.logo" :width="50" :height="50"/>
        </template>
      </el-table-column>
      <el-table-column label="负责人姓名" align="center" prop="contactPerson"/>
      <el-table-column label="联系电话" align="center" prop="phone"/>
      <el-table-column label="电子邮箱" align="center" prop="email"/>
      <el-table-column label="详细地址" align="center" prop="address"/>
      <el-table-column label="救助站描述" align="center" prop="description"/>
      <el-table-column label="营业执照" align="center" prop="businessLicense" width="100">
        <template #default="scope">
          <image-preview :src="scope.row.businessLicense" :width="50" :height="50"/>
        </template>
      </el-table-column>
      <el-table-column label="法人身份证" align="center" prop="idCard" width="100">
        <template #default="scope">
          <image-preview :src="scope.row.idCard" :width="50" :height="50"/>
        </template>
      </el-table-column>
      <el-table-column label="认证用户" align="center" prop="userName"/>
      <el-table-column label="认证提交时间" align="center" prop="createTime"/>
      <el-table-column label="审核状态" align="center" prop="status">
          <template #default="scope">
              <el-tag type="warning" v-if="scope.row.status === '审核中'">{{ scope.row.status }}</el-tag>
              <el-tag type="success" v-if="scope.row.status === '审核通过'">{{ scope.row.status }}</el-tag>
          </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button v-if="scope.row.status === '待审核'" type="success" @click="handleAuth(scope.row)">
              通过认证
          </el-button>
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

    <!-- 添加或修改救助站对话框 -->
    <vxe-modal :title="title" v-model="open" width="500px" show-maximize showFooter resize height="90vh">
      <el-form ref="stationRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="救助站名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入救助站名称"/>
        </el-form-item>
        <el-form-item label="救助站logo" prop="logo">
          <image-upload v-model="form.logo"/>
        </el-form-item>
        <el-form-item label="负责人姓名" prop="contactPerson">
          <el-input v-model="form.contactPerson" placeholder="请输入负责人姓名"/>
        </el-form-item>
        <el-form-item label="联系电话" prop="phone">
          <el-input v-model="form.phone" placeholder="请输入联系电话"/>
        </el-form-item>
        <el-form-item label="电子邮箱" prop="email">
          <el-input v-model="form.email" placeholder="请输入电子邮箱"/>
        </el-form-item>
        <el-form-item label="详细地址" prop="address">
          <el-input v-model="form.address" type="textarea" placeholder="请输入内容"/>
        </el-form-item>
        <el-form-item label="救助站描述" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="请输入内容"/>
        </el-form-item>
        <el-form-item label="营业执照" prop="businessLicense">
          <image-upload v-model="form.businessLicense"/>
        </el-form-item>
        <el-form-item label="法人身份证" prop="idCard">
          <image-upload v-model="form.idCard"/>
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
import {listStation, getStation, delStation, addStation, updateStation, toAuth} from "@/api/succour/station"
import {getToken} from "@/utils/auth.js";
import {ElMessage, ElMessageBox} from "element-plus";

const baseURL = import.meta.env.VITE_APP_BASE_API

const queryRef = ref()
const stationRef = ref()
const stationList = ref([])
const open = ref(false)
const loading = ref(true)
const showSearch = ref(true)
const ids = ref([])
const single = ref(true)
const multiple = ref(true)
const total = ref(0)
const title = ref("")
const selectedRow = ref(null)
const tableRef = ref()

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    name: null,
    contactPerson: null,
    userId: null,
    userName: null
  },
  rules: {
    stationId: [
      {required: true, message: "救助站ID不能为空", trigger: "blur"}
    ],
    name: [
      {required: true, message: "救助站名称不能为空", trigger: "blur"}
    ],
    logo: [
      {required: true, message: "救助站logo不能为空", trigger: "blur"}
    ],
    contactPerson: [
      {required: true, message: "负责人姓名不能为空", trigger: "blur"}
    ],
    phone: [
      {required: true, message: "联系电话不能为空", trigger: "blur"}
    ],
    email: [
      {required: true, message: "电子邮箱不能为空", trigger: "blur"}
    ],
    address: [
      {required: true, message: "详细地址不能为空", trigger: "blur"}
    ],
    description: [
      {required: true, message: "救助站描述不能为空", trigger: "blur"}
    ],
    businessLicense: [
      {required: true, message: "营业执照不能为空", trigger: "blur"}
    ],
    idCard: [
      {required: true, message: "法人身份证不能为空", trigger: "blur"}
    ],
  }
})

const {queryParams, form, rules} = toRefs(data)

//通过认证
const handleAuth = (row) => {
    ElMessageBox.confirm('是否确认通过认证？', '系统提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
    }).then(() => {
        toAuth(row.userId).then(res => {
            getList()
            ElMessage.success("通过认证成功")
        })
    })
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

/** 自定义序号 */
const indexMethod = (index) => {
  let pageNum = queryParams.value.pageNum - 1;
  if ((pageNum !== -1 && pageNum !== 0)) {
    return (index + 1) + (pageNum * queryParams.value.pageSize);
  } else {
    return (index + 1)
  }
}

/** 查询救助站列表 */
const getList = () => {
  loading.value = true
  listStation(queryParams.value).then(response => {
    stationList.value = response.rows
    total.value = response.total
    loading.value = false
  })
}

// 取消按钮
const cancel = () => {
  open.value = false
  reset()
}

// 表单重置
const reset = () => {
  form.value = {
    stationId: null,
    name: null,
    logo: null,
    contactPerson: null,
    phone: null,
    email: null,
    address: null,
    description: null,
    businessLicense: null,
    idCard: null,
    userId: null,
    createTime: null
  }
  if (stationRef.value) {
    stationRef.value.resetFields()
  }
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

// 多选框选中数据
const handleSelectionChange = (selection) => {
  ids.value = selection.map(item => item.stationId)
  single.value = selection.length != 1
  multiple.value = !selection.length
}

/** 新增按钮操作 */
const handleAdd = () => {
  reset()
  open.value = true
  title.value = "添加救助站"
}

/** 修改按钮操作 */
const handleUpdate = (row) => {
  reset()
  const _stationId = row.stationId || ids.value
  getStation(_stationId).then(response => {
    form.value = response.data
    open.value = true
    title.value = "修改救助站"
  })
}

/** 提交按钮 */
const submitForm = () => {
  stationRef.value.validate(valid => {
    if (valid) {
      if (form.value.stationId != null) {
        updateStation(form.value).then(response => {
          ElMessage.success("修改成功")
          open.value = false
          getList()
        })
      } else {
        addStation(form.value).then(response => {
          ElMessage.success("新增成功")
          open.value = false
          getList()
        })
      }
    }
  })
}

/** 删除按钮操作 */
const handleDelete = (row) => {
  const _stationIds = row.stationId || ids.value
  ElMessageBox.confirm('是否确认删除该项数据？', '系统提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(function () {
    return delStation(_stationIds)
  }).then(() => {
    getList()
    ElMessage.success("删除成功")
  }).catch(() => {
  })
}

onMounted(() => {
  getList()
})
</script>
