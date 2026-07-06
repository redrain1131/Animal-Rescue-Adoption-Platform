<template>
    <div class="emergency-page">

        <div class="content-wrapper">
            <div class="emergency-info">
                <div class="info-card urgent">
                    <h2>紧急情况处理</h2>
                    <p>如果您遇到以下情况，请立即拨打我们的紧急救助热线：</p>
                    <ul>
                        <li>动物严重受伤或生病</li>
                        <li>动物被困无法自行脱困</li>
                        <li>恶劣天气下的流浪动物</li>
                        <li>遭遇虐待或忽视的动物</li>
                        <li>其他危及动物生命的紧急状况</li>
                    </ul>
                    <div class="hotline">
                        <el-button type="danger" size="large" disabled>
                            <el-icon>
                                <Phone/>
                            </el-icon>
                            紧急救助热线：400-123-4567
                        </el-button>
                    </div>
                </div>

                <div class="info-card reporting">
                    <p>您也可以通过填写以下表单向我们报告需要救助的动物：</p>
                    <el-form :model="form" :rules="rules" ref="formRef" label-width="100px">
                        <el-form-item label="联系人" prop="name">
                            <el-input v-model="form.name" placeholder="请输入您的姓名"/>
                        </el-form-item>

                        <el-form-item label="联系电话" prop="phone">
                            <el-input v-model="form.phone" placeholder="请输入您的联系电话"/>
                        </el-form-item>

                        <el-form-item label="详细地址" prop="address">
                            <el-input
                                    v-model="form.address"
                                    placeholder="请输入动物所在的具体地址"
                                    type="textarea"
                                    :rows="3"
                            />
                        </el-form-item>

                        <el-form-item label="动物情况" prop="situation">
                            <el-input
                                    v-model="form.situation"
                                    placeholder="请详细描述动物的状态和面临的危险"
                                    type="textarea"
                                    :rows="4"
                            />
                        </el-form-item>

                        <el-form-item label="现场图片">
                            <image-upload v-model="form.image"/>
                        </el-form-item>

                        <el-form-item>
                            <el-button type="primary" @click="submit">提交救助</el-button>
                            <el-button @click="resetForm">重置</el-button>
                        </el-form-item>
                    </el-form>
                </div>
            </div>

            <div class="sidebar">
                <div class="guidelines">
                    <h3>救助指南</h3>
                    <div class="guide-steps">
                        <div class="guide-step">
                            <div class="step-number">1</div>
                            <div class="step-content">
                                <h4>确保自身安全</h4>
                                <p>在接近受伤或受惊的动物时务必小心，避免被咬伤或抓伤</p>
                            </div>
                        </div>

                        <div class="guide-step">
                            <div class="step-number">2</div>
                            <div class="step-content">
                                <h4>初步评估</h4>
                                <p>观察动物的状况，判断是否需要紧急医疗救助</p>
                            </div>
                        </div>

                        <div class="guide-step">
                            <div class="step-number">3</div>
                            <div class="step-content">
                                <h4>联系专业人员</h4>
                                <p>拨打我们的紧急热线或提交在线报告</p>
                            </div>
                        </div>

                        <div class="guide-step">
                            <div class="step-number">4</div>
                            <div class="step-content">
                                <h4>提供必要帮助</h4>
                                <p>在专业人员到达前，尽可能提供水和遮蔽物</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="faq">
                    <h3>常见问题</h3>
                    <div class="faq-item">
                        <h4>报告后多久会有回应？</h4>
                        <p>紧急情况我们会在30分钟内联系您，非紧急情况会在24小时内回复。</p>
                    </div>

                    <div class="faq-item">
                        <h4>救助服务收费吗？</h4>
                        <p>我们的紧急救助服务是免费的，但可能需要您协助运输动物到救助站。</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import {ref} from 'vue'
import {ElMessage} from 'element-plus'
import {Phone} from '@element-plus/icons-vue'
import {addReport} from "@/api/succour/report.js";

// 报告表单引用
const formRef = ref()

// 报告表单数据
const form = ref({
    name: null,
    phone: null,
    address: null,
    situation: null,
    image: null
})

// 表单验证规则
const rules = {
    name: [
        {required: true, message: '请输入联系人姓名', trigger: 'blur'}
    ],
    phone: [
        {required: true, message: '请输入联系电话', trigger: 'blur'}
    ],
    address: [
        {required: true, message: '请输入详细地址', trigger: 'blur'}
    ],
    situation: [
        {required: true, message: '请描述动物情况', trigger: 'blur'}
    ]
}

// 提交报告
const submit = () => {
    formRef.value.validate((valid) => {
        if (valid) {
            addReport(form.value).then(res => {
                ElMessage.success('报告提交成功！我们会尽快与您联系。')
                resetForm()
            })
        }
    })
}

// 重置表单
const resetForm = () => {
    formRef.value.resetFields()
    form.value.image = null
}
</script>

<style scoped>
.emergency-page {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}

.content-wrapper {
    display: flex;
    gap: 30px;
}

.emergency-info {
    flex: 3;
    display: flex;
    flex-direction: column;
    gap: 30px;
}

.info-card {
    background: #ffffff;
    border-radius: 24px;
    padding: 30px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.info-card.urgent {
    border-left: 5px solid #f56c6c;
}

.info-card.reporting {
    border-left: 5px solid #409eff;
}

.info-card h2 {
    font-size: 24px;
    color: #2c3e50;
    margin-bottom: 20px;
}

.info-card p {
    color: #64748b;
    line-height: 1.8;
    margin-bottom: 20px;
}

.info-card ul {
    padding-left: 20px;
    margin-bottom: 30px;
}

.info-card li {
    margin-bottom: 10px;
    color: #64748b;
}

.hotline {
    text-align: center;
}

.hotline .el-button {
    padding: 20px 40px;
    font-size: 18px;
    font-weight: bold;
}

.sidebar {
    flex: 1;
    display: flex;
    flex-direction: column;
    gap: 30px;
}

.guidelines {
    background: #ffffff;
    border-radius: 24px;
    padding: 25px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.guidelines h3 {
    font-size: 20px;
    color: #2c3e50;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 1px solid #eee;
}

.guide-steps {
    display: flex;
    flex-direction: column;
    gap: 25px;
}

.guide-step {
    display: flex;
    gap: 15px;
    align-items: flex-start;
}

.step-number {
    width: 30px;
    height: 30px;
    border-radius: 50%;
    background: #409eff;
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    flex-shrink: 0;
    margin-top: 3px;
}

.step-content h4 {
    color: #2c3e50;
    margin-bottom: 5px;
    margin-top: 0;
}

.step-content p {
    color: #64748b;
    font-size: 14px;
    line-height: 1.6;
    margin: 0;
}

.faq {
    background: #ffffff;
    border-radius: 24px;
    padding: 25px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.faq h3 {
    font-size: 20px;
    color: #2c3e50;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 1px solid #eee;
}

.faq-item {
    margin-bottom: 20px;
}

.faq-item:last-child {
    margin-bottom: 0;
}

.faq-item h4 {
    color: #2c3e50;
    margin-bottom: 10px;
    font-size: 16px;
}

.faq-item p {
    color: #64748b;
    font-size: 14px;
    line-height: 1.6;
    margin: 0;
}
</style>
