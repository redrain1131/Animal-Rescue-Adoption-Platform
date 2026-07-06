<template>
  <div class="stations-page">

    <div class="content-wrapper">

      <!-- 救助站列表 -->
      <div class="stations-grid">
        <div
            v-for="station in stationList"
            :key="station.stationId"
            class="station-card"
            @click="viewStationDetail(station)"
        >
          <div class="station-img-wrapper">
            <img :src="baseUrl + station.logo" :alt="station.name" loading="lazy">
          </div>
          <div class="station-info">
            <div class="station-header">
              <h3>{{ station.name }}</h3>
            </div>
            <div class="station-meta">
              <span class="meta-item">
                <el-icon><Location /></el-icon>
                {{ station.address }}
              </span>
              <span class="meta-item">
                <el-icon><Phone /></el-icon>
                {{ station.phone }}
              </span>
            </div>
            <p class="station-desc">{{ station.description }}</p>
          </div>
        </div>
      </div>

    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRouter } from 'vue-router'
import { Location, Phone } from '@element-plus/icons-vue'
import {selectStationListByIsAuth} from "@/api/succour/station.js";

const router = useRouter()

const baseUrl = import.meta.env.VITE_APP_BASE_API

// 模拟救助站数据
const stationList = ref([])

onMounted(() => {
  selectStationListByIsAuth().then(res => {
    stationList.value = res.data
  })
})

// 查看救助站详情
const viewStationDetail = (station) => {
  // 跳转到救助站详情页面
  console.log('查看救助站详情:', station)
  router.push(`/user/stationDetail/${station.stationId}`)
}
</script>

<style scoped>
.stations-page {
  max-width: 1200px;
  margin: 0 auto;
  padding: 20px;
}

.content-wrapper {
  display: flex;
  flex-direction: column;
  gap: 30px;
}

/* --- Station Cards --- */
.stations-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
  gap: 30px;
}

.station-card {
  background: #ffffff;
  border-radius: 24px;
  overflow: hidden;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
  cursor: pointer;
}

.station-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
}

.station-img-wrapper {
  height: 200px;
  position: relative;
  overflow: hidden;
}

.station-img-wrapper img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s;
}

.station-card:hover .station-img-wrapper img {
  transform: scale(1.05);
}

.station-card:hover .station-overlay {
  opacity: 1;
}

.station-info {
  padding: 20px;
}

.station-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
}

.station-header h3 {
  font-size: 20px;
  margin: 0;
}

.station-meta {
  display: flex;
  flex-direction: column;
  gap: 8px;
  margin-bottom: 15px;
}

.meta-item {
  display: flex;
  align-items: center;
  gap: 5px;
  font-size: 14px;
  color: #64748b;
}

.station-desc {
  font-size: 14px;
  color: #64748b;
  line-height: 1.5;
  margin-bottom: 20px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
