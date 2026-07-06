<template>
    <div class="station-detail-page">
        <div class="detail-header">
            <el-page-header @back="goBack" :content="station.name">
            </el-page-header>
        </div>

        <div class="detail-content">
            <!-- 救助站基本信息 -->
            <div class="station-card">
                <div class="station-image-section">
                    <img :src="baseUrl + station.logo" :alt="station.name" class="station-main-image">
                </div>

                <div class="station-info-section">
                    <div class="station-basic-info">
                        <h1 class="station-name">{{ station.name }}</h1>
                        <div class="station-meta">
                            <span class="meta-item">
                              <el-icon><Location/></el-icon>
                              {{ station.address }}
                            </span>
                            <span class="meta-item">
                              <el-icon><Phone/></el-icon>
                              {{ station.phone }}
                            </span>
                        </div>
                    </div>

                    <div class="station-description">
                        <h3>救助站介绍</h3>
                        <p>{{ station.description }}</p>
                    </div>

                    <div class="station-stats">
                        <div class="stat-item">
                            <span class="stat-number">{{ animalList.length }}</span>
                            <span class="stat-label">可领养</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 救助站可领养的动物列表 -->
            <div class="station-animals-section">
                <h2>该救助站可领养的动物</h2>

                <div v-if="animalList.length > 0" class="animals-grid">
                    <div
                            v-for="animal in animalList"
                            :key="animal.animalId"
                            class="pet-card"
                            @click="viewAnimalDetail(animal)"
                    >
                        <div class="pet-img-wrapper">
                            <img :src="baseUrl + animal.image" :alt="animal.name" loading="lazy">
                        </div>
                        <div class="pet-info">
                            <div class="pet-header">
                                <h3>{{ animal.name }}</h3>
                                <span class="gender-icon" :class="animal.gender === '公' ? 'male' : 'female'">
                                  <el-icon>
                                    <Male v-if="animal.gender === '公'"/>
                                    <Female v-else/>
                                  </el-icon>
                                </span>
                            </div>
                            <div class="pet-tags">
                                <span class="tag">{{ animal.age }}</span>
                            </div>
                            <p class="pet-desc">{{ animal.description }}</p>
                        </div>
                    </div>
                </div>

                <div v-else class="no-animals">
                    <p>该救助站暂无可供领养的动物</p>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import {computed, onMounted, ref} from 'vue'
import {useRoute, useRouter} from 'vue-router'
import {Female, Location, Male, Phone} from '@element-plus/icons-vue'
import {getStation} from "@/api/succour/station.js";
import {selectAnimalListByStationId} from "@/api/succour/animal.js";

const baseUrl = import.meta.env.VITE_APP_BASE_API

const route = useRoute()
const router = useRouter()

// 动物数据
const animalList = ref([])

// 返回上一页
const goBack = () => {
    router.go(-1)
}

// 查看动物详情
const viewAnimalDetail = (animal) => {
    router.push(`/user/animalDetail/${animal.animalId}`)
}

// 救助站数据
const station = ref({})

onMounted(() => {
    getStation(route.params.id).then(res => {
        station.value = res.data
    })

    //根据救助站ID查询该救助站的可领养动物
    selectAnimalListByStationId(route.params.id).then(res => {
        animalList.value = res.data
    })
})
</script>

<style scoped>
.station-detail-page {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
    min-height: calc(100vh - 60px);
}

.detail-header {
    margin-bottom: 20px;
}

.detail-content {
    display: flex;
    flex-direction: column;
    gap: 30px;
}

.station-card {
    display: flex;
    background: white;
    border-radius: 24px;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.station-image-section {
    flex: 1;
    min-height: 400px;
}

.station-main-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.station-info-section {
    flex: 1;
    padding: 30px;
    display: flex;
    flex-direction: column;
    gap: 25px;
}

.station-name {
    font-size: 32px;
    margin: 0 0 10px 0;
    color: #2c3e50;
}

.station-meta {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    margin-bottom: 15px;
}

.meta-item {
    display: flex;
    align-items: center;
    gap: 5px;
    color: #64748b;
    font-size: 14px;
}

.station-description h3 {
    font-size: 20px;
    margin: 0 0 15px 0;
    color: #2c3e50;
}

.station-description p {
    color: #64748b;
    line-height: 1.6;
    margin: 0;
}

.station-stats {
    display: flex;
    justify-content: space-around;
    background: #f8f9fa;
    border-radius: 12px;
    padding: 20px;
    margin-top: 10px;
}

.stat-item {
    text-align: center;
}

.stat-number {
    display: block;
    font-size: 24px;
    font-weight: bold;
    color: #2c3e50;
    margin-bottom: 5px;
}

.stat-label {
    font-size: 14px;
    color: #64748b;
}

.station-animals-section h2 {
    font-size: 24px;
    margin: 0 0 20px 0;
    color: #2c3e50;
}

.animals-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
    gap: 30px;
}

.pet-card {
    background: #ffffff;
    border-radius: 24px;
    overflow: hidden;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
    transition: all 0.3s ease;
    cursor: pointer;
}

.pet-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
}

.pet-img-wrapper {
    height: 200px;
    position: relative;
    overflow: hidden;
}

.pet-img-wrapper img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s;
}

.pet-card:hover .pet-img-wrapper img {
    transform: scale(1.05);
}

.pet-card:hover .pet-overlay {
    opacity: 1;
}

.pet-info {
    padding: 20px;
}

.pet-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
}

.pet-header h3 {
    font-size: 20px;
    margin: 0;
}

.gender-icon {
    width: 24px;
    height: 24px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
    color: #ffffff;
}

.gender-icon.male {
    background: #89CFF0;
}

.gender-icon.female {
    background: #FFB7B2;
}

.pet-tags {
    display: flex;
    gap: 8px;
    margin-bottom: 12px;
}

.tag {
    background: #f8f9fa;
    padding: 4px 10px;
    border-radius: 8px;
    font-size: 12px;
    color: #64748b;
}

.pet-desc {
    font-size: 13px;
    color: #64748b;
    line-height: 1.5;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

.no-animals {
    text-align: center;
    padding: 40px;
    color: #64748b;
    font-size: 16px;
}
</style>
