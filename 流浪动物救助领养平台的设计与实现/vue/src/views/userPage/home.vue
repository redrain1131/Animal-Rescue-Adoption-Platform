<template>
    <div>
        <div class="hero-section">
            <el-carousel
                :interval="5000"
                arrow="always"
                indicator-position="none"
                height="100%"
                autoplay
            >
                <el-carousel-item v-for="item in bannerList" :key="item.bannerId">
                    <img :src="baseUrl + item.image" alt="轮播图" class="carousel-image">
                </el-carousel-item>
            </el-carousel>
            <div class="hero-bg-overlay"></div>
            <div class="hero-glass-card">
                <span class="badge">❤️ 每一个生命都值得被温柔以待</span>
                <h1 class="hero-title">用爱终止流浪<br>给它们一个温暖的家</h1>
                <p class="hero-desc">
                    每一份领养，都是爱的延续。
                </p>
                <div class="hero-btn">
                    <el-button class="custom-btn btn-filled" @click="scrollToSection()">
                        寻找你的缘分
                    </el-button>
                </div>
            </div>
        </div>

        <div class="content-section" id="adopt-section">
            <div class="section-header">
                <h2 class="section-title">遇见你的 <span class="hand-write">Soulmate</span></h2>
            </div>

            <div class="animals-grid">
                <div
                        v-for="animal in animalList"
                        :key="animal.animalId"
                        class="pet-card"
                        @click="showAnimalDetail(animal)"
                >
                    <div class="pet-img-wrapper">
                        <img :src="baseUrl + animal.image" :alt="animal.name" loading="lazy">
                        <div class="pet-status-badge">
                            {{ animal.status }}
                        </div>
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
                            <span class="tag">{{ animal.breed }}</span>
                        </div>
                        <p class="pet-desc">{{ animal.description }}</p>
                    </div>
                </div>
            </div>

            <div class="center-action">
                <el-button class="custom-btn btn-ghost" icon="ArrowRight" @click="router.push('/user/animal')">浏览全部萌宠</el-button>
            </div>
        </div>

    </div>
</template>

<script setup>
import {ref} from 'vue'
import {useRouter} from 'vue-router'
import {Female, Male} from "@element-plus/icons-vue";
import {listBanner} from "@/api/succour/banner.js";
import {listAnimal} from "@/api/succour/animal.js";

const baseUrl = import.meta.env.VITE_APP_BASE_API

const router = useRouter()

// 轮播图数据
const bannerList = ref([])

const scrollToSection = () => {
    const el = document.getElementById(`adopt-section`)
    if (el) el.scrollIntoView({behavior: 'smooth', block: 'start'})
}

// 跳转到萌宠详情页面
const showAnimalDetail = (animal) => {
    router.push(`/index/detail/${animal.id}`)
}

const animalList = ref([])

//查询参数
const query = ref({
    pageNum: 1,
    pageSize: 4,
    status: '可领养'
})

onMounted(() => {
    listBanner().then(res => {
        bannerList.value = res.rows
    })

    listAnimal(query.value).then(res => {
        animalList.value = res.rows
    })

})
</script>

<style scoped>
.hero-section {
    position: relative;
    height: 93vh;
    min-height: 600px;
    display: flex;
    align-items: center;
    justify-content: center;
}

:deep(.el-carousel) {
    width: 100%;
    height: 100%;
    position: absolute;
    top: 0;
    left: 0;
}

:deep(.el-carousel__container) {
    height: 100%;
}

:deep(.el-carousel__item) {
    height: 100%;
}

.carousel-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    position: relative;
}

.hero-bg-overlay {
    position: absolute;
    inset: 0;
    background: linear-gradient(135deg, rgba(0, 0, 0, 0.4) 0%, rgba(0, 0, 0, 0.1) 100%);
}

.hero-glass-card {
    background: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(12px);
    padding: 40px 60px;
    border-radius: 30px;
    border: 1px solid #FFFFFF4C;
    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
    max-width: 700px;
    color: #fff;
    text-align: left; /* 左对齐更有现代感 */
}

.badge {
    display: inline-block;
    background: rgba(255, 255, 255, 0.2);
    padding: 5px 15px;
    border-radius: 20px;
    font-size: 14px;
    margin-bottom: 20px;
}

.hero-title {
    font-size: 48px;
    line-height: 1.2;
    margin-bottom: 20px;
    font-weight: 800;
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.hero-desc {
    font-size: 18px;
    opacity: 0.9;
    margin-bottom: 30px;
    line-height: 1.6;
}

.hero-btn {
    display: flex;
    gap: 15px;
}

.custom-btn {
    padding: 12px 32px;
    border-radius: 50px;
    border: none;
    font-size: 16px;
    font-weight: 700;
    cursor: pointer;
    transition: transform 0.2s, box-shadow 0.2s;
}

.btn-filled {
    background: #ff8e6e;
    color: #ffffff;
    box-shadow: 0 10px 20px rgba(255, 142, 110, 0.4);
}

.btn-filled:hover {
    background: #e66a4c;
    transform: translateY(-2px);
}

/* --- Content General --- */
.content-section {
    padding: 80px 20px;
    max-width: 1200px;
    margin: 0 auto;
}

.section-header {
    text-align: center;
    margin-bottom: 50px;
}

.section-title {
    font-size: 36px;
    color: #2c3e50;
    margin-bottom: 15px;
}

.hand-write {
    font-family: 'Zcool KuaiLe', cursive;
    color: #ff8e6e;
}

/* --- Animal Cards --- */
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
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);;
}

.pet-img-wrapper {
    height: 240px;
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

.pet-status-badge {
    position: absolute;
    top: 15px;
    left: 15px;
    background: rgba(255, 255, 255, 0.9);
    padding: 4px 12px;
    border-radius: 10px;
    font-size: 12px;
    font-weight: bold;
    color: #2c3e50;
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

.center-action {
    text-align: center;
    margin-top: 50px;
}

.btn-ghost {
    background: transparent;
    border: 2px solid #64748b;
    color: #64748b;
}

.btn-ghost:hover {
    transform: translateY(-2px);
}
</style>
