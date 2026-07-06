<template>
  <div class="auth-page">
    <div class="content-wrapper">

      <!-- 审核中状态显示 -->
      <div v-if="isAuth" class="auth-status pending">
        <el-result icon="info"
                   title="审核中"
                   sub-title="您的认证申请已提交，我们将在7个工作日内完成审核，审核通过后会进行电话告知，请耐心等待。"/>
      </div>

      <!-- 未认证状态显示 -->
      <div v-else>
        <div class="auth-steps">
          <el-steps :active="currentStep" finish-status="success" align-center>
            <el-step title="基本信息"></el-step>
            <el-step title="资质证明"></el-step>
            <el-step title="提交审核"></el-step>
          </el-steps>
        </div>
        <br>

        <div class="auth-form-container">
          <!-- 第一步：基本信息 -->
          <div v-show="currentStep === 0" class="form-step">
            <div class="step-title">救助站基本信息</div>
            <el-form :model="form" :rules="rules" ref="oneForm" label-width="120px">
              <el-form-item label="救助站logo" prop="logo">
                <image-upload v-model="form.logo"/>
              </el-form-item>

              <el-form-item label="救助站名称" prop="name">
                <el-input v-model="form.name" placeholder="请输入救助站名称"></el-input>
              </el-form-item>

              <el-form-item label="负责人姓名" prop="contactPerson">
                <el-input v-model="form.contactPerson" placeholder="请输入负责人姓名"></el-input>
              </el-form-item>

              <el-form-item label="联系电话" prop="phone">
                <el-input v-model="form.phone" placeholder="请输入联系电话"></el-input>
              </el-form-item>

              <el-form-item label="电子邮箱" prop="email">
                <el-input v-model="form.email" placeholder="请输入电子邮箱"></el-input>
              </el-form-item>

              <el-form-item label="详细地址" prop="address">
                <el-input
                    v-model="form.address"
                    type="textarea"
                    placeholder="请输入详细地址"
                    :rows="3"
                ></el-input>
              </el-form-item>

              <el-form-item label="救助站简介" prop="description">
                <el-input
                    v-model="form.description"
                    type="textarea"
                    placeholder="请简要介绍救助站的情况"
                    :rows="4"
                ></el-input>
              </el-form-item>
            </el-form>

            <div class="step-actions">
              <el-button type="primary" @click="nextStep(0)">下一步</el-button>
            </div>
          </div>

          <!-- 第二步：资质证明 -->
          <div v-show="currentStep === 1" class="form-step">
            <div class="step-title">上传资质证明</div>
            <el-form :model="form" :rules="rules" ref="twoForm" label-width="120px">
              <el-form-item label="营业执照" prop="businessLicense">
                <image-upload v-model="form.businessLicense"/>
              </el-form-item>

              <el-form-item label="法人身份证" prop="idCard">
                <image-upload v-model="form.idCard"/>
              </el-form-item>

            </el-form>

            <div class="step-actions">
              <el-button @click="prevStep">上一步</el-button>
              <el-button type="primary" @click="nextStep(1)">下一步</el-button>
            </div>
          </div>

          <!-- 第三步：提交审核 -->
          <div v-show="currentStep === 2" class="form-step">
            <div class="step-title">确认信息并提交</div>
            <div class="review-section">
              <h3>基本信息</h3>
              <el-descriptions :column="1" border>
                <el-descriptions-item label="救助站logo">
                  <image-preview :src="form.logo" :width="50" :height="50"/>
                </el-descriptions-item>
                <el-descriptions-item label="救助站名称">{{ form.name }}</el-descriptions-item>
                <el-descriptions-item label="负责人">{{ form.contactPerson }}</el-descriptions-item>
                <el-descriptions-item label="联系电话">{{ form.phone }}</el-descriptions-item>
                <el-descriptions-item label="电子邮箱">{{ form.email }}</el-descriptions-item>
                <el-descriptions-item label="详细地址">{{ form.address }}</el-descriptions-item>
                <el-descriptions-item label="救助站简介">{{ form.description }}</el-descriptions-item>
              </el-descriptions>

              <h3 style="margin-top: 30px;">资质证明</h3>
              <el-descriptions :column="1" border>
                <el-descriptions-item label="营业执照">
                  <image-preview :src="form.businessLicense" :width="50" :height="50"/>
                </el-descriptions-item>

                <el-descriptions-item label="法人身份证">
                  <image-preview :src="form.idCard" :width="50" :height="50"/>
                </el-descriptions-item>

              </el-descriptions>
            </div>

            <div class="step-actions">
              <el-button @click="prevStep">上一步</el-button>
              <el-button
                  type="primary"
                  @click="submitAuth"
                  :loading="loading"
              >
                提交认证
              </el-button>
            </div>
          </div>
        </div>
      </div>

    </div>
  </div>
</template>

<script setup>
import {ref, onMounted} from 'vue'
import {ElMessage, ElMessageBox} from 'element-plus'
import {addStation, selectIsAuth} from "@/api/succour/station.js";

const currentStep = ref(0)
const loading = ref(false)
const isAuth = ref(false)

// 表单参数
const form = ref({
  name: null,
  logo: null,
  contactPerson: null,
  phone: null,
  email: null,
  address: null,
  description: null,
  businessLicense: null,
  idCard: null,
})

// 表单验证规则
const rules = {
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

// 表单引用
const oneForm = ref()
const twoForm = ref()

// 步骤控制
const nextStep = async (step) => {
  if (step === 0) {
    // 验证第一步表单
    await oneForm.value.validate((valid) => {
      if (valid) {
        currentStep.value++
      } else {
        ElMessage.error('请完善基本信息')
      }
    })
  } else if (step === 1) {
    // 验证第二步表单
    await twoForm.value.validate((valid) => {
      if (valid) {
        currentStep.value++
      } else {
        ElMessage.error('请完善资质信息')
      }
    })
  }
}

const prevStep = () => {
  currentStep.value--
}

// 提交认证
const submitAuth = () => {
  loading.value = true

  addStation(form.value).then(response => {
    loading.value = false
    ElMessageBox.alert('您的认证申请已提交，我们将在7个工作日内完成审核，请留意站内消息。', '提交成功', {
      confirmButtonText: '确定',
      type: 'success'
    }).then(() => {
      getAuth()
      // 重置表单
      currentStep.value = 0
      form.value = {
        name: null,
        logo: null,
        contactPerson: null,
        phone: null,
        email: null,
        address: null,
        description: null,
        businessLicense: null,
        idCard: null,
      }
    })
  }).catch(() => {
    loading.value = false
  })
}

const getAuth = () => {
  selectIsAuth().then(res => {
    isAuth.value = res.data
  })
}

// 页面加载时检查是否提交认证
onMounted(() => {
  getAuth()
})
</script>

<style scoped>
.auth-page {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

.content-wrapper {
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.auth-steps {
  background: #fff;
  padding: 30px;
  border-radius: 24px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.auth-form-container {
  background: #ffffff;
  border-radius: 24px;
  padding: 30px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.form-step {
  display: flex;
  flex-direction: column;
  gap: 25px;
}

.step-title {
  font-size: 24px;
  color: #2c3e50;
  font-weight: bold;
  margin-bottom: 10px;
}

.step-actions {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin-top: 30px;
}

.review-section h3 {
  color: #2c3e50;
  margin-bottom: 15px;
}

.auth-status {
  background: #ffffff;
  border-radius: 24px;
  padding: 30px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  text-align: center;
}
</style>
