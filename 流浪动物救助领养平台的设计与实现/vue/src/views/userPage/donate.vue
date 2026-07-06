<template>
  <div class="donate-page">

    <div class="content-wrapper">
      <div class="donation-intro">
        <div class="intro-card">
          <h2>为什么需要您的帮助</h2>
          <p>我们是一个非营利性的流浪动物救助组织，致力于为无家可归的动物提供临时庇护、医疗救治和寻找新家的服务。运营这样一个救助站需要大量的资金支持，包括：</p>
          <ul>
            <li>动物的日常食物和营养补充</li>
            <li>疫苗接种和疾病治疗费用</li>
            <li>救助设备和设施建设维护</li>
            <li>志愿者交通和工作补贴</li>
          </ul>
          <p>您的慷慨捐赠将直接用于改善这些毛孩子的生存环境和生活质量。</p>
        </div>
      </div>

      <div class="donation-methods">
        <h2 class="section-title">选择捐赠方式</h2>
        <div class="methods-grid">
          <!-- 微信支付 -->
          <div class="method-card" @click="selectMethod('wechat')">
            <div class="method-icon">
              <div class="placeholder-icon wechat">微信</div>
            </div>
            <h3>微信支付</h3>
            <p>使用微信扫一扫即可捐赠</p>
            <div class="qr-code" v-if="selectedMethod === 'wechat'">
              <img class="placeholder-qr" src="@/assets/images/login-background.jpg" alt="">
              <p class="qr-tip">请使用微信扫描上方二维码进行捐赠</p>
            </div>
          </div>

          <!-- 支付宝 -->
          <div class="method-card" @click="selectMethod('alipay')">
            <div class="method-icon">
              <div class="placeholder-icon alipay">支付宝</div>
            </div>
            <h3>支付宝</h3>
            <p>使用支付宝扫一扫即可捐赠</p>
            <div class="qr-code" v-if="selectedMethod === 'alipay'">
                <img class="placeholder-qr" src="@/assets/images/login-background.jpg" alt="">
              <p class="qr-tip">请使用支付宝扫描上方二维码进行捐赠</p>
            </div>
          </div>

          <!-- 银行卡转账 -->
          <div class="method-card" @click="selectMethod('bank')">
            <div class="method-icon">
              <div class="placeholder-icon bank">银行卡</div>
            </div>
            <h3>银行卡转账</h3>
            <p>通过银行转账进行捐赠</p>
            <div class="bank-details" v-if="selectedMethod === 'bank'">
              <div class="bank-info-item">
                <span class="label">开户银行：</span>
                <span class="value">中国工商银行北京分行</span>
              </div>
              <div class="bank-info-item">
                <span class="label">账户名称：</span>
                <span class="value">北京流浪动物救助中心</span>
              </div>
              <div class="bank-info-item">
                <span class="label">银行账号：</span>
                <span class="value account-number">1111 2222 3333 4444 555</span>
              </div>
              <div class="bank-info-item">
                <span class="label">转账备注：</span>
                <span class="value">请注明"动物救助捐款"</span>
              </div>
              <p class="bank-tip">转账完成后请联系客服确认，谢谢您的爱心！</p>
            </div>
          </div>
        </div>
      </div>

      <div class="donation-tips">
        <h3>捐赠须知</h3>
        <ul>
          <li>所有捐赠均为公益性质，不可撤销</li>
          <li>捐赠金额不限，每一分都将用于动物救助事业</li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const selectedMethod = ref('')

const selectMethod = (method) => {
  if (selectedMethod.value === method) {
    selectedMethod.value = ''
  } else {
    selectedMethod.value = method
  }
}
</script>

<style scoped>
.donate-page {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

.content-wrapper {
  display: flex;
  flex-direction: column;
  gap: 40px;
}

.donation-intro {
  text-align: center;
}

.intro-card {
  background: #ffffff;
  border-radius: 24px;
  padding: 30px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.intro-card h2 {
  font-size: 28px;
  color: #2c3e50;
  margin-bottom: 20px;
}

.intro-card p {
  font-size: 16px;
  color: #64748b;
  line-height: 1.8;
  margin-bottom: 20px;
  text-align: left;
}

.intro-card ul {
  text-align: left;
  margin: 20px 0;
  padding-left: 20px;
}

.intro-card li {
  margin-bottom: 10px;
  color: #64748b;
}

.section-title {
  font-size: 28px;
  color: #2c3e50;
  text-align: center;
  margin-bottom: 30px;
}

.methods-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 30px;
}

.method-card {
  background: #ffffff;
  border-radius: 24px;
  padding: 30px 20px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  text-align: center;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
}

.method-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
}

.method-card h3 {
  font-size: 22px;
  color: #2c3e50;
  margin: 20px 0 10px;
}

.method-card p {
  color: #64748b;
  font-size: 14px;
  margin-bottom: 15px;
}

.placeholder-icon {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto;
  font-size: 16px;
  font-weight: bold;
  color: white;
}

.wechat {
  background: #2DC100;
}

.alipay {
  background: #1677ff;
}

.bank {
  background: #5b8c00;
}

.qr-code {
  margin-top: 20px;
  padding-top: 20px;
  border-top: 1px dashed #eee;
}

.placeholder-qr {
  width: 200px;
  height: 200px;
  margin: 0 auto 15px;
  background: #f5f5f5;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #999;
}

.qr-tip {
  font-size: 14px;
  color: #ff8e6e;
  font-weight: 500;
}

.bank-details {
  margin-top: 20px;
  padding-top: 20px;
  border-top: 1px dashed #eee;
  text-align: left;
}

.bank-info-item {
  display: flex;
  margin-bottom: 15px;
  font-size: 14px;
}

.label {
  font-weight: bold;
  color: #2c3e50;
  width: 80px;
}

.value {
  color: #64748b;
  flex: 1;
}

.account-number {
  font-family: monospace;
  letter-spacing: 1px;
}

.bank-tip {
  font-size: 14px;
  color: #ff8e6e;
  font-weight: 500;
  margin-top: 15px;
}

.donation-tips {
  background: #f8f9fa;
  border-radius: 24px;
  padding: 30px;
}

.donation-tips h3 {
  font-size: 22px;
  color: #2c3e50;
  margin-bottom: 20px;
  text-align: center;
}

.donation-tips ul {
  padding-left: 20px;
}

.donation-tips li {
  margin-bottom: 10px;
  color: #64748b;
  line-height: 1.6;
}
</style>
