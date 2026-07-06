<template>
    <div class="app-container">
        <!-- 顶部搜索 -->
        <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
            <el-form-item label="联系人" prop="name">
                <el-input
                        v-model="queryParams.name"
                        placeholder="请输入联系人"
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
                  border v-loading="loading" :data="reportList" @selection-change="handleSelectionChange">
            <el-table-column type="selection" width="55" align="center" />
            <el-table-column label="序号" align="center" type="index" :index="indexMethod" />
            <el-table-column label="联系人" align="center" prop="name" />
            <el-table-column label="联系电话" align="center" prop="phone" />
            <el-table-column label="详细地址" align="center" prop="address" />
            <el-table-column label="动物情况" align="center" prop="situation" />
            <el-table-column label="现场图片" align="center" prop="image" width="100">
                <template #default="scope">
                    <image-preview :src="scope.row.image" :width="50" :height="50"/>
                </template>
            </el-table-column>
            <el-table-column label="提交时间" align="center" prop="createTime" />
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

        <!-- 添加或修改动物救助对话框 -->
        <vxe-modal :title="title" v-model="open" width="500px" show-maximize showFooter resize>
            <el-form ref="reportRef" :model="form" :rules="rules" label-width="80px">
                <el-form-item label="联系人" prop="name">
                    <el-input v-model="form.name" placeholder="请输入联系人" />
                </el-form-item>
                <el-form-item label="联系电话" prop="phone">
                    <el-input v-model="form.phone" placeholder="请输入联系电话" />
                </el-form-item>
                <el-form-item label="详细地址" prop="address">
                    <el-input v-model="form.address" type="textarea" placeholder="请输入内容" />
                </el-form-item>
                <el-form-item label="动物情况" prop="situation">
                    <el-input v-model="form.situation" type="textarea" placeholder="请输入内容" />
                </el-form-item>
                <el-form-item label="现场图片" prop="image">
                    <image-upload v-model="form.image"/>
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
import { listReport, getReport, delReport, addReport, updateReport } from "@/api/succour/report"
import {getToken} from "@/utils/auth.js";
import {ElMessage, ElMessageBox} from "element-plus";
const baseURL = import.meta.env.VITE_APP_BASE_API

const queryRef = ref()
const reportRef = ref()
const reportList = ref([])
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
    },
    rules: {
        name: [
            { required: true, message: "联系人不能为空", trigger: "blur" }
        ],
        phone: [
            { required: true, message: "联系电话不能为空", trigger: "blur" }
        ],
        address: [
            { required: true, message: "详细地址不能为空", trigger: "blur" }
        ],
        situation: [
            { required: true, message: "动物情况不能为空", trigger: "blur" }
        ],
    }
})

const { queryParams, form, rules } = toRefs(data)

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
    if((pageNum!==-1 && pageNum!==0)){
        return (index + 1) + (pageNum  * queryParams.value.pageSize);
    }else{
        return (index + 1)
    }
}

/** 查询动物救助列表 */
const getList = () => {
    loading.value = true
    listReport(queryParams.value).then(response => {
        reportList.value = response.rows
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
        reportId: null,
        name: null,
        phone: null,
        address: null,
        situation: null,
        image: null,
        createTime: null
    }
    if (reportRef.value) {
        reportRef.value.resetFields()
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
    ids.value = selection.map(item => item.reportId)
    single.value = selection.length != 1
    multiple.value = !selection.length
}

/** 新增按钮操作 */
const handleAdd = () => {
    reset()
    open.value = true
    title.value = "添加动物救助"
}

/** 修改按钮操作 */
const handleUpdate = (row) => {
    reset()
    const _reportId = row.reportId || ids.value
    getReport(_reportId).then(response => {
        form.value = response.data
        open.value = true
        title.value = "修改动物救助"
    })
}

/** 提交按钮 */
const submitForm = () => {
    reportRef.value.validate(valid => {
        if (valid) {
            if (form.value.reportId != null) {
                updateReport(form.value).then(response => {
                    ElMessage.success("修改成功")
                    open.value = false
                    getList()
                })
            } else {
                addReport(form.value).then(response => {
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
    const _reportIds = row.reportId || ids.value
    ElMessageBox.confirm('是否确认删除该项数据？', '系统提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
    }).then(function() {
        return delReport(_reportIds)
    }).then(() => {
        getList()
        ElMessage.success("删除成功")
    }).catch(() => {})
}

onMounted(() => {
    getList()
})
</script>
